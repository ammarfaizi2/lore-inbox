Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268089AbUJSJO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268089AbUJSJO6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 05:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268092AbUJSJO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 05:14:58 -0400
Received: from mx1.elte.hu ([157.181.1.137]:11925 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268089AbUJSJOs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:14:48 -0400
Date: Tue, 19 Oct 2004 11:15:57 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] generic irq subsystem: ppc64 port
Message-ID: <20041019091557.GA17473@elte.hu>
References: <200410190714.i9J7Elnx027734@hera.kernel.org> <1098174500.11449.65.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098174500.11449.65.camel@gaston>
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


* Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> I still like the idea of the patch, so it would be useful if you added
> the possibility for us to just change that behaviour, that is replace
> all occursences of irq_descs + i with get_irq_desc() and provide a
> generic one that just does that, with a #ifndef so that the
> architecture can provide it's own. 

sure, we could do that. But since there are other architectures with
large irq-vector spaces too, you might want to try to move it into the
generic IRQ code and just provide a way to switch between 1:1 mapped and
sparse-mapped variants.

(of course this still means all of the direct indexing in kernel/irq/*.c
would have to change.)

	Ingo
