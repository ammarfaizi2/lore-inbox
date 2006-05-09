Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbWEIPQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWEIPQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 11:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWEIPQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 11:16:58 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:55970 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S932391AbWEIPQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 11:16:57 -0400
Date: Tue, 9 May 2006 16:16:51 +0100
From: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
To: Daniel Walker <dwalker@mvista.com>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [RFC PATCH 01/35] Add XEN config options and disable unsupported config options.
Message-ID: <20060509151651.GI7834@cl.cam.ac.uk>
References: <20060509084945.373541000@sous-sol.org> <20060509085145.790527000@sous-sol.org> <1147186032.21536.16.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147186032.21536.16.camel@c-67-180-134-207.hsd1.ca.comcast.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 07:47:12AM -0700, Daniel Walker wrote:
> On Tue, 2006-05-09 at 00:00 -0700, Chris Wright wrote:
> > The disabled config options are:
> > - DOUBLEFAULT: are trapped by Xen and not virtualized
> > - HZ: defaults to 100 in Xen VMs
> > - Power management: not supported in unprivileged VMs
> > - SMP: not supported in this set of patches
> > - X86_{UP,LOCAL,IO}_APIC: not supported in unprivileged VMs
> > 
> > +++ linus-2.6/arch/i386/Kconfig
> > @@ -55,6 +55,7 @@ menu "Processor type and features"
> >  
> >  config SMP
> >  	bool "Symmetric multi-processing support"
> > +	depends on !X86_XEN
> >  	---help---
> >  	  This enables support for systems with more than one CPU. If you have
> >  	  a system with only one CPU, like most personal computers, say N. If
> > @@ -91,6 +92,12 @@ config X86_PC
> >  	help
> >  	  Choose this option if your computer is a standard PC or compatible.
> >  
> > +config X86_XEN
> > +	bool "Xen-compatible"
> > +	help
> > +	  Choose this option if you plan to run this kernel on top of the
> > +	  Xen Hypervisor.
> > +
> 
> Couldn't you just add "depends on !SMP && .." to the config X86_XEN
> block ? 

I guess you could, but it would make it rather non-obvious and tedious
to enable X86_XEN then, wouldn't it?

    christian

