Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264563AbUBOOvl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 09:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264933AbUBOOvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 09:51:41 -0500
Received: from jolt.tiscali.fi ([213.173.154.10]:14761 "EHLO jolt.tiscali.fi")
	by vger.kernel.org with ESMTP id S264563AbUBOOvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 09:51:40 -0500
Message-ID: <402F877C.C9B693C1@users.sourceforge.net>
Date: Sun, 15 Feb 2004 16:51:40 +0200
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jan Rychter <jan@rychter.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oopsing cryptoapi (or loop device?) on 2.6.*
References: <402A4B52.1080800@centrum.cz> <402A7765.FD5A7F9E@users.sourceforge.net> <m265e9oyrs.fsf@tnuctip.rychter.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Rychter wrote:
> FWIW, I've just tried loop-AES with 2.4.24, after using cryptoapi for a
> number of years. My machine froze dead in the midst of copying 2.8GB of
> data onto my file-backed reiserfs encrypted loopback mount.
> 
> Since the system didn't ever freeze on me before and since I've had zero
> problems with cryptoapi, I attribute the freeze to loop-AES.
> 
> Yes, I know this isn't a good bugreport...

Is there any particular reason why you insist on using file backed loops?

File backed loops have hard to fix re-entry problem: GFP_NOFS memory
allocations that cause dirty pages to written out to file backed loop, will
have to re-enter the file system anyway to complete the write. This causes
deadlocks. Same deadlocks are there in mainline loop+cryptoloop combo.

This is one of the reasons why this is in loop-AES README: "If you can
choose between device backed and file backed, choose device backed even if
it means that you have to re-partition your disks."

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
