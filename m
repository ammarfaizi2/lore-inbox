Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129207AbQJ3UJn>; Mon, 30 Oct 2000 15:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129273AbQJ3UJb>; Mon, 30 Oct 2000 15:09:31 -0500
Received: from cr355197-a.poco1.bc.wave.home.com ([24.112.113.88]:52721 "EHLO
	whiskey.enposte.net") by vger.kernel.org with ESMTP
	id <S129086AbQJ3UJT>; Mon, 30 Oct 2000 15:09:19 -0500
To: linux-kernel@vger.kernel.org
Path: whiskey.fireplug.net!not-for-mail
From: sl@whiskey.fireplug.net (Stuart Lynne)
Newsgroups: list.linux-kernel
Subject: Re: / on ramfs, possible?
Date: 30 Oct 2000 12:09:36 -0800
Organization: fireplug
Distribution: local
Message-ID: <8tkki0$v0p$1@whiskey.enposte.net>
In-Reply-To: <200010300727.IAA12250@hell.wii.ericsson.net>
Reply-To: sl@fireplug.net
X-Newsreader: trn 4.0-test67 (15 July 1998)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200010300727.IAA12250@hell.wii.ericsson.net>,
Anders Eriksson <aer-list@mailandnews.com> wrote:
>--==_Exmh_17293564P
>Content-Type: text/plain; charset=us-ascii
>
>
>I want my / to be a ramfs filesystem. I intend to populate it from an 
>initrd image, and then remount / as the ramfs filesystem. Is that at 
>all possible? The way I see it the kernel requires / on a device 
>(major,minor) or nfs.
>
>Am I out of luck using ramfs as /? If it's easy to fix, how do I fix it?

Yes it works.

You will need pivot_root. 

Something like the following at the end of your initrd /linuxrc script 
should mount your ramfs, copy the existing root fs files to it, pivot
and unmount your old root. YMMV
 
    mkdir -p /ramfs /ram1
    mount -t ramfs /ramfs /ramfs
    find / | sed '/^\/ramfs/d;/^\/proc\/.*/d' | cpio -pdmV /ramfs
    cd /ramfs
    pivot_root . ram1
    exec chroot . sh -c 'umount /ram1; exit' < dev/console >dev/console


BTW has anyone thought of writing a small utility to emulate df for ramfs?

-- 
                                            __O 
Fireplug - a Lineo company                _-\<,_ 
PGP Fingerprint: 28 E2 A0 15 99 62 9A 00 (_)/ (_) 88 EC A3 EE 2D 1C 15 68
Stuart Lynne <sl@fireplug.net>       www.fireplug.net        604-461-7532
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
