Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262354AbTJFQCi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 12:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbTJFQCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 12:02:38 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:16852 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S262354AbTJFQCe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 12:02:34 -0400
Message-ID: <3F8192E6.1010302@terra.com.br>
Date: Mon, 06 Oct 2003 13:05:58 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@mail.ru>
Cc: Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] check copy_from_user return value in sony535
References: <E1A6XJm-0003Vi-00.adobriyan-mail-ru@f20.mail.ru>
In-Reply-To: <E1A6XJm-0003Vi-00.adobriyan-mail-ru@f20.mail.ru>
Content-Type: multipart/mixed;
 boundary="------------020208080305000503030709"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020208080305000503030709
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi Alexey,

Alexey Dobriyan wrote:
> Fell free to nuke verify_area() right before 'return err;' ;-)

	Right :)

> Moving copy_from_user() before spin_up_drive() then also seems right thing to do.

	Oh, ok.

	Jens, please apply this patch instead.

	Thanks Alexey,

Felipe

--------------020208080305000503030709
Content-Type: text/plain;
 name="sonycd535-copy_from_user.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sonycd535-copy_from_user.patch"

--- linux-2.6.0-test6/drivers/cdrom/sonycd535.c.orig	2003-10-06 10:46:56.000000000 -0300
+++ linux-2.6.0-test6/drivers/cdrom/sonycd535.c	2003-10-06 13:03:13.000000000 -0300
@@ -1153,12 +1153,10 @@
 		break;
 
 	case CDROMPLAYMSF:			/* Play starting at the given MSF address. */
-		err = verify_area(VERIFY_READ, (char *)arg, 6);
-		if (err)
-			return err;
+		if (copy_from_user(params, (void *)arg, 6))
+			return -EFAULT;
 		spin_up_drive(status);
 		set_drive_mode(SONY535_AUDIO_DRIVE_MODE, status);
-		copy_from_user(params, (void *)arg, 6);
 
 		/* The parameters are given in int, must be converted */
 		for (i = 0; i < 3; i++) {

--------------020208080305000503030709--

