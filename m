Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbUENSI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbUENSI5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 14:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbUENSI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 14:08:57 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:50900 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261988AbUENSIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 14:08:53 -0400
Date: Fri, 14 May 2004 11:07:06 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH][4/7] perfctr-2.7.2 for 2.6.6-mm2: PowerPC
Message-ID: <20040514180706.GR2196@smtp.west.cox.net>
References: <200405141411.i4EEBdvW018419@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405141411.i4EEBdvW018419@alkaid.it.uu.se>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2004 at 04:11:39PM +0200, Mikael Pettersson wrote:

> perfctr-2.7.2 for 2.6.6-mm2, part 4/7:
[snip]
> --- linux-2.6.6-mm2/drivers/perfctr/ppc.c	1970-01-01 01:00:00.000000000 +0100
[snip]
> +#define SPRN_MMCR0	0x3B8	/* 604 and up */
[snip]
> +#define MMCR2_RESERVED		(MMCR2_SMCNTEN | MMCR2_SMINTEN | MMCR2__RESERVED)

All of these belong in <asm-ppc/reg.h>.

[snip]
 +static int __init generic_init(void)
> +{
> +	static char generic_name[] __initdata = "PowerPC 60x/7xx/74xx";
> +	unsigned int features;
> +	enum pll_type pll_type;
> +	unsigned int pvr;
> +
> +	features = PERFCTR_FEATURE_RDTSC | PERFCTR_FEATURE_RDPMC;
> +	pvr = mfspr(SPRN_PVR);
> +	switch( PVR_VER(pvr) ) {
> +	case 0x0004: /* 604 */
> +		pm_type = PM_604;
> +		pll_type = PLL_NONE;
> +		features = PERFCTR_FEATURE_RDTSC;
> +		break;

This should all be done with cputable bits I would think.
arch/ppc/kernel/cputable.c and include/asm-ppc/cputable.h
(CPU_FTR_PERFCTR_PLL_{NONE,604e,...) and then
if (cur_cpu_spec[i]->cpu_features & CPU_FTR_PERFCTL_PLL_NONE)
  pll_type = PLL_NONE

Or might that be bigger, code wise, in the end?

-- 
Tom Rini
http://gate.crashing.org/~trini/
