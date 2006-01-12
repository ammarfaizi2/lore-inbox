Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbWALBCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbWALBCn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 20:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbWALBCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 20:02:42 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:48904 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964900AbWALBCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 20:02:42 -0500
Date: Thu, 12 Jan 2006 02:02:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Russell King <rmk@arm.linux.org.uk>,
       Greg K-H <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, tony.luck@intel.com,
       linux-ia64@vger.kernel.org
Subject: [-mm patch] fix arch/ia64/sn/kernel/tiocx.c compilation
Message-ID: <20060112010240.GN29663@stusta.de>
References: <20060111042135.24faf878.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060111042135.24faf878.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 04:21:35AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.15-mm2:
>...
> +gregkh-driver-add-tiocx-bus_type-probe-remove-methods.patch
>...
>  driver tree updates
>...

This patch caused the following compile error:

<--  snip  -->

...
  CC      arch/ia64/sn/kernel/tiocx.o
arch/ia64/sn/kernel/tiocx.c:151: error: 'cx_device_remove' undeclared here (not in a function)
make[2]: *** [arch/ia64/sn/kernel/tiocx.o] Error 1

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-mm3/arch/ia64/sn/kernel/tiocx.c.old	2006-01-12 01:58:20.000000000 +0100
+++ linux-2.6.15-mm3/arch/ia64/sn/kernel/tiocx.c	2006-01-12 01:58:35.000000000 +0100
@@ -148,7 +148,7 @@
 	.match = tiocx_match,
 	.uevent = tiocx_uevent,
 	.probe = cx_device_probe,
-	.remove = cx_device_remove,
+	.remove = cx_driver_remove,
 };
 
 /**

