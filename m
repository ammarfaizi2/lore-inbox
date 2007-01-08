Return-Path: <linux-kernel-owner+w=401wt.eu-S932066AbXAHVb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbXAHVb0 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 16:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbXAHVb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 16:31:26 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56918 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864AbXAHVbZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 16:31:25 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Lu, Yinghai" <yinghai.lu@amd.com>
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       "Tobias Diedrich" <ranma+kernel@tdiedrich.de>,
       "Andrew Morton" <akpm@osdl.org>, "Adrian Bunk" <bunk@stusta.de>,
       "Andi Kleen" <ak@suse.de>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] x86_64 io_apic: Implement remove_pin_to_irq
References: <5986589C150B2F49A46483AC44C7BCA490736C@ssvlexmb2.amd.com>
Date: Mon, 08 Jan 2007 14:30:53 -0700
In-Reply-To: <5986589C150B2F49A46483AC44C7BCA490736C@ssvlexmb2.amd.com>
	(Yinghai Lu's message of "Mon, 8 Jan 2007 13:09:19 -0800")
Message-ID: <m1ps9pgq9e.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Lu, Yinghai" <yinghai.lu@amd.com> writes:

> -----Original Message-----
> From: ebiederm@xmission.com [mailto:ebiederm@xmission.com] 
> Sent: Monday, January 08, 2007 7:50 AM
> To: Linus Torvalds
> Cc: Tobias Diedrich; Lu, Yinghai; Andrew Morton; Adrian Bunk; Andi
> Kleen; Linux Kernel Mailing List
> Subject: [PATCH 1/4] x86_64 io_apic: Implement remove_pin_to_irq
>
> +static void remove_pin_to_irq(unsigned int irq, int apic, int pin)
> +{
> +	struct irq_pin_list *entry = irq_2_pin + irq;
>
> You may need to update add_pin_to_irq to avoid multi entries for irq 0.

Any updates to add_pin_to_irq are wrong.  It works fine.  If there
is something wrong we need to fix remove_pin_to_irq.

What is the problem you see?  Sorry I'm dense at the moment.

I preserve the invariant that irq_2_pin + irq is always the first
entry in the chain.  I do this when I delete a multi chain entry
by copying the next entry over the current entry, and then freeing
(and leaking) the second entry in the chain.

Is there something wrong with that?  I came within an inch of deleting
this multiple apic, pin to irq mapping code but the comments said it
is needed for some ioapic case.  So in resurrecting this variant I may
have goofed somewhere.

Eric
