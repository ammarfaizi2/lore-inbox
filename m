Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262757AbUKRMqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262757AbUKRMqI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 07:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262760AbUKRMqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 07:46:08 -0500
Received: from holomorphy.com ([207.189.100.168]:18560 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262757AbUKRMp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 07:45:59 -0500
Date: Thu, 18 Nov 2004 04:45:57 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-mm2
Message-ID: <20041118124557.GC2268@holomorphy.com>
References: <20041118021538.5764d58c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041118021538.5764d58c.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 02:15:38AM -0800, Andrew Morton wrote:
> +parport_pc-config_pci=n-build-fix.patch
>  parport build fix

This patch resolves the following warning by removing a const qualifier
conflicting with __setup's expected function type.

drivers/parport/parport_pc.c:3323: warning: initialization from incompatible pointer type


Index: mm2-2.6.10-rc2/drivers/parport/parport_pc.c
===================================================================
--- mm2-2.6.10-rc2.orig/drivers/parport/parport_pc.c	2004-11-18 02:55:03.000000000 -0800
+++ mm2-2.6.10-rc2/drivers/parport/parport_pc.c	2004-11-18 03:56:11.208617728 -0800
@@ -3155,8 +3155,8 @@
 }
 
 #ifdef CONFIG_PCI
-static int __init parport_init_mode_setup(const char *str) {
-
+static int __init parport_init_mode_setup(char *str)
+{
 	printk(KERN_DEBUG "parport_pc.c: Specified parameter parport_init_mode=%s\n", str);
 
 	if (!strcmp (str, "spp"))
