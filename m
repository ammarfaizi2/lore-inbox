Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWJAPhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWJAPhz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 11:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbWJAPhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 11:37:55 -0400
Received: from havoc.gtf.org ([69.61.125.42]:28139 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751111AbWJAPhy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 11:37:54 -0400
Date: Sun, 1 Oct 2006 11:37:53 -0400
From: Jeff Garzik <jeff@garzik.org>
To: mhw@wittsend.com, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] drivers/char/ip2: kill unused code, label
Message-ID: <20061001153753.GA5388@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kill warning:

drivers/char/ip2/ip2main.c: In function ‘ip2_loadmain’:
drivers/char/ip2/ip2main.c:782: warning: label ‘out_class’ defined but not used

This driver's initialization (and cleanup of errors during init) is
extremely convoluted, and could stand to be transformed into the
standard unwinding-goto style of error cleanup.

Signed-off-by: Jeff Garzik <jeff@garzik.org>

diff --git a/drivers/char/ip2/ip2main.c b/drivers/char/ip2/ip2main.c
index 331f447..bcf6573 100644
--- a/drivers/char/ip2/ip2main.c
+++ b/drivers/char/ip2/ip2main.c
@@ -779,8 +779,6 @@ retry:
 	ip2trace (ITRC_NO_PORT, ITRC_INIT, ITRC_RETURN, 0 );
 	goto out;
 
-out_class:
-	class_destroy(ip2_class);
 out_chrdev:
 	unregister_chrdev(IP2_IPL_MAJOR, "ip2");
 out:
