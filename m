Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWHHCBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWHHCBL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 22:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWHHCBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 22:01:11 -0400
Received: from ns.suse.de ([195.135.220.2]:41632 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751205AbWHHCBK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 22:01:10 -0400
From: Andi Kleen <ak@muc.de>
To: virtualization@lists.osdl.org
Subject: Re: [PATCH 1/4] x86 paravirt_ops: create no_paravirt.h for native ops
Date: Tue, 8 Aug 2006 03:59:12 +0200
User-Agent: KMail/1.9.3
Cc: Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>
References: <1154925835.21647.29.camel@localhost.localdomain> <1154930669.7642.12.camel@localhost.localdomain> <44D7A7E6.2060401@vmware.com>
In-Reply-To: <44D7A7E6.2060401@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608080359.12958.ak@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 August 2006 22:51, Zachary Amsden wrote:
> Rusty Russell wrote:
> >>> +
> >>> +/*
> >>> + * Set IOPL bits in EFLAGS from given mask
> >>> + */
> >>> +static inline void set_iopl_mask(unsigned mask)
> >>>       
> >> This function can be completely written in C using local_save_flags()/local_restore_flags()
> >> Please do that. I guess it's still a good idea to keep it separated
> >> though because it might allow other optimizations.
> >>
> >> e.g. i've been thinking about special casing IF changes in save/restore flags 
> >> to optimize CPUs which have slow pushf/popf. If you already make sure
> >> all non IF manipulations of flags are separated that would help.
> >>     
> 
> 
> Actually, that is not quite true.  Local_save_flags / 
> raw_local_irq_restore today is used only for operating on IF flag, and 
> raw_local_restore_flags does not exist.  

Yes, sorry for the typo.

> Our implementation of these in  
> VMI assumes that only the IF flag is being changed, and this is the 
> default assumption under which Xen runs as well.  Using local_restore to 
> switch IOPL as well causes the extremely performance critical common 
> case of pure IRQ restore to do potentially a lot more work in a hypervisor.
> 
> So if you do want us to go with the C approach, I would propose using 
> raw_local_iopl_restore, which can make a different hypercall (actually, 
> in our case, this is not even a hypercall, merely a VMI call).

I meant Rusty can use local restore in his native implementation.
The higher level interface can be different.

-Andi
