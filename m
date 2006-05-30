Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751483AbWE3Ndx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbWE3Ndx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 09:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWE3Ndw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 09:33:52 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:5055 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751483AbWE3Ndw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 09:33:52 -0400
Date: Tue, 30 May 2006 15:33:43 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 61/61] lock validator: enable lock validator in Kconfig
In-Reply-To: <20060529212812.GI3155@elte.hu>
Message-ID: <Pine.LNX.4.64.0605301525510.17704@scrub.home>
References: <20060529212812.GI3155@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 29 May 2006, Ingo Molnar wrote:

> Index: linux/lib/Kconfig.debug
> ===================================================================
> --- linux.orig/lib/Kconfig.debug
> +++ linux/lib/Kconfig.debug
> @@ -184,6 +184,173 @@ config DEBUG_SPINLOCK
>  	  best used in conjunction with the NMI watchdog so that spinlock
>  	  deadlocks are also debuggable.
>  
> +config PROVE_SPIN_LOCKING
> +	bool "Prove spin-locking correctness"
> +	default y

Could you please keep all the defaults in a separate -mm-only patch, so 
it doesn't get merged?
There are also a number of dependencies on DEBUG_KERNEL missing, it 
completely breaks the debugging menu.

> +config LOCKDEP
> +	bool
> +	default y
> +	depends on PROVE_SPIN_LOCKING || PROVE_RW_LOCKING || PROVE_MUTEX_LOCKING || PROVE_RWSEM_LOCKING

This can be written shorter as:

config LOCKDEP
	def_bool PROVE_SPIN_LOCKING || PROVE_RW_LOCKING || PROVE_MUTEX_LOCKING || PROVE_RWSEM_LOCKING

bye, Roman
