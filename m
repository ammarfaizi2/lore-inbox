Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbVK3VYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbVK3VYW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 16:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbVK3VYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 16:24:22 -0500
Received: from nproxy.gmail.com ([64.233.182.192]:18989 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750761AbVK3VYV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 16:24:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=rxUfb91SYHInYPrD3NhlAuu0nxMWLyGr4FAkl8k1GcB2zZXZZic8E9O5jbiZBF5QundOCsAXuzjWAyZMXRLnCHDirqavoQXfQqRSn+IHjszmESTsQnPhZ44S8Nsf4WpPQSUwY+nojj3vzddt0GFBtWRI77ndTpSZtQIKyPa3aU8=
Date: Thu, 1 Dec 2005 00:39:02 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Andrew Morton <akpm@osdl.org>,
       Marcelo Feitoza Parisi <marcelo@feitoza.com.br>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] nvidia-agp: use time_before_eq()
Message-ID: <20051130213902.GB12551@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>

It deals with wrapping correctly and is nicer to read.

Signed-off-by: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/char/agp/nvidia-agp.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/char/agp/nvidia-agp.c
+++ b/drivers/char/agp/nvidia-agp.c
@@ -11,6 +11,7 @@
 #include <linux/gfp.h>
 #include <linux/page-flags.h>
 #include <linux/mm.h>
+#include <linux/jiffies.h>
 #include "agp.h"
 
 /* NVIDIA registers */
@@ -256,7 +257,7 @@ static void nvidia_tlbflush(struct agp_m
 		do {
 			pci_read_config_dword(nvidia_private.dev_1,
 					NVIDIA_1_WBC, &wbc_reg);
-			if ((signed)(end - jiffies) <= 0) {
+			if (time_before_eq(end, jiffies)) {
 				printk(KERN_ERR PFX
 				    "TLB flush took more than 3 seconds.\n");
 			}

