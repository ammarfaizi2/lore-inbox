Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269632AbUJSSeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269632AbUJSSeN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 14:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269602AbUJSScf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 14:32:35 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:4803 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S270065AbUJSSby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 14:31:54 -0400
Subject: Re: tun.c patch to fix "smp_processor_id() in preemptible code"
From: Lee Revell <rlrevell@joe-job.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Linux Network Development <netdev@oss.sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200410172314.38597.vda@port.imtp.ilyichevsk.odessa.ua>
References: <1097876587.4170.16.camel@marvin.home.parkautomat.net>
	 <1097879702.6737.7.camel@krustophenia.net>
	 <200410172314.38597.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Message-Id: <1098210711.2148.69.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 19 Oct 2004 14:31:52 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-17 at 16:14, Denis Vlasenko wrote:
> > Your patch:
> > 
> > +       preempt_disable();
> >         netif_rx_ni(skb);
> > +       preempt_enable();
> > 
> > just wraps this code in preempt_disable/enable:
> > 
> > static inline int netif_rx_ni(struct sk_buff *skb)
> > {
> >        int err = netif_rx(skb);
> >        if (softirq_pending(smp_processor_id()))
> >                do_softirq();
> >        return err;
> > }
> > 
> > Isn't this considered an incorrect use of preempt_disable/enable?  My
> > reasoning is that if this was correct we would see preempt_dis/enable
> > sprinkled all over the code which it isn't.
> > 
> > Why do you have to call do_softirq like that?  I was under the
> > impression that you raise a softirq and it gets run later.
> 
> There is a possibility that this guy just wanted to fix his
> small problem.
> 

Yes, that is what I thought.  The question was more directed at the
list.  I added netdev to the cc:.  

I looked at Robert Love's book and I am still unclear on the use of
do_softirq above.  To reiterate the question:  why does netif_rx_ni have
to manually flush any pending softirqs on the current proccessor after
doing the rx?  Is this just a performance hack?

Lee


