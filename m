Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264015AbTEONew (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 09:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264016AbTEONew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 09:34:52 -0400
Received: from ns.suse.de ([213.95.15.193]:45318 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264015AbTEONeu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 09:34:50 -0400
Date: Thu, 15 May 2003 15:47:38 +0200
From: Dave Jones <davej@suse.de>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.69-mm5: pccard oops while booting: resolved
Message-ID: <20030515154738.A9778@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>
References: <1052964213.586.3.camel@teapot.felipe-alfaro.com> <20030514191735.6fe0998c.akpm@digeo.com> <1052998601.726.1.camel@teapot.felipe-alfaro.com> <20030515130019.B30619@flint.arm.linux.org.uk> <1053004615.586.2.camel@teapot.felipe-alfaro.com> <20030515144439.A31491@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030515144439.A31491@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Thu, May 15, 2003 at 02:44:39PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 02:44:39PM +0100, Russell King wrote:
 > Indeed it does.  This patch should solve the problem.
 > 
 > --- orig/drivers/char/agp/intel-agp.c	Sun Apr 20 16:31:48 2003
 > +++ linux/drivers/char/agp/intel-agp.c	Thu May 15 14:41:45 2003
 > @@ -1635,7 +1635,7 @@
 >  
 >  MODULE_DEVICE_TABLE(pci, agp_intel_pci_table);
 >  
 > -static struct __initdata pci_driver agp_intel_pci_driver = {
 > +static struct pci_driver agp_intel_pci_driver = {
 >  	.name		= "agpgart-intel",
 >  	.id_table	= agp_intel_pci_table,
 >  	.probe		= agp_intel_probe,

Yup. Same stupid bug in all the other AGP drivers too.
I'll fix them up and push that along in a few hours.

        Dave


-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
