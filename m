Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265199AbUG0NPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265199AbUG0NPE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 09:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265215AbUG0NPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 09:15:04 -0400
Received: from ozlabs.org ([203.10.76.45]:31192 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265199AbUG0NPA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 09:15:00 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16646.21807.210253.45979@cargo.ozlabs.ibm.com>
Date: Tue, 27 Jul 2004 08:14:23 -0500
From: Paul Mackerras <paulus@samba.org>
To: jschopp@austin.ibm.com
Cc: akpm@osdl.org, anton@samba.org, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpu hotplug ppc64 bug
In-Reply-To: <410594FF.5040307@austin.ibm.com>
References: <410594FF.5040307@austin.ibm.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Schopp writes:

> On Power4 and earlier hardware there is no need to clear the CPPR (see 
> RPAp 479 section 18.5.4.7.2 for what little info there is on the CPPR) 
> when stopping a cpu. On hardware that uses Power5 an undocumented change 
> has been made that requires the CPPR to be cleared if an isolate is to 
> be done on the stopped cpu. So the following patch lets cpu hotplug work 
> on the recent hardware.

>  void cpu_die(void)
>  {
>  	local_irq_disable();
> +	/* Some hardware requires clearing the CPPR, while other hardware does not
> +	 * it is safe either way
> +	 */
> +	pSeriesLP_cppr_info(0, 0);
>  	rtas_stop_self();

I wanted to do this a bit differently - I was going to make cpu_die be
a platform-specific function called via a ppc_md function pointer,
rather than putting very pseries-specific stuff in smp.c, which is
used on all platforms.  But having been on vacation and then
travelling, I haven't got to it yet.

Paul.
