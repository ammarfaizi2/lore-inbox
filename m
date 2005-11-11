Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbVKKTc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbVKKTc0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 14:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbVKKTc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 14:32:26 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:52968 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750719AbVKKTc0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 14:32:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=Fq6SlUZV1PzqPKurwn/6boV18Gl8OJWlna0iAR87JXIS9C7ZMRUATOhHtnvs/hweYPah+WB2/IEeQ6Dcru5Eo3+RY1MZpoe7r7ab932b442/UKiyZfNwvYVc9FmtRtIhx4rS9PiSYsoqn+W6b42Zw3FppELeZ/XqSZoOfeVWL4Y=
Subject: Re: 2.6.14-mm2
From: Badari Pulavarty <pbadari@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20051111112131.158218cb.akpm@osdl.org>
References: <20051110203544.027e992c.akpm@osdl.org>
	 <1131736446.25354.56.camel@localhost.localdomain>
	 <20051111112131.158218cb.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 11 Nov 2005 11:32:12 -0800
Message-Id: <1131737532.25354.60.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-11 at 11:21 -0800, Andrew Morton wrote:
> Badari Pulavarty <pbadari@gmail.com> wrote:
> >
> > On Thu, 2005-11-10 at 20:35 -0800, Andrew Morton wrote:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14/2.6.14-mm2/
> > > 
> > 
> > Doesn't compile on my PPC box. Looking at the problem to fix it.
> > 
> > Thanks,
> > Badari
> > 
> > elm3b157:/usr/src/linux-2.6.14 # make -j8 zImage
> >   CHK     include/linux/version.h
> >   CHK     include/linux/compile.h
> >   CHK     usr/initramfs_list
> >   CC      drivers/pci/syscall.o
> >   CC      drivers/pci/hotplug/rpaphp_pci.o
> >   CC      drivers/pci/hotplug/rpaphp_slot.o
> > drivers/pci/hotplug/rpaphp_pci.c: In function `rpaphp_pci_config_slot':
> > drivers/pci/hotplug/rpaphp_pci.c:256: error: `systemcfg' undeclared
> > (first use in this function)
> > drivers/pci/hotplug/rpaphp_pci.c:256: error: (Each undeclared identifier
> > is reported only once
> > drivers/pci/hotplug/rpaphp_pci.c:256: error: for each function it
> > appears in.)
> > make[3]: *** [drivers/pci/hotplug/rpaphp_pci.o] Error 1
> > make[3]: *** Waiting for unfinished jobs....
> > make[2]: *** [drivers/pci/hotplug] Error 2
> > make[2]: *** Waiting for unfinished jobs....
> > make[1]: *** [drivers/pci] Error 2
> > make: *** [drivers] Error 2
> 
> This?
> 
> Signed-off-by: Serge Hallyn <serue@us.ibm.com>
> ---
> 
> Index: linux-2.6.14-mm2/drivers/pci/hotplug/rpaphp_pci.c
> ===================================================================
> --- linux-2.6.14-mm2.orig/drivers/pci/hotplug/rpaphp_pci.c	2005-11-11 11:42:21.000000000 -0600
> +++ linux-2.6.14-mm2/drivers/pci/hotplug/rpaphp_pci.c	2005-11-11 11:48:40.000000000 -0600
> @@ -253,7 +253,7 @@ rpaphp_pci_config_slot(struct pci_bus *b
>  	if (!dn || !dn->child)
>  		return NULL;
>  
> -	if (systemcfg->platform == PLATFORM_PSERIES_LPAR) {
> +	if (_machine == PLATFORM_PSERIES_LPAR) {
>  		of_scan_bus(dn, bus);
>  		if (list_empty(&bus->devices)) {
>  			err("%s: No new device found\n", __FUNCTION__);


Yes.

Thanks,
Badari

