Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279629AbRK0OSv>; Tue, 27 Nov 2001 09:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279778AbRK0OSn>; Tue, 27 Nov 2001 09:18:43 -0500
Received: from hermes.domdv.de ([193.102.202.1]:59909 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S279629AbRK0OSY>;
	Tue, 27 Nov 2001 09:18:24 -0500
Message-ID: <XFMail.20011127151356.ast@domdv.de>
X-Mailer: XFMail 1.5.1 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <01112715491900.00872@manta>
Date: Tue, 27 Nov 2001 15:13:56 +0100 (CET)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: RE: [BUG] 2.4.16pre1: minix initrd does not work, ext2 does
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, no pointer but the same effect with 2.4.15pre7 and romfs (as posted
earlier to the list). It seems initrd handling is fs type picky :-(

Just to repeat myself:

1. the romfs initrd is fine, loop mounting it works.
2. the romfs initrd is detected at boot time.
3. the romfs initrd is not root mounted at boot time, thus without a root fs
   the kernel panics.
4. Doing the same with an ext2 initrd works fine.

Not really nice for systems where the only reason ext2 is compiled in the kernel
is this initrd behaviour.

On 27-Nov-2001 vda wrote:
> Hi,
> 
> I have 2 slackware initrds, one with minix fs on it, other with ext2.
> 
> I compiled 2.4.13 and it panics (can't mount root fs) (don't remember with 
> both initrds or only with minix one...).
> 
> I copied .config to 2.4.10, did make oldconfig and all that other reqd makes,
> and it boots both initrds.
> 
> Finally I tried it with 2.4.16pre1 (came .config again) 
> and it cannot mount minix initrd.
> ("FAT: bogus sector size 0","VFS: unable to mount root fs")
> I further tested and that initrd CAN be mounted by 2.4.16pre1 
> over loopback device with
> 
># mount -o loop /tmp/initrd.minix /mnt/mnt
> 
> and
> 
># mount -t fat,minix -o loop /tmp/initrd.minix /mnt/mnt
> 
> (so we can't blame FAT for first saying "Yes it's fat, don't probe for 
> others" and then "it is corrupted, can't use")
> 
> Seems there is some problem with fs detection order during root fs mount.
> (minix isn't tried at all?) However, I failed to grok what affect order of fs
> type guessing at boot... can somebody point me where to look?
> --
> vda
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH
