Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267008AbTBFMRD>; Thu, 6 Feb 2003 07:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267021AbTBFMRD>; Thu, 6 Feb 2003 07:17:03 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:16018 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267008AbTBFMRC>; Thu, 6 Feb 2003 07:17:02 -0500
From: Arnd Bergmann <arndb@de.ibm.com>
Reply-To: arnd@bergmann-dalldorf.de
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: klibc update
Date: Thu, 6 Feb 2003 13:07:33 +0100
User-Agent: KMail/1.5
Organization: IBM Deutschland Entwicklung GmbH
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302061307.33944.arndb@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found what kept initramfs from working here: While creating
of initramfs_data.cpio.gz, the padding between a file header
and the file contents was wrong, which can be verified by
unpacking the archive by hand.

The trivial patch below fixed this for me.

	Arnd <><

===== usr/gen_init_cpio.c 1.3 vs edited =====
--- 1.3/usr/gen_init_cpio.c	Tue Feb  4 23:29:14 2003
+++ edited/usr/gen_init_cpio.c	Thu Feb  6 12:32:47 2003
@@ -192,6 +192,7 @@
 		0);			/* chksum */
 	push_hdr(s);
 	push_string(location);
+	push_pad();
 
 	for (i = 0; i < buf.st_size; ++i)
 		fputc(filebuf[i], stdout);
