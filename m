Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132482AbRAXFZ6>; Wed, 24 Jan 2001 00:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132508AbRAXFZt>; Wed, 24 Jan 2001 00:25:49 -0500
Received: from casablanca.magic.fr ([195.154.101.81]:64724 "EHLO
	casablanca.magic.fr") by vger.kernel.org with ESMTP
	id <S132482AbRAXFZa>; Wed, 24 Jan 2001 00:25:30 -0500
Message-ID: <3A6E6803.943E7033@magic.fr>
Date: Wed, 24 Jan 2001 06:28:35 +0100
From: "Jo l'Indien" <l_indien@magic.fr>
Reply-To: l_indien@magic.fr, jma@netgem.com
Organization: Les grandes plaines
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1-pre10 i586)
X-Accept-Language: fr-FR, fr, en, en-GB, en-US, ro
MIME-Version: 1.0
To: tigran@sco.com
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: A little patch for i386/kernel/microcode.c
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by leeloo.zip.com.au id QAA26336

With a 2.4.1-pre10 kernel, I noticed that /dev/cpu/microcode
was created as a file, and note as a node in the devfs.
So, I made this very little patch to correct this:

--- microcode.c Thu Dec 28 06:28:29 2000
+++ microcode.c Wed Jan 24 04:47:08 2001
@@ -120,7 +120,7 @@
    MICROCODE_MINOR);

  devfs_handle = devfs_register(NULL, "cpu/microcode",
-   DEVFS_FL_DEFAULT, 0, 0, S_IFREG | S_IRUSR | S_IWUSR,
+   DEVFS_FL_DEFAULT, MISC_MAJOR, MICROCODE_MINOR, S_IFCHR | S_IRUSR |
S_IWUSR,
    &microcode_fops, NULL);
  if (devfs_handle == NULL && error) {
   printk(KERN_ERR "microcode: failed to devfs_register()\n");

This should be OK...
I cannot test this feature as I don't have a PIII,
but a K6-II... I'll try... Just to know...

I was wondering why /dev/cpu/mtrr was created as a file, not a node,
when I found this... For mtrr, it seems to be normal, as I didn't find
any informations relative of Major/Minor for this device...

Regards.

Jocelyn Mayer
ı:.Ë›±Êâmçë¢kaŠÉb²ßìzwm…ébïîË›±Êâmébìÿ‘êçz_âØ^n‡r¡ö¦zËëh™¨è­Ú&£ûàz¿äz¹Ş—ú+€ù^jÇ«y§m…á@A«a¶Úÿÿü0ÃûnÇú+ƒùd
