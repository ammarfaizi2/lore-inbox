Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbVADJEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbVADJEi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 04:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbVADJEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 04:04:38 -0500
Received: from mx2.elte.hu ([157.181.151.9]:25003 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261570AbVADJEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 04:04:33 -0500
Date: Tue, 4 Jan 2005 10:04:08 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm1
Message-ID: <20050104090408.GA12197@elte.hu>
References: <20050103011113.6f6c8f44.akpm@osdl.org> <20050103115120.GB18408@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103115120.GB18408@infradead.org>
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


* Christoph Hellwig <hch@infradead.org> wrote:

> > remove-the-bkl-by-turning-it-into-a-semaphore.patch
> >   remove the BKL by turning it into a semaphore
> 
> This _smp_processor_id() mess is horribly ugly.  Do you really need
> that debug check?

wrt. necessity, it's quite handy: check out the 2.6.10 changelog, almost
all preemption bugs wrt. smp_processor_id() were found this way.

what precisely is the 'mess' you are referring to?

is it the way the include file falls back to the original
smp_processor_id() definition if an arch doesnt define
__smp_processor_id()? I could get rid of that and just require every
arch to define __smp_processor_id().

or is it the addition of _smp_processor_id() as a way to signal 'this
smp_processor_id() call in a preemptible region is fine, trust me'? We
could do smp_processor_id_preempt() or some other name - any better
suggestions?

	Ingo
