Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130515AbRC0ETE>; Mon, 26 Mar 2001 23:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130519AbRC0ESy>; Mon, 26 Mar 2001 23:18:54 -0500
Received: from cr355197-a.poco1.bc.wave.home.com ([24.112.113.88]:52220 "EHLO
	whiskey.enposte.net") by vger.kernel.org with ESMTP
	id <S130515AbRC0ESs>; Mon, 26 Mar 2001 23:18:48 -0500
To: linux-kernel@vger.kernel.org
Path: whiskey.fireplug.net!not-for-mail
From: sl@whiskey.fireplug.net (Stuart Lynne)
Newsgroups: list.linux-kernel
Subject: Re: question \ information request on init \ boot sequence when using initrd
Date: 26 Mar 2001 20:17:11 -0800
Organization: fireplug
Distribution: local
Message-ID: <99p487$18m$1@whiskey.enposte.net>
In-Reply-To: <985660830.32357@whiskey.enposte.net>
Reply-To: sl@fireplug.net
X-Newsreader: trn 4.0-test67 (15 July 1998)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <985660830.32357@whiskey.enposte.net>,
Amit D Chaudhary <amit@muppetlabs.com> wrote:
>Hi,
>
>We(my team) had some questions regarding booting from initrd and using 
>/linuxrc. It will help someone(David, Werner,...) can give their 
>thoughts on this.
>
>To put it in brief, since running sbin/init from /linuxrc as resulting 
>in init not having PID 1 and thereby not doing some initialization as 
>expected.
>
>Thereby instead of loading running /sbin/init, we just set 
>/proc/sys/kernel/real-root-dev to /dev/ram0's value which then does the 
>following
>runs 2 statements in init/main.c to unlock_kernel and free init memory 
>and then run sbin/init.
>This results in /sbin/init running fine.
>
>Is this ok or should be modify /sbin/init to run properly inspite of PID 
><> 1 or is there a 3rd way of doing this?
>
>
>mkdir initrd
>../bin/pivot_root . initrd
>
>exec sbin/chroot . sbin/init.new 3 <dev/console >dev/console 2>&1
>
>
>The above results in init running with PID != 1 and thereby skipping 
>some relevant processing my default. see ps output below:
>
>Instead of the "chroot" above is changed to following
>exec sbin/chroot . sh -c 'bin/mount proc proc -t proc; echo 0x01000000 > 
>proc/sys/kernel/real-root-dev'
>And linuxrc exits
>
>
>
>(none):root> ps -e
>   PID TTY          TIME CMD
>     1 ?        00:00:04 swapper
>     2 ?        00:00:00 keventd
>     3 ?        00:00:00 kswapd
>     4 ?        00:00:00 kreclaimd
>     5 ?        00:00:00 bdflush
>     6 ?        00:00:00 kupdate
>     7 ?        00:00:00 mtdblockd
>     8 ?        00:00:00 init
>    26 ?        00:00:00 sh
>    39 ?        00:00:00 portmap
>    50 ?        00:00:00 ypbind
>    51 ?        00:00:00 ypbind
>    84 ?        00:00:00 inetd
>    93 ?        00:00:00 syslogd
>   100 ?        00:00:00 klogd
>   119 ?        00:00:00 ps


You can run your linuxrc with:

	init=/linuxrc

and then end your /linuxrc with:

	exec /sbin/init

-- 
                                            __O 
Lineo - For Embedded Linux Solutions      _-\<,_ 
PGP Fingerprint: 28 E2 A0 15 99 62 9A 00 (_)/ (_) 88 EC A3 EE 2D 1C 15 68
Stuart Lynne <sl@fireplug.net>       www.fireplug.net        604-461-7532
