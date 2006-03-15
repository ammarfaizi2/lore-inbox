Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932586AbWCOCNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932586AbWCOCNw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 21:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752099AbWCOCNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 21:13:52 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:54215 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1752077AbWCOCNv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 21:13:51 -0500
Date: Wed, 15 Mar 2006 03:13:50 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       len.brown@intel.com
Subject: Re: [PATCH] 2.6.16-rc6 calls check_acpi_pci() on x86 with ACPI disabled
Message-ID: <20060315021350.GC24945@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	len.brown@intel.com
References: <20060315013125.GA24402@MAIL.13thfloor.at> <20060314174540.5c138458.akpm@osdl.org> <20060315015318.GA24945@MAIL.13thfloor.at> <20060314180651.5103928f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060314180651.5103928f.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2006 at 06:06:51PM -0800, Andrew Morton wrote:
> Herbert Poetzl <herbert@13thfloor.at> wrote:
> >
> > On Tue, Mar 14, 2006 at 05:45:40PM -0800, Andrew Morton wrote:
> > > Herbert Poetzl <herbert@13thfloor.at> wrote:
> > > >
> > > > 
> > > > Hi Andrew! Folks!
> > > > 
> > > > check_acpi_pci() is called form arch/i386/kernel/setup.c
> > > > even if CONFIG_ACPI is not defined, but the code in
> > > > include/asm/acpi.h doesn't provide it in this case, 
> > > 
> > > Well that's a shame.
> > > 
> > > > so either we need to move the declaration outside the 
> > > > CONFIG_ACPI check, or alternatively move the call in
> > > > setup.c inside the CONFIG_ACPI one
> > > > 
> > > > attached two patches which would do this
> > > 
> > > Prefer the first version.  But it'll break if CONFIG_X86_IO_APIC &&
> > > !CONFIG_ACPI
> > > 
> > > So how's about this?
> > 
> > hmm, well, the comment around the check_acpi_pci() call
> > says: "Checks more than just ACPI actually", so I didn't
> > want to make it depend on ACPI in the 'first' version,
> > which now would change semantics, but if it is fine to
> > make it depend on ACPI, the second version might be the
> > simpler solution (which should have the same semantic as
> > your version ... I think
> > 
> > maybe the ACPI folks should clarify if this stuff has to
> > be run if ACPI is off, in which case renaming the thing
> > might be a good idea ...
> 
> Yes, actually I didn't check closely enough - arch/i386/kernel/acpi/* gets
> built even if CONFIG_ACPI=n (!)
> 
> So the code will actualy compile and link OK if we do:
> 
> #ifdef CONFIG_X86_IO_APIC
> extern void check_acpi_pci(void);
> #else
> static inline void check_acpi_pci(void) { }
> #endif
> 
> But we'd need the acpi guys to tell us what's actually intended here,
> please.  Does it make sense to be calling this function in a non-ACPI
> kernel?

yes, maybe it needs to be split into two parts, one
generic and the other acpi related ...

> erk, your patch was against include/asm/... 
> - please don't do that - 
> it doesn't work very well if the patch receiver isn't using a
> setup-for-i386 tree.

oops, sorry, I should know that, but I just forgot
about that ... will try to remember next time ...

best,
Herbert

