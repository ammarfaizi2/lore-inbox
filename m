Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262840AbVCXPz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262840AbVCXPz7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 10:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262853AbVCXPz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 10:55:59 -0500
Received: from mailwasher.lanl.gov ([192.65.95.54]:62251 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S263103AbVCXPzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 10:55:23 -0500
Message-ID: <4242E2E1.2060402@mesatop.com>
Date: Thu, 24 Mar 2005 08:55:13 -0700
From: Steven Cole <elenstev@mesatop.com>
User-Agent: Thunderbird 1.0 (Multics)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Cole <elenstev@mesatop.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc1-mm2 (patch to fix build error In function `zft_init')
References: <20050324044114.5aa5b166.akpm@osdl.org> <4242D820.8070801@mesatop.com>
In-Reply-To: <4242D820.8070801@mesatop.com>
Content-Type: multipart/mixed;
 boundary="------------020903060708060108050901"
X-PMX-Version: 4.7.0.111621
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020903060708060108050901
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Steven Cole wrote:
> I'm getting the following build error with 2.6.12-rc1-mm2:
> 
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> drivers/built-in.o(.init.text+0x4323): In function `zft_init':
> : undefined reference to `class_device_creat'
> make: *** [.tmp_vmlinux1] Error 1
> 

I glanced at the code, and this little patch fixes the problem:

Steven

--------------020903060708060108050901
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="patch-zftape-init-smallfix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-zftape-init-smallfix"

Signed-off by: Steven Cole <elenstev@mesatop.com>

--- linux-2.6.12-rc1-mm2/drivers/char/ftape/zftape/zftape-init.c.orig	2005-03-24 08:43:30.000000000 -0700
+++ linux-2.6.12-rc1-mm2/drivers/char/ftape/zftape/zftape-init.c	2005-03-24 08:43:56.000000000 -0700
@@ -331,7 +331,7 @@
 
 	zft_class = class_create(THIS_MODULE, "zft");
 	for (i = 0; i < 4; i++) {
-		class_device_creat(zft_class, MKDEV(QIC117_TAPE_MAJOR, i), NULL, "qft%i", i);
+		class_device_create(zft_class, MKDEV(QIC117_TAPE_MAJOR, i), NULL, "qft%i", i);
 		devfs_mk_cdev(MKDEV(QIC117_TAPE_MAJOR, i),
 				S_IFCHR | S_IRUSR | S_IWUSR,
 				"qft%i", i);

--------------020903060708060108050901--
