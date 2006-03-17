Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752490AbWCQCJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbWCQCJu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 21:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752487AbWCQCJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 21:09:50 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:44727 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752481AbWCQCJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 21:09:49 -0500
Date: Fri, 17 Mar 2006 02:09:42 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Dimitri Sivanich <sivanich@sgi.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Christoph Lameter <clameter@sgi.com>, Jes Sorensen <jes@sgi.com>
Subject: Re: [PATCH] Add SA_PERCPU_IRQ flag support
Message-ID: <20060317020942.GA20227@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dimitri Sivanich <sivanich@sgi.com>,
	Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Lameter <clameter@sgi.com>,
	Jes Sorensen <jes@sgi.com>
References: <20060317003114.GA1735@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060317003114.GA1735@sgi.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 06:31:14PM -0600, Dimitri Sivanich wrote:
> The generic request_irq/setup_irq code should support the SA_PERCPU_IRQ flag.
> 
> Not sure why it was left out, but this patch adds that support.
> 
> Signed-off-by: Dimitri Sivanich <sivanich@sgi.com>
> 
> Index: linux/kernel/irq/manage.c
> ===================================================================
> --- linux.orig/kernel/irq/manage.c	2006-03-16 14:05:27.957927445 -0600
> +++ linux/kernel/irq/manage.c	2006-03-16 14:06:02.283661867 -0600
> @@ -201,6 +201,9 @@ int setup_irq(unsigned int irq, struct i
>  	 * The following block of code has to be executed atomically
>  	 */
>  	spin_lock_irqsave(&desc->lock,flags);
> +	if (new->flags & SA_PERCPU_IRQ) {
> +		desc->status |= IRQ_PER_CPU;
> +	}

looks good, although the braces aren't really needed for single-line
conditionals.

