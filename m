Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268845AbUIQQHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268845AbUIQQHI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 12:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268995AbUIQQFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 12:05:32 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:51636 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S268968AbUIQQC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 12:02:27 -0400
Date: Fri, 17 Sep 2004 18:01:00 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Stelian Pop <stelian@popies.net>, James R Bruce <bruce@andrew.cmu.edu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Message-ID: <20040917160100.GZ15426@dualathlon.random>
References: <20040913135253.GA3118@crusoe.alcove-fr> <20040915153013.32e797c8.akpm@osdl.org> <20040916064320.GA9886@deep-space-9.dsnet> <20040916000438.46d91e94.akpm@osdl.org> <Pine.LNX.4.60-041.0409170823140.1298@unix48.andrew.cmu.edu> <20040917154834.GA3180@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040917154834.GA3180@crusoe.alcove-fr>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 05:48:35PM +0200, Stelian Pop wrote:
> +	/* verify that size is a power of 2 */
> +	newsize = 1;
> +	while (newsize < size)
> +		newsize <<= 1;
> +	if (newsize != size)
> +		return NULL;

I think you mean:

	BUG_ON(size & (size-1));

;)

> +	fifo = kmalloc(sizeof(struct kfifo), gfp_mask);
> +	if (!fifo)
> +		return NULL;

this could be ERR_PTR(-ENOMEM).

> +	buffer = kmalloc(newsize, gfp_mask);
> +	if (!buffer)
> +		return NULL;

same here.
