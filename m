Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268074AbUGWVVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268074AbUGWVVe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 17:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268073AbUGWVVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 17:21:34 -0400
Received: from web50609.mail.yahoo.com ([206.190.38.248]:3493 "HELO
	web50609.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268074AbUGWVVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 17:21:32 -0400
Message-ID: <20040723212131.86635.qmail@web50609.mail.yahoo.com>
Date: Fri, 23 Jul 2004 14:21:31 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: Ext3 problems in dual booting machine with SE Linux 
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200407232046.i6NKkZ5V003482@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Fix your boot to not use /dev/root, but an actual partition number.

Thanks for the suggestion, but booting is fine.

>What's happening is that /dev/sda3 is *both* your /mnt/target *and* your
>root filesystem.  So when you start rm -rf'ing, you trash your root filesystem
>and things go pear-shaped.

/dev/sda2 is / under 2.4
/dev/sda3 is /mnt/target under 2.4
/dev/sda3 is / under 2.6 
2.6 doesn't mount /dev/sda2.

title Red Hat Linux (2.4.20-31.9smp)
        root (hd1,0)
        kernel /vmlinuz-2.4.20-31.9smp ro root=/dev/sda2 hdd=ide-scsi
        initrd /initrd-2.4.20-31.9smp.img
title Test (2.6.7)
        root (hd1,2)
        kernel /boot/vmlinuz-2.6.7-1.437.build ro root=0803 hdd=ide-scsi
        initrd /boot/initrd-2.6.7-1.437.build.img

They both use different fstabs.

The problem is not that I trash my root filesystem under 2.4, my problem is I
cannot unmount /mnt/target after I have been in SE Linux and ran fixfiles. My
method of recovery is to remove files from /mnt/target until I get corruption
detected at boot which finally lets me run mke2fs to get it back.

What I really wished is that I can unmount the filesystem, run mke2fs, remount it
and start doing whatever. My root filesystem is fine. /mnt/target is fine as long
as I don't run fixfiles.

BUT...this does point out the corruption that I have come to depend on...which is
wrong.

Best Regards,
-Steve Grubb


	
		
__________________________________
Do you Yahoo!?
Vote for the stars of Yahoo!'s next ad campaign!
http://advision.webevents.yahoo.com/yahoo/votelifeengine/
