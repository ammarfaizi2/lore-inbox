Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVA0UcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVA0UcZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 15:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbVA0UcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 15:32:24 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:35536 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261174AbVA0UcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 15:32:11 -0500
Date: Thu, 27 Jan 2005 20:32:06 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: Patch 4/6  randomize the stack pointer
Message-ID: <20050127203206.GA2180@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
References: <20050127101117.GA9760@infradead.org> <20050127101322.GE9760@infradead.org> <20050127202335.GA2033@infradead.org> <20050127202720.GA12390@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127202720.GA12390@infradead.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The patch below replaces the existing 8Kb randomisation of the userspace
> stack pointer (which is currently only done for Hyperthreaded P-IVs) with a
> more general randomisation over a 64Kb range. 64Kb is not a lot, but it's a
> start and once the dust settles we can increase this value to a more
> agressive value.

Why are we doing this for x86 only, btw? 

> +unsigned long arch_align_stack(unsigned long sp)
> +{
> +	if (randomize_va_space)
> +		sp -= ((get_random_int() % 4096) << 4);
> +	return sp & ~0xf;
> +}

this looks like it'd work nicely on all architectures.

