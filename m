Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263353AbUJ2O3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263353AbUJ2O3b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 10:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263336AbUJ2O0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 10:26:31 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:57604 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263342AbUJ2OY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 10:24:27 -0400
Date: Fri, 29 Oct 2004 15:21:04 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pantelis Antoniou <panto@intracom.gr>
Cc: Ingo Molnar <mingo@elte.hu>, Tom Rini <trini@kernel.crashing.org>,
       Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix early request_irq
Message-ID: <20041029142104.GB13092@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pantelis Antoniou <panto@intracom.gr>, Ingo Molnar <mingo@elte.hu>,
	Tom Rini <trini@kernel.crashing.org>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <41824E15.4090906@intracom.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41824E15.4090906@intracom.gr>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 05:05:09PM +0300, Pantelis Antoniou wrote:
> Hi there
> 
> The recent consolidation of the IRQ code has caused
> a number of PPC embedded cpus to stop working.
> 
> The problem is that on init_IRQ these platforms call
> request_irq very early, which in turn calls kmalloc
> without the memory subsystem being initialized.
> 
> The following patch fixes it by keeping a small static
> array of irqactions just for this purpose.

This is bogus.  Switch them to use setup_irq instead like
I did for pmac.

