Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286825AbSCOIzv>; Fri, 15 Mar 2002 03:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286521AbSCOIzm>; Fri, 15 Mar 2002 03:55:42 -0500
Received: from mx2.elte.hu ([157.181.151.9]:8379 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S286647AbSCOIzX>;
	Fri, 15 Mar 2002 03:55:23 -0500
Date: Fri, 15 Mar 2002 08:50:43 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>, <oliend@us.ibm.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Severe IRQ problems on Foster (P4 Xeon) system
In-Reply-To: <41140000.1016130154@flay>
Message-ID: <Pine.LNX.4.44.0203150847150.11415-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 14 Mar 2002, Martin J. Bligh wrote:

> >> Btw is it correct that one could also use the APIC Task Priority Registers
> >> to implement "fair" IRQ routing? (If linux adjusted them, which it
> >> currently doesn't).
> > 
> > Yes, and Dave Olien has already done this. It's a good idea for P3,
> > and seems to me to be essential for P4. 

another problem with TPR-based IRQ routing (in addition to the ones i
mentioned in the previous mail) is that if you 'deny' certain IRQs via the
TPR, then if all CPUs run kernel-intensive jobs, then IRQs will never be
served by any of the CPUs (or will be served only after a long latency).  
Sure, this can be hacked around, but if gets ugly very fast and doesnt get
us very far. All in one, i found the TPR to be not flexible enough for
what we really want: good IRQ distribution and good IRQ affinity at once.

	Ingo

