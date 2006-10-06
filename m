Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422767AbWJFRPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422767AbWJFRPE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 13:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422761AbWJFRPC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 13:15:02 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:17106 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1422764AbWJFRPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 13:15:00 -0400
Date: Fri, 6 Oct 2006 10:14:53 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Tommaso Cucinotta <cucinotta@sssup.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: In-kernel precise timing.
In-Reply-To: <45259F9F.1050203@sssup.it>
Message-ID: <Pine.LNX.4.64.0610061011500.14591@schroedinger.engr.sgi.com>
References: <45259F9F.1050203@sssup.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Oct 2006, Tommaso Cucinotta wrote:

> I'd like to know what is the preferrable way,
> in a Linux kernel module, to get a notification
> at a time in the future so to avoid as much as
> possible unpredictable delays due to possible
> device driver interferences. Basically, I would
> like to use such a mechanism to preempt (also)
> real-time tasks for the purpose of temporally
> isolating them from among each other.
> 
> Is there any prioritary mechanism for specifying
> kind of higher priority timers, to be served as
> soon as possible, vs. lower priority ones, that
> could be e.g. delayed to ksoftirqd and similar ?
> (referring to 2.6.17/18, currently using add_timer(),
> del_timer(), but AFAICS these primitives are more
> appropriate for "timeout" behaviours, rather than
> "precise timing" ones).

This is possible via a hardware interrupt. HPET chips and also the PIT 
provide the ability to schedule an ihterrupts in the future. The periodic 
timer tick is such a mechanism that is also used by the scheduler to 
preempt processes. If the interrupt has sufficiently high priority then 
you could avoid many interrupt holdoffs. However, you may not be able to 
do much since you have no process context. Plus this may be nothing else 
than duplicating already existing functionality.

