Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261398AbSLTLHu>; Fri, 20 Dec 2002 06:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261409AbSLTLHu>; Fri, 20 Dec 2002 06:07:50 -0500
Received: from holomorphy.com ([66.224.33.161]:37573 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261398AbSLTLHt>;
	Fri, 20 Dec 2002 06:07:49 -0500
Date: Fri, 20 Dec 2002 03:15:18 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Kamble, Nitin A" <nitin.a.kamble@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IRQ distribution in the 2.5.52  kernel
Message-ID: <20021220111518.GI25000@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Kamble, Nitin A" <nitin.a.kamble@intel.com>,
	linux-kernel@vger.kernel.org
References: <E88224AA79D2744187E7854CA8D9131DA5CE2F@fmsmsx407.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E88224AA79D2744187E7854CA8D9131DA5CE2F@fmsmsx407.fm.intel.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2002 at 01:08:18AM -0800, Kamble, Nitin A wrote:
> -static inline void balance_irq(int irq)
> +static inline void balance_irq (int cpu, int irq)
>  {
> -	irq_balance_t *entry = irq_balance + irq;
>  	unsigned long now = jiffies;
> -
> +	unsigned long allowed_mask;
> +	unsigned int new_cpu;
> +		
>  	if (clustered_apic_mode)
>  		return;

This can actually be done for clustered_apic_mode, just not as the
IO-APIC is currently programmed. It needs to either:

(1) develop awareness of multiple APIC buses and not attempt to perform
	physical mode interrupt delivery to non-existant destinations or
	overflow destination bitmasks to cpus not physically addressible
	from the local cluster

or

(2) the IO-APIC must be programmed for clustered hierarchical destinations
	in clustered setups, which probably isn't that hot an idea as the
	IO-APIC's in such setups usually have some affinity to the locally
	addressible physical destinations

These are both a PITA, but I thought I'd just sort of fling the issues
into open discussion since something touching this code hit the list.

There's some complexity in these schemes so unless you feel brave and/or
interested there's no need for you to run off and implement them etc.

No criticism of or flaws in your patch implied.


Thanks,
Bill
