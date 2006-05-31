Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932493AbWEaFpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbWEaFpo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 01:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbWEaFpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 01:45:43 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:48800 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932488AbWEaFpn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 01:45:43 -0400
Date: Wed, 31 May 2006 07:46:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, rdreier@cisco.com, tglx@linutronix.de,
       mm-commits@vger.kernel.org
Subject: Re: + genirq-msi-fixes.patch added to -mm tree
Message-ID: <20060531054605.GA18707@elte.hu>
References: <200605302342.k4UNgGYW002807@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605302342.k4UNgGYW002807@shell0.pdx.osdl.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* akpm@osdl.org <akpm@osdl.org> wrote:

> Am not confident about the i386 bits.

> -		desc->handle_irq(irq, desc, regs);
> +	{
> +		if (!irq_desc[irq].handle_irq)
> +			__do_IRQ(irq, regs);
> +		else
> +			generic_handle_irq(irq, regs);
> +	}

yeah, this is not enough - the handle_irq check needs to be done before 
we do the 4KSTACKS thing. I'll cook up a patch.

	Ingo
