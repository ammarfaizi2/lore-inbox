Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314137AbSDLVB0>; Fri, 12 Apr 2002 17:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314138AbSDLVBZ>; Fri, 12 Apr 2002 17:01:25 -0400
Received: from ahmler4.mail.eds.com ([192.85.154.77]:34251 "EHLO
	ahmler4.mail.eds.com") by vger.kernel.org with ESMTP
	id <S314137AbSDLVBZ>; Fri, 12 Apr 2002 17:01:25 -0400
Message-ID: <564DE4477544D411AD2C00508BDF0B6A0C9DD15C@usahm018.exmi01.exch.eds.com>
From: "Post, Mark K" <mark.post@eds.com>
To: "'Andries.Brouwer@cwi.nl'" <Andries.Brouwer@cwi.nl>,
        linux-kernel@vger.kernel.org
Subject: RE: PROBLEM: kernel mount of initrd fails unless mke2fs uses 1024
	 byt e blocks
Date: Fri, 12 Apr 2002 17:01:13 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.51)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries,

Thanks for the update.  So, what do I do now?  Wait for a fix for 2.2?  Send
my problem report to someone else?  Let me know.

Mark Post

-----Original Message-----
From: Andries.Brouwer@cwi.nl [mailto:Andries.Brouwer@cwi.nl]
Sent: Friday, April 12, 2002 4:41 PM
To: Andries.Brouwer@cwi.nl; linux-kernel@vger.kernel.org;
mark.post@eds.com
Cc: alan@lxorguk.ukuu.org.uk
Subject: Re: PROBLEM: kernel mount of initrd fails unless mke2fs uses
1024 byt e blocks



        From: "Post, Mark K" <mark.post@eds.com>

        [1.] One line summary of the problem:
            Trying to use an initrd for an installation fails unless the
mke2fs
        used a blocksize of 1024 bytes.

        [2.] Full description of the problem/report:
            I'm trying to create a Linux for S/390 version 2.2.20
installation
        kernel/ramdisk set.  When I create the ramdisk, if I issue the
mke2fs
        command with -b 2048 or -b 4096, it works fine.  But, I try to boot
the
        system, I get an "EXT2-fs: Magic mismatch, very weird !" error when
the
        kernel tries to mount the ramdisk as the root file system.  If I let
the
        blocksize default, or specify -b 1024, everything works fine.

        The comparison that seems to be failing is at line 500 of
        linux/fs/ext/super.c:
                        if (es->s_magic != le16_to_cpu(EXT2_SUPER_MAGIC)) {
                                printk ("EXT2-fs: Magic mismatch, very weird
!\n");
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

