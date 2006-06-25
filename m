Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965517AbWFYT7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965517AbWFYT7g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 15:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965516AbWFYT7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 15:59:36 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:30931 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965512AbWFYT7e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 15:59:34 -0400
Date: Sun, 25 Jun 2006 21:54:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Brown, Len" <len.brown@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, michal.k.k.piotrowski@gmail.com,
       arjan@linux.intel.com, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, "Moore, Robert" <robert.moore@intel.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch] ACPI: reduce code size, clean up, fix validator message
Message-ID: <20060625195440.GC11494@elte.hu>
References: <CFF307C98FEABE47A452B27C06B85BB6CF0D04@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6CF0D04@hdsmsx411.amr.corp.intel.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5007]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Brown, Len <len.brown@intel.com> wrote:

> Ingo,
> Thanks for the quick reply.
> 
> An Andrew's advice a while back, Bob already got rid
> of the allocate part -- it just isn't upstream yet.
> 
> Re: changing ACPICA code (sub-directories of drivers/acpi/) like this:
> 
> >-	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
> >+	spin_lock_irqsave(&acpi_gbl_gpe_lock, flags);
> 
> I can't do that without either
> 1. diverging between Linux and ACPICA
> or
> 2. getting a license back from you to Intel such that Intel can
>    re-distrubute such a change under the Intel license on the file and 
>    inventing spin_lock_irqsave() on about 9 other operating systems.

btw., regarding #2 i hereby put my patch (which i wrote in my free time) 
into the public domain - feel free to reuse it in any way, shape or 
form, under any license. (but it's trivial enough so i guess the only 
copyrightable element is my changelog entry anyway ;)

> If this code were performance or size critical, I would still delete 
> acpi_os_acquire_lock from osl.c, but would inline it in aclinux.h.

well its in the kernel so it's size critical by definition. But it's 
certainly not a highprio thing.

	Ingo
