Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262373AbVFVWEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbVFVWEs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 18:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbVFVWEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 18:04:35 -0400
Received: from gate.ebshome.net ([64.81.67.12]:55492 "EHLO gate.ebshome.net")
	by vger.kernel.org with ESMTP id S262539AbVFVV60 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 17:58:26 -0400
Date: Wed, 22 Jun 2005 14:58:18 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Kumar Gala <galak@freescale.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] ppc32: Add support for Freescale e200 (Book-E) core
Message-ID: <20050622215818.GA15176@gate.ebshome.net>
Mail-Followup-To: Kumar Gala <galak@freescale.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
References: <Pine.LNX.4.61.0506221539470.3206@nylon.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0506221539470.3206@nylon.am.freescale.net>
X-ICQ-UIN: 1193073
X-Operating-System: Linux i686
X-PGP-Key: http://www.ebshome.net/pubkey.asc
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 03:41:09PM -0500, Kumar Gala wrote:

[snip]

> +#ifdef CONFIG_E200
> +#define DEBUG_EXCEPTION							      \
> +	START_EXCEPTION(Debug);						      \
> +	DEBUG_EXCEPTION_PROLOG;						      \
> +									      \
> +	/*								      \
> +	 * If there is a single step or branch-taken exception in an	      \
> +	 * exception entry sequence, it was probably meant to apply to	      \
> +	 * the code where the exception occurred (since exception entry	      \
> +	 * doesn't turn off DE automatically).  We simulate the effect	      \
> +	 * of turning off DE on entry to an exception handler by turning      \
> +	 * off DE in the CSRR1 value and clearing the debug status.	      \
> +	 */								      \
> +	mfspr	r10,SPRN_DBSR;		/* check single-step/branch taken */  \
> +	andis.	r10,r10,DBSR_IC@h;					      \
> +	beq+	2f;							      \
> +									      \
> +	lis	r10,KERNELBASE@h;	/* check if exception in vectors */   \
> +	ori	r10,r10,KERNELBASE@l;					      \

I think we can get rid of one instruction here :)

-- 
Eugene


