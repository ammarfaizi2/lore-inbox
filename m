Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbULJW73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbULJW73 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 17:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbULJW72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 17:59:28 -0500
Received: from fsmlabs.com ([168.103.115.128]:29847 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261857AbULJW7W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 17:59:22 -0500
Date: Fri, 10 Dec 2004 15:58:52 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: George Anzinger <george@mvista.com>
cc: Lee Revell <rlrevell@joe-job.com>, dipankar@in.ibm.com,
       ganzinger@mvista.com, Manfred Spraul <manfred@colorfullife.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: RCU question
In-Reply-To: <41BA0ECF.1060203@mvista.com>
Message-ID: <Pine.LNX.4.61.0412101558240.24986@montezuma.fsmlabs.com>
References: <41B8E6F1.4070007@mvista.com> <20041210043102.GC4161@in.ibm.com>
  <41B9FC3F.50601@mvista.com>  <20041210204003.GC4073@in.ibm.com>
 <1102711532.29919.35.camel@krustophenia.net> <41BA0ECF.1060203@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2004, George Anzinger wrote:

> > Well, softirqs should really be preemptible if you care about RT task
> > latency.  Ingo's patches have had this for months.  Works great.  Maybe
> > it's time to push it upstream.
> 
> Yes, I understand, and soft_irq() does turn on interrupts...
> I was thinking of something like:
> 
> 	while(softirq_pending()) {
> 		local_irq_enable();
> 		do_softirq();
> 		local_irq_disable();
> 	}
> 		<proceed to idle hlt...>

But that's a deadlock and if you enable interrupts you race.
