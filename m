Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751928AbWI3UWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbWI3UWj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 16:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbWI3UWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 16:22:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:51662 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751928AbWI3UWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 16:22:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=ZCmOV8h3ruw5dnPaG8rm3x/FiHbQ0WQUhFFkWfzQSKZpXQxmWAHkieJHBuR8M23V9i+JTtol9lPodQyQnhIu5IwYjnQTMLD8z4MSGqf0wB4Kyau+ViiRNBX/K/L5qfiucsmS0WsSzUd9A8xxMVJk3g0Hm4vPt22tGZuxv30p73U=
Date: Sat, 30 Sep 2006 22:22:40 +0200
From: Luca Tettamanti <kronos.it@gmail.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.18-git] Lost all PCI devices
Message-ID: <20060930202240.GA15952@dreamland.darkstar.lan>
References: <20060930174247.GA31793@dreamland.darkstar.lan> <200609302011.13457.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609302011.13457.ak@suse.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Sat, Sep 30, 2006 at 08:11:13PM +0200, Andi Kleen ha scritto: 
> On Saturday 30 September 2006 19:42, Luca Tettamanti wrote:
> > Hi Andi,
> > I'm testing current git on my notebook, but kernel doesn't find any
> > PCI device: no video card, no IDE, nothing.
> 
> Can you test it with this patch please?

Works fine, I can boot with it. Thank you!

> Fix PCI BIOS config space access
> 
> Got broken by a earlier change.
> 
> Signed-off-by: Andi Kleen <ak@suse.de>
> 
> Index: linux/arch/i386/pci/direct.c
> ===================================================================
> --- linux.orig/arch/i386/pci/direct.c
> +++ linux/arch/i386/pci/direct.c
> @@ -256,6 +256,8 @@ static int __init pci_check_type2(void)
>  
>  void __init pci_direct_init(int type)
>  {
> +	if (type == 0)
> +		return;
>  	printk(KERN_INFO "PCI: Using configuration type %d\n", type);
>  	if (type == 1)
>  		raw_pci_ops = &pci_direct_conf1;
> Index: linux/arch/i386/pci/init.c
> ===================================================================
> --- linux.orig/arch/i386/pci/init.c
> +++ linux/arch/i386/pci/init.c
> @@ -28,6 +28,10 @@ static __init int pci_access_init(void)
>  #ifdef CONFIG_PCI_DIRECT
>  	pci_direct_init(type);
>  #endif
> +	if (!raw_pci_ops)
> +		printk(KERN_ERR 
> +		"PCI: Fatal: No config space access function found\n");
> +
>  	return 0;
>  }
>  arch_initcall(pci_access_init);


Luca
-- 
Home: http://kronoz.cjb.net
"In linea di principio sarei indifferente al natale, se solo il natale
 ricambiasse la cortesia e mi lasciasse in pace." -- Marco d'Itri
