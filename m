Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbTJRWdE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 18:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbTJRWdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 18:33:04 -0400
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:51042 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261891AbTJRWdB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 18:33:01 -0400
Date: Sun, 19 Oct 2003 00:32:41 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <aradorlinux@yahoo.es>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reproduceable oops in -test8
Message-Id: <20031019003241.66bceaa0.aradorlinux@yahoo.es>
In-Reply-To: <20031018215729.GK25291@holomorphy.com>
References: <20031018234848.51a2b723.aradorlinux@yahoo.es>
	<20031018215729.GK25291@holomorphy.com>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sat, 18 Oct 2003 14:57:29 -0700 William Lee Irwin III <wli@holomorphy.com> escribió:

> Might be best to post the oops from mainline. I've made substantial
> /proc/ changes, so they may not be related.


Sure, I'm sorry. Still I haven't got an oops under test8 but the symptoms
are the same:

o esd is running.
o Run totem. The first time it doesn't hang.
o run totem again. It'll stop in 
  open("/dev/dsp", O_WRONLY|O_NONBLOCK|O_LARGEFILE
  So, it seems that esd is blocking the access to /dev/dsp; so I've
  to kill it (very common when you use esd)

o but killall esd hangs too:

open("/proc/570/stat", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401d8000
read(3, "570 (gconfd-2) S 1 530 482 1025 "..., 1024) = 192
close(3)                                = 0
munmap(0x401d8000, 4096)                = 0
open("/proc/572/stat", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401d8000
read(3, 
and it hangs here

o If you run ps ax, i'll hang too:
stat64("/proc/572", {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
open("/proc/572/stat", O_RDONLY)        = 6
read(6, 

o If you're running gnome; it'll hang because it wants to make noise and it's
  waiting for /dev/dsp to be freed


I wasn't able to get an oops; the one which happened in -wli1 may be unrelated
as wli said; but I'll continue trying to reproduce it.
