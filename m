Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262546AbVDGSlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbVDGSlG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 14:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbVDGSlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 14:41:06 -0400
Received: from aun.it.uu.se ([130.238.12.36]:16321 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262546AbVDGSlF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 14:41:05 -0400
Date: Thu, 7 Apr 2005 20:40:44 +0200 (MEST)
Message-Id: <200504071840.j37Iei25019895@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: arjan@infradead.org, kaos@sgi.com
Subject: Re: 2.6.12-rc2 in_atomic() picks up preempt_disable()
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Apr 2005 12:17:37 +0200, Arjan van de Ven wrote:
>On Thu, 2005-04-07 at 20:10 +1000, Keith Owens wrote:
>> 2.6.12-rc2, with CONFIG_PREEMPT and CONFIG_PREEMPT_DEBUG.  The
>> in_atomic() macro thinks that preempt_disable() indicates an atomic
>> region so calls to __might_sleep() result in a stack trace.
>
>but you're not allowed to schedule when preempt is disabled!

That sounds draconian. Where is that requirement stated?

A preempt-disabled region ought to have the same semantics
as in a CONFIG_PREEMPT=n kernel, and since schedule is Ok
in the latter case it should be Ok in the former too.

All that preempt_disable() should do is prevent involuntary
schedules. But the conditional schedules introduced by may-sleep
functions are _voluntary_, so there's no reason to forbid them.
