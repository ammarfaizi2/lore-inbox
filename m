Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265488AbTLHRhW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 12:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265494AbTLHRhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 12:37:22 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:60290
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S265488AbTLHRhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 12:37:21 -0500
Date: Mon, 8 Dec 2003 12:36:20 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: bill davidsen <davidsen@tmr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: SMP broken on Dell PowerEdge 4100/200 under 2.6.0-testxx?
In-Reply-To: <br26a9$f6j$1@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.58.0312081224480.5919@montezuma.fsmlabs.com>
References: <3350.192.168.1.3.1070677965.squirrel@www.coesta.com>
 <20031206043757.GJ8039@holomorphy.com> <1070686126.1166.0.camel@chevrolet.hybel>
 <20031206045409.GK8039@holomorphy.com> <br26a9$f6j$1@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Dec 2003, bill davidsen wrote:

> I think the most confusing thing about this was the choice of
> "noirqbalance" as an option to mean "do balance irqs." I'm not sure that
> the default to put all irqs on a single CPU is optimal in any case, but
> the naming is particularly bad.

Actually, noirqbalance means no in kernel irq balancer. ia32 SMP systems
before P4 tend to RR interrupt handling via hardware by utilising an APIC
bus arbitration scheme. P4 doesn't, one reason being the missing
Arbitration ID register and the usage of a bus cycle to determine which
processor should handle the interrupt depending on the status of the Task
Priority Register on each local apic (processor). So in essence we should
be using the TPR to do interrupt balancing decisions with P4/Xeon. So all
noirqbalance will do is disable in kernel balancer.
