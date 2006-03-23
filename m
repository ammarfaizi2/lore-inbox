Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932519AbWCWWfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519AbWCWWfv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 17:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbWCWWfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 17:35:51 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:29573
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932519AbWCWWfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 17:35:50 -0500
Date: Thu, 23 Mar 2006 14:35:47 -0800 (PST)
Message-Id: <20060323.143547.77042819.davem@davemloft.net>
To: jamagallon@able.es
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make __get_cpu_var use raw_smp_processor_id()
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060323221125.0aacd6c4@werewolf.auna.net>
References: <20060323014046.2ca1d9df.akpm@osdl.org>
	<20060323220711.28fcb82f@werewolf.auna.net>
	<20060323221125.0aacd6c4@werewolf.auna.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "J.A. Magallon" <jamagallon@able.es>
Date: Thu, 23 Mar 2006 22:11:25 +0100

> --- linux-2.6.15-rc5/include/asm-generic/percpu.h.orig	2005-12-21 15:13:27.000000000 -0600
> +++ linux-2.6.15-rc5/include/asm-generic/percpu.h	2005-12-21 15:13:43.000000000 -0600
> @@ -13,7 +13,7 @@ extern unsigned long __per_cpu_offset[NR
>  
>  /* var is in discarded region: offset to particular copy we want */
>  #define per_cpu(var, cpu) (*RELOC_HIDE(&per_cpu__##var, __per_cpu_offset[cpu]))
> -#define __get_cpu_var(var) per_cpu(var, smp_processor_id())
> +#define __get_cpu_var(var) per_cpu(var, raw_smp_processor_id())

I'm skeptical because this has caught real bugs in the past.

Unfortunately other platforms that hard-code the per-cpu
area into a cpu register, and thus implement __get_cpu_var()
without a smp_processor_id() call, don't get the debugging
check.
