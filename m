Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbWDIGDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWDIGDG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 02:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWDIGDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 02:03:06 -0400
Received: from cantor.suse.de ([195.135.220.2]:15803 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751363AbWDIGDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 02:03:05 -0400
From: Neil Brown <neilb@suse.de>
To: Lee Revell <rlrevell@joe-job.com>
Date: Sun, 9 Apr 2006 16:02:34 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17464.41850.899740.926052@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16] Shared interrupts sometimes lost
In-Reply-To: message from Lee Revell on Saturday April 8
References: <17463.14285.31029.943738@cse.unsw.edu.au>
	<1144513897.22490.154.camel@mindpipe>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday April 8, rlrevell@joe-job.com wrote:
> On Sat, 2006-04-08 at 14:10 +1000, Neil Brown wrote:
> > 
> >  To explain what I think is happening, let me start with a very simple
> >  case.  A number of PCI devices (this one included) have a number of
> >  events which can trigger an interrupt.  The events which are current
> >  are presented as bits in a register, and are ORed together (and
> >  possibly masked by another register) to make the IRQ line.
> >  When 1's are written to any bits in this register, it acknowledges
> >  the event and clears the bit.
> >  A typical code fragment is 
> >    events = read_register(INTERRUPTS);
> >    write_register(INTERRUPTS, events);
> >    ... handle each 1 bits in events ....
> > 
> 
> Isn't a more typical IRQ handler:
> 
> while (events = read_register(INTERRUPTS) != 0) {
> 	...handle each bit in events and ACK it...
> }

Maybe... I admit that I generalised from 2 examples: rt2500 and yenta.
However I don't think it makes a big difference to the problem with
shared interrupts (assuming my analysis is right).

The loop isn't really necessary if you are sure that unserviced
interrupts will be re-asserted (as level-triggered interrupts would
be) (though it may still help performance) and the loop isn't
sufficient if you need to be sure that all events get services (as
there may be more in the shared-chain).

Thanks,
NeilBrown
