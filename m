Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318072AbSG2VD7>; Mon, 29 Jul 2002 17:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318164AbSG2VD7>; Mon, 29 Jul 2002 17:03:59 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:62864 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S318072AbSG2VD6> convert rfc822-to-8bit; Mon, 29 Jul 2002 17:03:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andrew Theurer <habanero@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.4.19-rc3 (hyperthreading)
Date: Mon, 29 Jul 2002 15:58:47 -0500
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
References: <200207291454.30076.habanero@us.ibm.com> <1027978122.4050.22.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1027978122.4050.22.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207291558.47266.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 July 2002 4:28 pm, Alan Cox wrote:
> On Mon, 2002-07-29 at 20:54, Andrew Theurer wrote:
> > I would caution against having hyperthreading on by default in the 2.4.19
> > release.  I am seeing a significant degrade in network workloads on P4
> > with hyperthreading on.  On 2.4.19-pre10, I get 788 Mbps on NetBench, but
> > on 2.4.19-rc1 (and probably rc3, should know in an hour), I get 690 Mbps.
> >  It is clearly a hyperthreading/interrupt routing issue.  On this system
> > (4 x P4),
>
> Quite possibly. I've just merged the O(1) scheduler load balancing fixes
> for the hyperthreading stuff, rc3 uses the old scheduler so that isnt
> your problem. For most workloads I see a speed up. The more cache
> optimised the workload the less the speedup.
>
> Its quite possible the irq routing ought to be smarter, at the moment
> I'm not sure of the best approaches.

Agreed, we need some sort of irqbalance, and I intend to test with Ingo's and 
Andrea's approaches. With that addition, I may even see an improvement with 
hyperthreading. But for an rc release, I think it would be prudent to revert 
the "new code" for default hyperthreading behavior, and attack the whole 
problem in 2.4.20 or later release.

-Andrew Theurer

