Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964983AbWEJPs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbWEJPs3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 11:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbWEJPs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 11:48:28 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:49848 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S964983AbWEJPs1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 11:48:27 -0400
Date: Wed, 10 May 2006 16:48:23 +0100
From: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [Xen-devel] [RFC PATCH 01/35] Add XEN config options and disable unsupported config options.
Message-ID: <20060510154823.GZ7834@cl.cam.ac.uk>
References: <20060509084945.373541000@sous-sol.org> <20060509085145.790527000@sous-sol.org> <1147275418.17886.61.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147275418.17886.61.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2006 at 04:36:58PM +0100, Alan Cox wrote:
> On Maw, 2006-05-09 at 00:00 -0700, Chris Wright wrote:
> > plain text document atodiad (config-xen)
> > The XEN config option is selected from the i386 subarch menu by
> > choosing the X86_XEN "Xen-compatible" subarch.
> 
> You need this as well. At least if I read the logic right with regards
> to Xen and traps it is safe to do the following (although probably not
> safe to run Xen on such a physical system anyway)

Yes.  In our tree, we have a config option which completely removes
all the hardware idt table code (X86_NO_IDT) and stores the trap
table as a table suitable to pass directly to the hypervisor.

That's not so useful if you want to build a kernel which can run
both on a hypervisor and on native.  I guess you would need to
disable the X86_F00F_BUG code at runtime in such a kernel.

For the non-runtime case, I wonder if it's preferable to disable
X86_F00F_BUG like you suggest or if it would be better to disable
the cpu types listed?

    christian

> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> --- arch/i386/Kconfig.cpu~	2006-05-10 15:51:44.956941304 +0100
> +++ arch/i386/Kconfig.cpu	2006-05-10 15:51:44.956941304 +0100
> @@ -251,7 +251,7 @@
>  
>  config X86_F00F_BUG
>  	bool
> -	depends on M586MMX || M586TSC || M586 || M486 || M386
> +	depends on ( M586MMX || M586TSC || M586 || M486 || M386 ) && !XEN
>  	default y
>  
>  config X86_WP_WORKS_OK
> 
> 
