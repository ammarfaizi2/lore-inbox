Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270264AbUJTBhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270264AbUJTBhL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 21:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270270AbUJTBdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 21:33:18 -0400
Received: from gate.crashing.org ([63.228.1.57]:4251 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S270258AbUJTBbh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 21:31:37 -0400
Subject: Re: [PATCH] generic irq subsystem: ppc64 port
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <20041019091557.GA17473@elte.hu>
References: <200410190714.i9J7Elnx027734@hera.kernel.org>
	 <1098174500.11449.65.camel@gaston>  <20041019091557.GA17473@elte.hu>
Content-Type: text/plain
Message-Id: <1098235499.22943.16.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 11:24:59 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-19 at 19:15, Ingo Molnar wrote:
> * Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > I still like the idea of the patch, so it would be useful if you added
> > the possibility for us to just change that behaviour, that is replace
> > all occursences of irq_descs + i with get_irq_desc() and provide a
> > generic one that just does that, with a #ifndef so that the
> > architecture can provide it's own. 
> 
> sure, we could do that. But since there are other architectures with
> large irq-vector spaces too, you might want to try to move it into the
> generic IRQ code and just provide a way to switch between 1:1 mapped and
> sparse-mapped variants.

False alert ! In fact, Paulus rewrote that stuff a while ago and I
totally forgot about it. We no longer do that, our get_irq_desc()
is nowadays just doing (&irq_desc[(irq)]). We map the large
physical interrupt numbers to "virtual" numbers that are the only
thing the generic code sees, so it's fine. 

Ben.


