Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317300AbSGJNxg>; Wed, 10 Jul 2002 09:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317329AbSGJNxf>; Wed, 10 Jul 2002 09:53:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:6766 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S317300AbSGJNxd>;
	Wed, 10 Jul 2002 09:53:33 -0400
Message-ID: <003d01c22819$ba1818b0$1c6fa8c0@hyper>
From: "Christian Ludwig" <cl81@gmx.net>
To: "Kernel.org" <linux-kernel@vger.kernel.org>
Subject: bzip2 support against 2.4.18
Date: Wed, 10 Jul 2002 15:57:27 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

I think it's time to have bzip2 support in the kernel. I know the discussion
about the speed and memory issues that are around with this. But everything
in this patch is optional. You may use these new features if you want, you
do not have to use them...

This is a testing version of the patch. Only apply this if you really want
to play around with it a little bit. I know too less persons, who have the
time/fancy to test it (including myself). If you find errors in it feel free
to go on developing the patch yourself! Just CC a copy to me.
This patch consists actually of two parts:

1. A kernel bzip2 compression patch. The kernel will be compressed with
bzip. Therefore you have to type "make bz2bzImage" at the prompt after the
kernel configuration. This part is architecture dependent and was
implemented only for i386 based PCs right now.

2. A ramdisk bzip2 compression support patch. The ramdisk/initrd recongnises
now bzip2 compressed ramdisk images, loads and decompresses them. You can
choose between gzip and bzip2 (or even both) in the kernel configuration.

These two parts cannot be split up, because both are using the same
decompression code in "linux/lib/bzip2_inflate.c".

I have adapted this kernel hack by Tom Oehser (tom@toms.net). He wrote this
for kernel 2.2 and I ported it to 2.4.18 and cleaned up the code.

You will find the diff here:
    http://chrissicool.piranho.com/patch-2.4.x-bzip2-i386

Known bugs:
    - gzip crc support was corrupted in file "rd.c", function
"flush_window()"
      [maybe it can be fixed, but time is money...]
    - too less testing time was invested

Best regards,

    - Christian


