Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264426AbTE0XFN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 19:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264429AbTE0XFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 19:05:12 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:8846 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP id S264426AbTE0XFJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 19:05:09 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
Organization: ( )
To: <viro@parcelfarce.linux.theplanet.co.uk>, <florin@iucha.net>,
       <liste@jordet.nu>, <olivn@trollprod.org>
Subject: Re: [PATCH] Re: ALSA problems: sound lockup, modules, 2.5.70
Date: Tue, 27 May 2003 17:22:39 -0400
User-Agent: KMail/1.5.2
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305271722.39088.ivg2@cornell.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for thread - not subscribed.

I solved all of my modules problems and every single one of them was my fault, 
combined with a minimalistic modprobe.conf syntax (no aliases to aliases? ) 
and devfs.

Lockups, however, are still there, and the patch did not help.
Here's some straces:

XMMS freezes on the following system call (attempt to stop a playing mp3):

gettimeofday({1054069621, 452855}, NULL) = 0
ioctl(3, FIONREAD, [0])                 = 0
poll([{fd=3, events=POLLIN, revents=POLLIN}, {fd=5, events=POLLIN}], 2, 9) = 1
gettimeofday({1054069621, 456248}, NULL) = 0
ioctl(3, FIONREAD, [32])                = 0
read(3, "\5\1\352\20\312V-\0\256\0\0\0\32\0\340\0\0\0\0\0n\0\226"..., 32) = 32
write(3, "\33\0\2\0\0\0\0\0+ \1\0", 12) = 12
read(3, "\1\2\354\20\0\0\0\0\32\0\340\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 32) = 32
write(3, ">\0\7\0\207\0\340\0\30\0\340\0005\0\340\0\0\0\0\0\0\0\0"..., 992) = 
992
read(3, "\1\2\23\21\0\0\0\0\32\0\340\0\0\0\0\0\0\0\0\0\0\0\0\0p"..., 32) = 32
uname({sys="Linux", node="cobra", ...}) = 0
futex(0x42cb2e18, FUTEX_WAIT, 3882, NULL
\

XINE freezes on startup, and here's the beginning of a repeating sequence 
that says Timeout.

ioctl(3, FIONREAD, [0])                 = 0
select(4, [3], NULL, NULL, {0, 33000})  = 1 (in [3], left {0, 28000})
ioctl(3, FIONREAD, [32])                = 0
read(3, "\10\3\252\v\333\2100\0\256\0\0\0\16\0\340\0\0\0\0\0\21"..., 32) = 32
ioctl(3, FIONREAD, [0])                 = 0
select(4, [3], NULL, NULL, {0, 33000})  = 1 (in [3], left {0, 3000})
futex(0x811a9d8, FUTEX_WAIT, 2, NULL)   = 0
futex(0x811a9d8, FUTEX_WAKE, 1, NULL)   = 0
futex(0x811a9b0, FUTEX_WAIT, 2, NULL)   = 0
futex(0x811a9d8, FUTEX_WAIT, 2, NULL)   = 0
futex(0x811a9d8, FUTEX_WAKE, 1, {144394552, 135234584}) = 0
ioctl(3, FIONREAD, [0])                 = 0
select(4, [3], NULL, NULL, {0, 33000})  = 0 (Timeout)
ioctl(3, FIONREAD, [0])                 = 0
select(4, [3], NULL, NULL, {0, 33000})  = 1 (in [3], left {0, 16000})
futex(0x811a9d8, FUTEX_WAIT, 2, NULL)   = 0
futex(0x811a9d8, FUTEX_WAKE, 1, NULL)   = 0
futex(0x811a9b0, FUTEX_WAIT, 3, NULL)   = 0
futex(0x811a9d8, FUTEX_WAIT, 2, NULL)   = 0
futex(0x811a9d8, FUTEX_WAKE, 1, {144394552, 135234584}) = 0
ioctl(3, FIONREAD, [0])                 = 0
select(4, [3], NULL, NULL, {0, 33000})  = 0 (Timeout)
ioctl(3, FIONREAD, [0])                 = 0
select(4, [3], NULL, NULL, {0, 33000})  = 1 (in [3], left {0, 16000})
futex(0x811a9d8, FUTEX_WAIT, 2, NULL)   = 0
futex(0x811a9d8, FUTEX_WAKE, 1, NULL)   = 0
futex(0x811a9b0, FUTEX_WAIT, 4, NULL)   = 0
futex(0x811a9d8, FUTEX_WAIT, 2, NULL)   = 0
futex(0x811a9d8, FUTEX_WAKE, 1, {144394552, 135234584}) = 0

is this info useful at all?


