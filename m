Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314106AbSDLUku>; Fri, 12 Apr 2002 16:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314128AbSDLUkt>; Fri, 12 Apr 2002 16:40:49 -0400
Received: from hera.cwi.nl ([192.16.191.8]:30386 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S314106AbSDLUkt>;
	Fri, 12 Apr 2002 16:40:49 -0400
From: Andries.Brouwer@cwi.nl
Date: Fri, 12 Apr 2002 20:40:44 GMT
Message-Id: <UTC200204122040.UAA608889.aeb@cwi.nl>
To: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org, mark.post@eds.com
Subject: Re: PROBLEM: kernel mount of initrd fails unless mke2fs uses 1024 byt e blocks
Cc: alan@lxorguk.ukuu.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        From: "Post, Mark K" <mark.post@eds.com>

        [1.] One line summary of the problem:
            Trying to use an initrd for an installation fails unless the mke2fs
        used a blocksize of 1024 bytes.

        [2.] Full description of the problem/report:
            I'm trying to create a Linux for S/390 version 2.2.20 installation
        kernel/ramdisk set.  When I create the ramdisk, if I issue the mke2fs
        command with -b 2048 or -b 4096, it works fine.  But, I try to boot the
        system, I get an "EXT2-fs: Magic mismatch, very weird !" error when the
        kernel tries to mount the ramdisk as the root file system.  If I let the
        blocksize default, or specify -b 1024, everything works fine.

        The comparison that seems to be failing is at line 500 of
        linux/fs/ext/super.c:
                        if (es->s_magic != le16_to_cpu(EXT2_SUPER_MAGIC)) {
                                printk ("EXT2-fs: Magic mismatch, very weird !\n");
                                goto failed_mount;

I answered:

    I once submitted a patch for this, but apparently it is not in 2.2.20.

but was too hasty.
I recalled a buglet here, that was fixed in 2.4 and is still in 2.2,
and indeed, there is such a buglet, but your problem is elsewhere.

The kernel does set_blocksize() to change the blocksize of your
device. This set_blocksize() throws away all buffers with the
now incorrect size. But your device is a ramdisk, and throwing
out these buffers kills all your data.
So, after doing that, you have an empty ramdisk again.
Hence mount fails.

Andries


