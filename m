Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263350AbUJ2OVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263350AbUJ2OVk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 10:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263343AbUJ2OSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 10:18:12 -0400
Received: from mx1.elte.hu ([157.181.1.137]:38873 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263336AbUJ2OPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 10:15:38 -0400
Date: Fri, 29 Oct 2004 16:16:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Pantelis Antoniou <panto@intracom.gr>
Cc: Tom Rini <trini@kernel.crashing.org>,
       Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix early request_irq
Message-ID: <20041029141648.GB25204@elte.hu>
References: <41824E15.4090906@intracom.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41824E15.4090906@intracom.gr>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Pantelis Antoniou <panto@intracom.gr> wrote:

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

this is quite broken. Those places should use setup_irq(),
not request_irq().

	Ingo
