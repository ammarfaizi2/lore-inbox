Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751753AbWEIOrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbWEIOrQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 10:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbWEIOrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 10:47:15 -0400
Received: from ns1.mvista.com ([63.81.120.158]:41021 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751753AbWEIOrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 10:47:15 -0400
Subject: Re: [RFC PATCH 01/35] Add XEN config options and disable
	unsupported config options.
From: Daniel Walker <dwalker@mvista.com>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
In-Reply-To: <20060509085145.790527000@sous-sol.org>
References: <20060509084945.373541000@sous-sol.org>
	 <20060509085145.790527000@sous-sol.org>
Content-Type: text/plain
Date: Tue, 09 May 2006 07:47:12 -0700
Message-Id: <1147186032.21536.16.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-09 at 00:00 -0700, Chris Wright wrote:
> plain text document attachment (config-xen)
> The XEN config option is selected from the i386 subarch menu by
> choosing the X86_XEN "Xen-compatible" subarch.
> 
> The XEN_SHADOW_MODE option defines the memory virtualization mode for
> the kernel -- with it enabled, the kernel expects the hypervisor to
> perform translation between pseudo-physical and machine addresses on
> its behalf.
> 
> The disabled config options are:
> - DOUBLEFAULT: are trapped by Xen and not virtualized
> - HZ: defaults to 100 in Xen VMs
> - Power management: not supported in unprivileged VMs
> - SMP: not supported in this set of patches
> - X86_{UP,LOCAL,IO}_APIC: not supported in unprivileged VMs
> 
> Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
> Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> ---
>  arch/i386/Kconfig       |   18 ++++++++++++++----
>  arch/i386/Kconfig.debug |    1 +
>  drivers/xen/Kconfig     |   21 +++++++++++++++++++++
>  kernel/Kconfig.hz       |    4 ++--
>  kernel/Kconfig.preempt  |    1 +
>  5 files changed, 39 insertions(+), 6 deletions(-)
> 
> --- linus-2.6.orig/arch/i386/Kconfig
> +++ linus-2.6/arch/i386/Kconfig
> @@ -55,6 +55,7 @@ menu "Processor type and features"
>  
>  config SMP
>  	bool "Symmetric multi-processing support"
> +	depends on !X86_XEN
>  	---help---
>  	  This enables support for systems with more than one CPU. If you have
>  	  a system with only one CPU, like most personal computers, say N. If
> @@ -91,6 +92,12 @@ config X86_PC
>  	help
>  	  Choose this option if your computer is a standard PC or compatible.
>  
> +config X86_XEN
> +	bool "Xen-compatible"
> +	help
> +	  Choose this option if you plan to run this kernel on top of the
> +	  Xen Hypervisor.
> +

Couldn't you just add "depends on !SMP && .." to the config X86_XEN
block ? 

Daniel

