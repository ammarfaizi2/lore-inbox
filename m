Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267901AbUHEV6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267901AbUHEV6R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 17:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267900AbUHEV5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 17:57:18 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:34260 "EHLO
	zircon.austin.ibm.com") by vger.kernel.org with ESMTP
	id S267901AbUHEV4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 17:56:09 -0400
Subject: cross-depmod?
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1091742716.28466.27.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 05 Aug 2004 16:51:56 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam, would you take a patch like this:

--- 1.509/Makefile      Tue Aug  3 16:11:35 2004
+++ edited/Makefile     Thu Aug  5 17:12:07 2004
@@ -790,7 +790,11 @@
 endif
 .PHONY: _modinst_post
 _modinst_post: _modinst_
-       if [ -r System.map ]; then $(DEPMOD) -ae -F System.map $(depmod_opts) $(KERNELRELEASE); fi
+       if [ -z "$(CROSS_COMPILE)" -o "$(DEPMOD)" != "/sbin/depmod" ] ; then \
+               if [ -r System.map ]; then \
+                       $(DEPMOD) -ae -F System.map $(depmod_opts) $(KERNELRELEASE); \
+               fi \
+       fi

 else # CONFIG_MODULES

(I don't like hardcoding /sbin/depmod; this is just for conversation.)

My problem is that I cross-build my kernels, and 'make rpm' is very
unhappy when it can't use depmod. I know that I can do 'make
DEPMOD=/bin/true rpm', but can't we figure that out automatically?

In general if you're cross-compiling I don't think you can assume
/sbin/depmod is ok. Someone could do 'make DEPMOD=powerpc-linux-depmod'
though (couldn't they? does anybody bother?), so if $(DEPMOD) has been
specified we still want to let that work...

-- 
Hollis Blanchard
IBM Linux Technology Center

