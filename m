Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbUC3Vhr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 16:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbUC3Vhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 16:37:47 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:40396
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261357AbUC3Vho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 16:37:44 -0500
Date: Tue, 30 Mar 2004 23:37:42 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: kuznet@ms2.inr.ac.ru, dipankar@in.ibm.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, Robert.Olsson@data.slu.se, paulmck@us.ibm.com,
       akpm@osdl.org
Subject: Re: route cache DoS testing and softirqs
Message-ID: <20040330213742.GL3808@dualathlon.random>
References: <20040329222926.GF3808@dualathlon.random> <200403302005.AAA00466@yakov.inr.ac.ru> <20040330211450.GI3808@dualathlon.random> <20040330133000.098761e2.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040330133000.098761e2.davem@redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 01:30:00PM -0800, David S. Miller wrote:
> On Tue, 30 Mar 2004 23:14:50 +0200
> Andrea Arcangeli <andrea@suse.de> wrote:
> 
> > > There are no hardirqs in the case under investigation, remember?
> > 
> > no hardirqs? there must be tons of hardirqs if ksoftirqd never runs.
> 
> NAPI should be kicking in for this workload, and I know for a fact it is
> for Robert's case.  There should only be a few thousand hard irqs per
> second.
> 
> Until the RX ring is depleted the device's hardirqs will not be re-
> enabled.

then Dipankar is reproducing with a workload that is completely
different. I've only seen the emails from Dipankar so I couldn't know it
was a NAPI load.

He posted these numbers:

	softirq_count, ksoftirqd_count and other_softirq_count shows -
	
	CPU 0 : 638240  554     637686
	CPU 1 : 102316  1       102315
	CPU 2 : 675696  557     675139
	CPU 3 : 102305  0       102305

that means nothing runs in ksoftirqd for Dipankar, so he cannot be using
NAPI.

Either that or I'm misreading his numbers, or his stats results are wrong.
