Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266376AbUIIRc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266376AbUIIRc5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 13:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266425AbUIIRZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 13:25:29 -0400
Received: from mx2.elte.hu ([157.181.151.9]:32220 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266376AbUIIRWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 13:22:35 -0400
Date: Thu, 9 Sep 2004 19:24:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org, Scott Wood <scott@timesys.com>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch] generic-hardirqs-2.6.9-rc1-mm4.patch
Message-ID: <20040909172401.GA28376@elte.hu>
References: <20040908133445.A31267@infradead.org> <20040908124547.GA19231@elte.hu> <20040908125755.GC3106@holomorphy.com> <Pine.LNX.4.53.0409080932050.15087@montezuma.fsmlabs.com> <20040908143143.A32002@infradead.org> <Pine.LNX.4.53.0409080938470.15087@montezuma.fsmlabs.com> <1094652572.2800.14.camel@laptop.fenrus.com> <20040908182509.GA6009@elte.hu> <20040908211415.GA20168@elte.hu> <20040909175748.A12336@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909175748.A12336@infradead.org>
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

> > > latest patch attached - this should compile on every architecture.
> > > It's basically what Christoph suggested first time around :-)
> > > Compiles/boots on x86. Any other observations?
> > 
> > i've attached generic-hardirqs-2.6.9-rc1-mm4.patch which is a merge
> > against -mm4. x86 and x64 compiles & boots fine. Since there are zero
> > changes to non-x86 architectures it should build fine on all platforms.
> 
> Looks good to me.  I no one else beats me I'll look into converting
> ppc32/64 this weekend.

you can find a pretty good approximation done by Scott Wood (and Andrey
Panin?) in the ppc/ppc64 portion of the VP patches:

 http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk12-S0

basically you only have to zap some of the irq-threading changes such as
calls to redirect_hardirq(), do a s/generic_// and zap the PIC changes
(these are done for redirection too). Scott has tested those changes so
kernel/hardirq.c should work pretty well with ppc/ppc64.

	Ingo
