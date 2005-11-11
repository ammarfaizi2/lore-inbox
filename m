Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbVKKV1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbVKKV1x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 16:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbVKKV1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 16:27:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20394 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751206AbVKKV1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 16:27:52 -0500
Date: Fri, 11 Nov 2005 13:24:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, paulus@samba.org, anton@samba.org,
       linuxppc64-dev@ozlabs.org
Subject: Re: [2.6 patch] add -Werror-implicit-function-declaration to CFLAGS
Message-Id: <20051111132443.04061d10.akpm@osdl.org>
In-Reply-To: <20051111201849.GP5376@stusta.de>
References: <20051107200336.GH3847@stusta.de>
	<20051110042857.38b4635b.akpm@osdl.org>
	<20051111021258.GK5376@stusta.de>
	<20051110182443.514622ed.akpm@osdl.org>
	<20051111201849.GP5376@stusta.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> > > > 
> > > > Sorry, I need to build allmodconfig kernels on wacky architectures (eg
> > > > ppc64) and this patch is killing me.
> > > 
> > > Can you send me the list of compile errors so that I can work on fixing 
> > > them?
> > > 
> > 
> > No handily, sorry.   Missing virt_to_bus() is the typical problem.
> >
> 
> But in this case -Werror-implicit-function-declaration doesn't create 
> new compile errors, it only moves compile errors from compile time to 
> link or depmod time - which is IMHO not a bad change.

It is a quite inconvenient change if you want to get full coverage with
`make allmodconfig'.

Maybe one can do `make -i' and then weed through the noise - I haven't
tried.

> If you really want to keep the status quo, you can still steal the 
> following from sparc64:
>   extern unsigned long virt_to_bus_not_defined_use_pci_map(volatile void *addr);
>   #define virt_to_bus virt_to_bus_not_defined_use_pci_map
>   extern unsigned long bus_to_virt_not_defined_use_pci_map(volatile void *addr);
>   #define bus_to_virt bus_to_virt_not_defined_use_pci_map

Maybe.  There were some other failures.

