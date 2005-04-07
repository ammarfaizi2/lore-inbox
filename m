Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262512AbVDGQZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262512AbVDGQZV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 12:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262513AbVDGQZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 12:25:21 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:56207 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262512AbVDGQZN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 12:25:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding;
        b=iCkUwAGQ093YSgNcD7L5zNIxjt6UQWgchjSfNdzUYCECD6fcIHZu2KsF2q7lQb0bB+BxzN1QUZXApeGPg2l29EiUZ2Rs90Z4cXNqx1W+5HTPEiQ/lPKSF7rs+ICjZdxOpa46XonCM9filIszNzOawYdaXqSq5oomj4eZK4D8kVo=
Message-ID: <36c1843405040709252bd07696@mail.gmail.com>
Date: Thu, 7 Apr 2005 21:55:13 +0530
From: Srivatsa Vaddagiri <vsrivatsa@gmail.com>
Reply-To: Srivatsa Vaddagiri <vsrivatsa@gmail.com>
To: mingo@elte.hu
Subject: Re: VST and Sched Load Balance
Cc: george@mvista.com, nickpiggin@yahoo.com.au,
       high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, vatsa@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Sorry about sending my response from a different account. Can't seem
to access my ibm account right now]

* Ingo wrote:

> Another, more effective, less intrusive but also more complex approach
> would be to make a distinction between 'totally idle' and 'partially
> idle or busy' system states. When all CPUs are idle then all timer irqs
> may be stopped and full VST logic applies. When at least one CPU is
> busy, all the other CPUs may still be put to sleep completely and
> immediately, but the busy CPU(s) have to take over a 'watchdog' role,
> and need to run the 'do the idle CPUs need new tasks' balancing
> functions. I.e. the scheduling function of other CPUs is migrated to
> busy CPUs. If there are no busy CPUs then there's no work, so this ought
> to be simple on the VST side. This needs some reorganization on the
> scheduler side but ought to be doable as well.


Hmm ..I think this is the approach that I have followed in my patch, where
busy CPUs act as watchdogs and wakeup sleeping CPUs at an appropriate
time. The appropriate time is currently based on the busy CPU's load
being greater than 1 and the sleeping CPU not having balanced for its
minimum balance_interval.

Do you have any other suggestions on how the watchdog function should
be implemented?

- vatsa
