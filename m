Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbWEBGPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbWEBGPH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 02:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWEBGPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 02:15:06 -0400
Received: from ns.suse.de ([195.135.220.2]:42964 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932390AbWEBGPE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 02:15:04 -0400
From: Andi Kleen <ak@suse.de>
To: "Brown, Len" <len.brown@intel.com>
Subject: Re: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Date: Tue, 2 May 2006 08:14:48 +0200
User-Agent: KMail/1.9.1
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>,
       sergio@sergiomb.no-ip.org, "Kimball Murray" <kimball.murray@gmail.com>,
       linux-kernel@vger.kernel.org, akpm@digeo.com, kmurray@redhat.com,
       linux-acpi@vger.kernel.org
References: <CFF307C98FEABE47A452B27C06B85BB652DDDD@hdsmsx411.amr.corp.intel.com>
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB652DDDD@hdsmsx411.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605020814.49144.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >- Modify do_IRQ to get passed an interrupt vector# from the
> >  interrupt vector instead of an irq number, and then lookup
> >  the irq number in vector_irq.  This means we don't need
> >  a code stub per irq, and allows us to handle more irqs
> >  by simply increasing NR_IRQS.
> 
> isn't the vector number already on the stack from
> ENTRY(interrupt)
> 	pushl $vector-256

Yes - and interrupts/vectors are currently always identical. If we go
to per CPU IDTs I suspect the stubs will just need to be generated
at runtime and start passing interrupts.

-Andi
