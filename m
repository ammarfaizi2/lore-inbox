Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262258AbTANLEw>; Tue, 14 Jan 2003 06:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262289AbTANLEw>; Tue, 14 Jan 2003 06:04:52 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:23542 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S262258AbTANLEv> convert rfc822-to-8bit; Tue, 14 Jan 2003 06:04:51 -0500
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Theurer <habanero@us.ibm.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [Lse-tech] Re: NUMA scheduler 2nd approach
Date: Tue, 14 Jan 2003 12:14:12 +0100
User-Agent: KMail/1.4.3
Cc: Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
References: <52570000.1042156448@flay> <000201c2bb97$02bc35e0$29060e09@andrewhcsltgw8> <352680000.1042520180@titus>
In-Reply-To: <352680000.1042520180@titus>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301141214.12323.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

> Before we tweak this too much, how about using the global load
> average for this? I can envisage a situation where we have two
> nodes with 8 tasks per node, one with 12 tasks, and one with four.
> You really don't want the ones with 8 tasks pulling stuff from
> the 12 ... only for the least loaded node to start pulling stuff
> later.

Hmmm, yet another idea from the old NUMA scheduler coming back,
therefore it has my full support ;-). Though we can't do it as I did
it there: in the old NUMA approach every cross-node steal was delayed,
only 1-2ms if the own node was underloaded, a lot more if the own
node's load was average or above average. We might need to finally
steal something even if we're having "above average" load, because the
cpu mask of the tasks on the overloaded node might only allow them to
migrate to us... But this is also a special case which we should solve
later.


> What about if we take the global load average, and multiply by
> num_cpus_on_this_node / num_cpus_globally ... that'll give us
> roughly what we should have on this node. If we're significantly
> out underloaded compared to that, we start pulling stuff from
> the busiest node? And you get the damping over time for free.

Patch 05 is going towards this direction but the constants I chose
were very aggressive. I'll update the whole set of patches and try to
send out something today.

Best regards,
Erich

