Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751505AbWF1RES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbWF1RES (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 13:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWF1RDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 13:03:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23997 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751426AbWF1RDa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 13:03:30 -0400
Date: Wed, 28 Jun 2006 13:02:22 -0400
From: Dave Jones <davej@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] AGP_AMD64 must depend on PCI
Message-ID: <20060628170222.GA23396@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
References: <20060628165529.GI13915@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060628165529.GI13915@stusta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2006 at 06:55:30PM +0200, Adrian Bunk wrote:
 > This patch fixes the following compile error:
 > 
 > <--  snip  -->
 > 
 > ...
 >   CC      arch/i386/kernel/../../x86_64/kernel/k8.o
 > arch/i386/kernel/../../x86_64/kernel/k8.c: In function ‘next_k8_northbridge’:
 > arch/i386/kernel/../../x86_64/kernel/k8.c:34: error: implicit declaration of function ‘pci_match_id’
 > 
 > <--  snip  -->
 > 
 > Signed-off-by: Adrian Bunk <bunk@stusta.de>
 > 
 > --- linux-2.6.17-mm3-full/drivers/char/agp/Kconfig.old	2006-06-28 12:56:20.000000000 +0200
 > +++ linux-2.6.17-mm3-full/drivers/char/agp/Kconfig	2006-06-28 12:56:55.000000000 +0200
 > @@ -56,7 +56,7 @@
 >  
 >  config AGP_AMD64
 >  	tristate "AMD Opteron/Athlon64 on-CPU GART support" if !IOMMU
 > -	depends on AGP && X86
 > +	depends on AGP && PCI && X86
 >  	default y if IOMMU
 >  	help
 >  	  This option gives you AGP support for the GLX component of

What makes this driver special ? The other AGP drivers also use
various PCI functions, and don't have a similar dependancy.

Adding depends on PCI to 'AGP' may make more sense than adding
it to the individual drivers, especially as the core AGP code also
uses the pci layer.   As AGP is just a bastardised variant of PCI
anyway, adding an explicit dependancy should be sane on all archs,
even alpha with its wierdo 'faked pci bridge'.

		Dave

-- 
http://www.codemonkey.org.uk
