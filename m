Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbUCPVV0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 16:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbUCPVVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 16:21:25 -0500
Received: from fed1mtao05.cox.net ([68.6.19.126]:22183 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S261706AbUCPVUM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 16:20:12 -0500
Date: Tue, 16 Mar 2004 14:20:11 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: fix ppc compile
Message-ID: <20040316212011.GA20967@smtp.west.cox.net>
References: <20040316210540.GD24623@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040316210540.GD24623@redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2004 at 09:05:40PM +0000, Dave Jones wrote:
> 2.6.5rc1 changes this function, but there is no 'dev' argument there.
> This makes it look a little more sane, but I've no hardware to test it on.
> 
> 		Dave
> 
> --- linux-2.6.4/arch/ppc/syslib/indirect_pci.c~	2004-03-16 21:03:20.000000000 +0000
> +++ linux-2.6.4/arch/ppc/syslib/indirect_pci.c	2004-03-16 21:03:31.000000000 +0000
> @@ -44,8 +44,8 @@
>  			cfg_type = 1;
>  
>  	PCI_CFG_OUT(hose->cfg_addr, 					 
> -		 (0x80000000 | ((dev->bus->number - hose->bus_offset) << 16) 
> -		  | (dev->devfn << 8) | ((offset & 0xfc) | cfg_type)));	
> +		 (0x80000000 | ((bus->number - hose->bus_offset) << 16) 
> +		  | (devfn << 8) | ((offset & 0xfc) | cfg_type)));	
>  
>  	/*
>  	 * Note: the caller has already checked that offset is

There's this problem in 2 places.  I've sent akpm a patch already that
fixes 'em both.

-- 
Tom Rini
http://gate.crashing.org/~trini/
