Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbWFLJaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWFLJaY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 05:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWFLJaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 05:30:24 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:51435 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1751350AbWFLJaV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 05:30:21 -0400
Subject: Re: 2.6.17-rc6-rt3
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20060612092023.GA30872@elte.hu>
References: <20060610082406.GA31985@elte.hu>
	 <1150104040.3835.3.camel@frecb000686>  <20060612092023.GA30872@elte.hu>
Date: Mon, 12 Jun 2006 11:35:08 +0200
Message-Id: <1150104909.3835.5.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 12/06/2006 11:34:01,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 12/06/2006 11:34:03,
	Serialize complete at 12/06/2006 11:34:03
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-12 at 11:20 +0200, Ingo Molnar wrote:
> * Sébastien Dugué <sebastien.dugue@bull.net> wrote:
> 
> > > I think all of the regressions reported against rt1 are fixed, please 
> > > re-report if any of them is still unfixed.
> > 
> >   Great, boots fine on my dual Xeon and solves the ping problem I was 
> > having.
> > 
> >   Thomas, any hint at what was going on?
> 
> the problem was caused by a mismerge of the __raise_softirq_irqoff() 
> changes of preempt-softirqs. In PREEMPT_SOFTIRQS, softirq activation 
> means a wakeup of the softirq thread - hence __raise_softirq_irqoff() 
> must wake up the softirq thead too. This didnt happen in -rt1 so the 
> network softirq (which processes things like ping reply packets) got 
> delayed to the natural softirq event - the next timer interrupt in the 
> usual case. Hence depending on HZ you got a delay of 1-4-10 msecs 
> (divided into two parts).
> 

  Thanks.

  Sébastien.

