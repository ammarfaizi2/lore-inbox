Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbVDMOpe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVDMOpe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 10:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVDMOpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 10:45:34 -0400
Received: from hermes.domdv.de ([193.102.202.1]:45329 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261339AbVDMOpU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 10:45:20 -0400
Message-ID: <425D307F.6010001@domdv.de>
Date: Wed, 13 Apr 2005 16:45:19 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
References: <4259B474.4040407@domdv.de> <20050411110822.GA10401@elf.ucw.cz> <425AA19F.6040802@domdv.de> <200504112257.39708.rjw@sisk.pl> <425BCA6E.8030408@domdv.de> <20050413132206.GA16839@elf.ucw.cz>
In-Reply-To: <20050413132206.GA16839@elf.ucw.cz>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------080907060203030203060602"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080907060203030203060602
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Pavel Machek wrote:
> Applied (it is *not* going to make it into 2.6.12, and not sure about
> 2.6.13, but it is in my local tree now. You had Kconfig and docs
> changes, too, can you retransmit them?
> 								Pavel

No changes to config and docs, but I'll attach them again nevertheless.
BTW: it was quite clear to me that this can't make 2.6.12 and that
2.6.13 might be a bit early.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de

--------------080907060203030203060602
Content-Type: text/plain;
 name="swsusp-encrypt-config.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="swsusp-encrypt-config.diff"

--- linux-2.6.11.2/kernel/power/Kconfig.ast	2005-04-10 20:44:48.000000000 +0200
+++ linux-2.6.11.2/kernel/power/Kconfig	2005-04-10 21:01:36.000000000 +0200
@@ -72,3 +72,14 @@
 	  suspended image to. It will simply pick the first available swap 
 	  device.
 
+config SWSUSP_ENCRYPT
+	bool "Encrypt suspend image"
+	depends on SOFTWARE_SUSPEND && CRYPTO=y && (CRYPTO_AES=y || CRYPTO_AES_586=y)
+	default ""
+	---help---
+	  To prevent data gathering from swap after resume you can encrypt
+	  the suspend image with a temporary key that is deleted on
+	  resume.
+
+	  Note that the temporary key is stored unencrypted on disk while the
+	  system is suspended.

--------------080907060203030203060602
Content-Type: text/plain;
 name="swsusp-encrypt-info.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="swsusp-encrypt-info.diff"

--- linux-2.6.11.2/Documentation/power/swsusp.txt.ast	2005-04-10 21:07:01.000000000 +0200
+++ linux-2.6.11.2/Documentation/power/swsusp.txt	2005-04-10 21:10:56.000000000 +0200
@@ -30,6 +30,13 @@
 echo platform > /sys/power/disk; echo disk > /sys/power/state
 
 
+Encrypted suspend image:
+------------------------
+If you want to store your suspend image encrypted with a temporary
+key to prevent data gathering after resume you must compile
+crypto and the aes algorithm into the kernel - modules won't work
+as they cannot be loaded at resume time.
+
 
 Article about goals and implementation of Software Suspend for Linux
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

--------------080907060203030203060602--
