Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbVELQAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbVELQAd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 12:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbVELQAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 12:00:32 -0400
Received: from fire.osdl.org ([65.172.181.4]:7563 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262060AbVELQA0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 12:00:26 -0400
Date: Thu, 12 May 2005 08:59:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: adobriyan@gmail.com, linux-kernel@vger.kernel.org, airlied@linux.ie,
       davej@codemonkey.org.uk, linux-fbdev-devel@lists.sourceforge.net
Subject: Re: kobject_register failed for intelfb (-EACCES) (Re:
 2.6.12-rc4-mm1)
Message-Id: <20050512085933.03dc0d10.akpm@osdl.org>
In-Reply-To: <20050512154335.GD21765@kroah.com>
References: <20050512033100.017958f6.akpm@osdl.org>
	<200505121658.02019.adobriyan@gmail.com>
	<20050512154335.GD21765@kroah.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> 
>  On Thu, May 12, 2005 at 04:58:01PM +0400, Alexey Dobriyan wrote:
>  > kobject Intel(R) 830M/845G/852GM/855GM/865G/915G Framebuffer Driver:
>  > registering. parent: <NULL>, set: drivers
>  > kobject_register failed for Intel(R) 830M/845G/852GM/855GM/865G/915G
> 
>  Someone tried to put a "/" in a kobject name, which is not allowed.
>  Actually the name seems to be set to:
>  	"Intel(R) 830M/845G/852GM/855GM/865G/915G Framebuffer Driver"
>  which is a bit verbous if you want to create a directory name :)

I don't think that part of the driver has changed in some time.  Is there
something new in your trees which would trigger this?

Seems like a fix such as this will be needed:

--- 25/drivers/video/intelfb/intelfbdrv.c~intelfbdrv-naming-fix	2005-05-12 08:54:46.000000000 -0700
+++ 25-akpm/drivers/video/intelfb/intelfbdrv.c	2005-05-12 08:55:03.000000000 -0700
@@ -214,7 +214,7 @@ static struct fb_ops intel_fb_ops = {
 
 /* PCI driver module table */
 static struct pci_driver intelfb_driver = {
-	.name =		"Intel(R) " SUPPORTED_CHIPSETS " Framebuffer Driver",
+	.name =		"intelfb",
 	.id_table =	intelfb_pci_table,
 	.probe =	intelfb_pci_register,
 	.remove =	__devexit_p(intelfb_pci_unregister)
_

