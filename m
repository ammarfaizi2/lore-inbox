Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263997AbTEONbz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 09:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264002AbTEONbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 09:31:55 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14342 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263997AbTEONby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 09:31:54 -0400
Date: Thu, 15 May 2003 14:44:39 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>,
       David Jones <davej@suse.de>
Subject: Re: 2.5.69-mm5: pccard oops while booting: resolved
Message-ID: <20030515144439.A31491@flint.arm.linux.org.uk>
Mail-Followup-To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>,
	David Jones <davej@suse.de>
References: <1052964213.586.3.camel@teapot.felipe-alfaro.com> <20030514191735.6fe0998c.akpm@digeo.com> <1052998601.726.1.camel@teapot.felipe-alfaro.com> <20030515130019.B30619@flint.arm.linux.org.uk> <1053004615.586.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1053004615.586.2.camel@teapot.felipe-alfaro.com>; from felipe_alfaro@linuxmail.org on Thu, May 15, 2003 at 03:16:55PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 03:16:55PM +0200, Felipe Alfaro Solana wrote:
> OK, attached to this message:
> 
> "dmesg" contains the kernel messages when booting up 2.5.69-mm5 at tun
> level 1 with the patch applied.
> 
> "config" contains options used to configure the kernel. Mostly, the
> cardbus stuff is built-in, so no modules were loaded when booting into
> single-user mode.
> 
> Hope this helps!

Indeed it does.  This patch should solve the problem.

--- orig/drivers/char/agp/intel-agp.c	Sun Apr 20 16:31:48 2003
+++ linux/drivers/char/agp/intel-agp.c	Thu May 15 14:41:45 2003
@@ -1635,7 +1635,7 @@
 
 MODULE_DEVICE_TABLE(pci, agp_intel_pci_table);
 
-static struct __initdata pci_driver agp_intel_pci_driver = {
+static struct pci_driver agp_intel_pci_driver = {
 	.name		= "agpgart-intel",
 	.id_table	= agp_intel_pci_table,
 	.probe		= agp_intel_probe,


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

