Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318282AbSHZUHq>; Mon, 26 Aug 2002 16:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318283AbSHZUHq>; Mon, 26 Aug 2002 16:07:46 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:34576 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318282AbSHZUHp>; Mon, 26 Aug 2002 16:07:45 -0400
Date: Mon, 26 Aug 2002 21:11:59 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Robert Love <rml@tech9.net>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] per-arch load balancing
Message-ID: <20020826211159.A6186@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Robert Love <rml@tech9.net>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <1030392283.1020.407.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1030392283.1020.407.camel@phantasy>; from rml@tech9.net on Mon, Aug 26, 2002 at 04:04:43PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2002 at 04:04:43PM -0400, Robert Love wrote:
> Linus,
> 
> The attached patch implements (optional) per-architecture load balancing
> so we can cleanly implement specialized load balancing behavior for
> NUMA, hyperthreading, etc.
> 
> The new method is "arch_load_balance()" and is defined (if available) in
> asm/smp_balance.h - otherwise it defines away.  Currently, we call it
> from "find_busiest_queue()".

Can we have a asm/sched.h instead?  especially if we might add additional
per-arch scheduler bits.  Also I think a asm-generic version is better than
linux/smp_balance.h + the ARCH_HAS_SMP_BALANCE hack.  I'd prefer if you
would move the #include ontop ot sched.c, too - includes in the middle of
a file are really messy.

