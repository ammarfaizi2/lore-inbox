Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbULLCyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbULLCyE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 21:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbULLCyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 21:54:03 -0500
Received: from fsmlabs.com ([168.103.115.128]:52702 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261431AbULLCxs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 21:53:48 -0500
Date: Sat, 11 Dec 2004 19:53:19 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: George Anzinger <george@mvista.com>
cc: Manfred Spraul <manfred@colorfullife.com>,
       Lee Revell <rlrevell@joe-job.com>, dipankar@in.ibm.com,
       ganzinger@mvista.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: RCU question
In-Reply-To: <41BB25B2.90303@mvista.com>
Message-ID: <Pine.LNX.4.61.0412111947280.7847@montezuma.fsmlabs.com>
References: <41B8E6F1.4070007@mvista.com> <20041210043102.GC4161@in.ibm.com>
  <41B9FC3F.50601@mvista.com>  <20041210204003.GC4073@in.ibm.com>
 <1102711532.29919.35.camel@krustophenia.net> <41BA0ECF.1060203@mvista.com>
 <Pine.LNX.4.61.0412101558240.24986@montezuma.fsmlabs.com> <41BA59F6.5010309@mvista.com>
 <Pine.LNX.4.61.0412101943260.1101@montezuma.fsmlabs.com> <41BA698E.8000603@mvista.com>
 <Pine.LNX.4.61.0412110751020.5214@montezuma.fsmlabs.com> <41BB2108.70606@colorfullife.com>
 <41BB25B2.90303@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Dec 2004, George Anzinger wrote:

> Manfred Spraul wrote:
> > >  
> > The trick is the sti instruction: It enables interrupt processing after the
> > following instruction.
> > 
> > Thus
> >    sti
> >    hlt
> > 
> > cannot race - it atomically enables interrupts and waits.
> 
> Exactly :)

Ok i wasn't aware that it was safe_halt() that he was referring too, my 
poor assumption. But regardless, this seems highly fragile and relying on 
behaviour which may change across processor models/vendors. I also found 
the following excerpt from (http://sandpile.org/ia32/inter.htm) which you 
may find interesting;

"Intel processors don't suppress SMI or NMI after an STI instruction. 
Since the INTR suppresion is not preserved across an SMI or NMI handler, 
this may result in an INTR being serviced after the STI, which constitutes 
a violation of the INTR suppresion. Therefore, ideally the STI instruction 
also suppresses SMI and NMI."

George thanks for persisting and explaining your point, i can be very slow 
=)

	Zwane
