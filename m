Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbWGBAuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbWGBAuc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 20:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbWGBAub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 20:50:31 -0400
Received: from terminus.zytor.com ([192.83.249.54]:16563 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030185AbWGBAub
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 20:50:31 -0400
Message-ID: <44A71840.8040904@zytor.com>
Date: Sat, 01 Jul 2006 17:50:08 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>, "H. Peter Anvin" <hpa@zytor.com>,
       Linus Torvalds <torvalds@osdl.org>, Jeff Bailey <jbailey@ubuntu.com>,
       Michael Tokarev <mjt@tls.msk.ru>, Roman Zippel <zippel@linux-m68k.org>,
       klibc@zytor.com, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [klibc] klibc and what's the next step?
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <Pine.LNX.4.64.0606271316220.17704@scrub.home> <20060630181131.GA1709@elf.ucw.cz> <44A5AE17.4080106@tls.msk.ru> <44A5B07E.9040007@zytor.com> <1151751417.2553.8.camel@localhost.localdomain> <20060701150506.GA10517@thunk.org> <Pine.LNX.4.64.0607011306060.12404@g5.osdl.org> <20060702000528.GA15375@thunk.org> <44A7108D.6090204@zytor.com> <20060702003815.GB15375@thunk.org>
In-Reply-To: <20060702003815.GB15375@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
> 
> Well, I wouldn't be one of those folks.  In fact, how big is dash and
> some select set of shell utilities?  If they aren't that big, it might
> make sense to include them all the time so that a simple command-line
> option on boot is all that's necessary in order to break into a
> pre-kinit interactive shell.  That would make the resulting system
> more debuggable by definition.  Then all we will would have to do is
> make sure the distro's use the kernel-supplied kinit solution, instead
> of rolling their own non-standard version.
> 

Shared binaries, x86-64 (i386 is about 20-25% smaller):

-rwxrwxr-x 1 hpa hpa 58544 Jul  1 11:41 usr/dash/sh.shared*
-rwxrwxr-x 1 hpa hpa  2760 Jul  1 11:41 cat*
-rwxrwxr-x 1 hpa hpa   888 Jul  1 11:41 chroot*
-rwxrwxr-x 1 hpa hpa  4000 Jul  1 11:41 dd*
-rwxrwxr-x 1 hpa hpa   680 Jul  1 11:41 false*
-rwxrwxr-x 3 hpa hpa  1072 Jul  1 11:41 halt*
-rwxrwxr-x 1 hpa hpa  1664 Jul  1 11:41 insmod*
-rwxrwxr-x 1 hpa hpa  1336 Jul  1 11:41 ln*
-rwxrwxr-x 1 hpa hpa  5000 Jul  1 11:41 minips*
-rwxrwxr-x 1 hpa hpa  1984 Jul  1 11:41 mkdir*
-rwxrwxr-x 1 hpa hpa  1704 Jul  1 11:41 mkfifo*
-rwxrwxr-x 1 hpa hpa  1712 Jul  1 11:41 mknod*
-rwxrwxr-x 1 hpa hpa  2184 Jul  1 11:41 mount
-rwxrwxr-x 1 hpa hpa  1320 Jul  1 11:41 nuke*
-rwxrwxr-x 1 hpa hpa   856 Jul  1 11:41 pivot_root*
-rwxrwxr-x 3 hpa hpa  1072 Jul  1 11:41 poweroff*
-rwxrwxr-x 3 hpa hpa  1072 Jul  1 11:41 reboot*
-rwxrwxr-x 1 hpa hpa   864 Jul  1 11:41 sleep*
-rwxrwxr-x 1 hpa hpa   672 Jul  1 11:41 true*
-rwxrwxr-x 1 hpa hpa  1056 Jul  1 11:41 umount*
-rwxrwxr-x 1 hpa hpa  1952 Jul  1 11:41 uname*
-rw-rw-r-- 2 hpa hpa 71016 Jul  1 11:40 
usr/klibc/klibc-Yy9wepARlc-x17pdZDwU1YCOiMQ.so
-rwxrwxr-x 1 hpa hpa 35664 Jul  1 17:48 usr/kinit/kinit.shared*

... totalling about 193K if you include everything.  For comparison, 
static kinit by itself is 67K (which includes ipconfig, nfsroot, etc.) 
For an "include everything" variant, it would probably make more sense 
to port busybox, and/or add more tools as dash builtins.

All of these are uncompressed sizes.

	-hpa
