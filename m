Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbWEIMzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbWEIMzv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 08:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWEIMzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 08:55:51 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:11664 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S932296AbWEIMzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 08:55:50 -0400
Date: Tue, 9 May 2006 13:55:39 +0100
From: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Chris Wright <chrisw@sous-sol.org>,
       Ian Pratt <ian.pratt@xensource.com>, xen-devel@lists.xensource.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 16/35] subarch support for interrupt and exception gates
Message-ID: <20060509125539.GA7834@cl.cam.ac.uk>
References: <20060509084945.373541000@sous-sol.org> <20060509085154.441800000@sous-sol.org> <200605091309.49631.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605091309.49631.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 01:09:49PM +0200, Andi Kleen wrote:
> 
> > +/*
> > + * This needs to use 'idt_table' rather than 'idt', and
> > + * thus use the _nonmapped_ version of the IDT, as the
> > + * Pentium F0 0F bugfix can have resulted in the mapped
> > + * IDT being write-protected.
> > + */
> > +void set_intr_gate(unsigned int n, void *addr)
> > +{
> > +	_set_gate(idt_table+n,14,0,addr,__KERNEL_CS);
> > +}
> 
> No need to duplicate the various set_*_gate functions into the subarchs.

Indeed, we'll change that.  Thanks.

    christian

> > +static void __init set_task_gate(unsigned int n, unsigned int gdt_entry)
> > +{
> > +	/* _set_gate(n, 5, 0, 0, (gdt_entry<<3)); */
> > +}
> 
> Looks weird, but can be handled in the low level function.
> 
> -Andi

> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/virtualization

