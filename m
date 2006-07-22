Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbWGVJtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWGVJtz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 05:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWGVJtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 05:49:55 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:54766 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751308AbWGVJty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 05:49:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=K2DgzCsaSTv12m9s2dAeWj9Lsn7XY/iz/Sad15HmEhoJi6uior2Hu795ArVq1a9AvcJUJrNeOqFsElX1wfvwTFZeC9CqeHJRgzzeisOyO+U7CP6mQoGwkvzXJv8BZ4JjIcblBPSWFRfezLmAJfcX/Wg8PhgD0AQc5lTnbREHQvU=
Date: Sat, 22 Jul 2006 11:49:48 +0200
From: Frederik Deweerdt <deweerdt@free.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] mdacon: fix __init section warnings
Message-ID: <20060722094948.GD2772@slug>
References: <20060713224800.6cbdbf5d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060713224800.6cbdbf5d.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2006 at 10:48:00PM -0700, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm2/
> 
> - Patches were merged, added, dropped and fixed.  Nothing particularly exciting.
> 
Compilation issues the following warnings:
WARNING: drivers/video/console/mdacon.o - Section mismatch: reference to .init.text: from .text between 'mdacon_startup' (at offset 0x123) and 'mdacon_init'
WARNING: drivers/video/console/mdacon.o - Section mismatch: reference to .init.text: from .text between 'mdacon_startup' (at offset 0x18b) and 'mdacon_init'

The attached patch removes the __init directives from mda_detect and mda_initialize which are
called from mdacon_startup (which is not __init tagged).

Regards,
Frederik


--- drivers/video/console/mdacon.c~mdacon-section-warning-fix.patch	2006-07-22 11:40:21.000000000 +0200
+++ drivers/video/console/mdacon.c	2006-07-22 11:34:20.000000000 +0200
@@ -197,7 +197,7 @@ static int __init mdacon_setup(char *str
 __setup("mdacon=", mdacon_setup);
 #endif
 
-static int __init mda_detect(void)
+static int mda_detect(void)
 {
 	int count=0;
 	u16 *p, p_save;
@@ -282,7 +282,7 @@ static int __init mda_detect(void)
 	return 1;
 }
 
-static void __init mda_initialize(void)
+static void mda_initialize(void)
 {
 	write_mda_b(97, 0x00);		/* horizontal total */
 	write_mda_b(80, 0x01);		/* horizontal displayed */
