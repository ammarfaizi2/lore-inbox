Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWGRKCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWGRKCG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 06:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWGRKCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 06:02:06 -0400
Received: from [216.208.38.107] ([216.208.38.107]:29056 "EHLO
	OTTLS.pngxnet.com") by vger.kernel.org with ESMTP id S932145AbWGRKCF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 06:02:05 -0400
Subject: Re: [RFC PATCH 04/33] Add XEN config options and disable
	unsupported config options.
From: Arjan van de Ven <arjan@infradead.org>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@goop.org>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
In-Reply-To: <20060718091949.565211000@sous-sol.org>
References: <20060718091807.467468000@sous-sol.org>
	 <20060718091949.565211000@sous-sol.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 18 Jul 2006 11:59:12 +0200
Message-Id: <1153216752.3038.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The disabled config options are:
> - DOUBLEFAULT: are trapped by Xen and not virtualized
> - HZ: defaults to 100 in Xen VMs

Hi,

this makes no real sense with dynamic ticks coming up... HZ=1000 should
be perfectly fine then...

>  config KEXEC
>  	bool "kexec system call (EXPERIMENTAL)"
> -	depends on EXPERIMENTAL
> +	depends on EXPERIMENTAL && !X86_XEN
>  	help
>  	  kexec is a system call that implements the ability to shutdown your
>  	  current kernel, and to start another kernel.  It is like a reboot

hmmm why is kexec incompatible with xen? Don't you want to support crash
dumps from guests?

> +config XEN_SHADOW_MODE
> +	bool
> +	default y
> +	help
> +	  Fakes out a shadow mode kernel
> +

this probably wants a better description...


