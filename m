Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVFANWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVFANWU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 09:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbVFANWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 09:22:19 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:41460 "EHLO
	godzilla.mvista.com") by vger.kernel.org with ESMTP id S261300AbVFANVy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 09:21:54 -0400
Date: Wed, 1 Jun 2005 06:21:50 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-06
In-Reply-To: <20050601131130.GC32232@elte.hu>
Message-ID: <Pine.LNX.4.10.10506010615270.23911-100000@godzilla.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 Jun 2005, Ingo Molnar wrote:

> 
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > > > > existing_sp_head:
> > > > > 	itr_pl2 = container_of(itr_pl->dp_node.prev, struct plist, dp_node);
> > > > > 	list_add(&pl->sp_node, &itr_pl2->sp_node);
> > > > 
> > > > This breaks fifo ordering.
> > > 
> > > Daniel, is the issue (and other issues) Oleg noticed still present? I'm 
> > > still a bit uneasy about the complexity of the plist changes.
> > 
> > I think this one isn't right. We could make a test quite to check
> > correctness. Find the errors before they find us. Oleg may even have
> > something like that already half done. 
> > 
> > Are you concerned with plist as a whole, or just my recent changes?
> > 
> > There is still a problem with plist_for_each() missing the first list 
> > member, which I need to fix.
> 
> plist seems pretty stable now, but i'm still worried about behavioral 
> correctness. The previous method, while it didnt scale as well, was at 
> least more obvious to review.

True, list_add() vs. 200+ lines of code .. I've added our plist to fusyn
with no ill effects. As Oleg suggested I used some userspace code to check
what it was doing, while I was working on it. I've fairly confident in it,
however I do still have some concerns for the same reasons you do.

I could do some cleanup on it, some comments are wrong now. That and a
test suite, maybe that will change the confidence level.

Daniel

