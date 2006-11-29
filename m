Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967596AbWK2Tr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967596AbWK2Tr7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 14:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967598AbWK2Tr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 14:47:58 -0500
Received: from outbound0.mx.meer.net ([209.157.153.23]:39941 "EHLO
	outbound0.sv.meer.net") by vger.kernel.org with ESMTP
	id S967596AbWK2Tr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 14:47:57 -0500
Subject: Re: [PATCH 2/2 -mm] fault-injection: lightweight code-coverage
	maximizer
From: Don Mullis <dwm@meer.net>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20061129023737.GA9283@APFDCB5C>
References: <1164699866.2894.88.camel@localhost.localdomain>
	 <1164700290.2894.93.camel@localhost.localdomain>
	 <20061128091811.GA2004@APFDCB5C>
	 <1164744877.2894.133.camel@localhost.localdomain>
	 <20061129023737.GA9283@APFDCB5C>
Content-Type: text/plain
Date: Wed, 29 Nov 2006 11:47:48 -0800
Message-Id: <1164829668.2894.212.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-29 at 11:37 +0900, Akinobu Mita wrote:
> On Tue, Nov 28, 2006 at 12:14:36PM -0800, Don Mullis wrote:
> > First, waiting a few seconds for the standard FC-6 daemons to wake up.
> > Then, Xemacs and Firefox.  Not tested on SMP.
> 
> Is it failslab or fail_page_alloc ?

Usually failslab, as it exposes unique stacks more quickly.

> > > This doesn't maximize code coverage. It makes fault-injector reject
> > > any failures which have same stacktrace before.
> > 
> > Since the volume of (repeated) dumps is greatly reduced, 
> > interval/probability can be set more aggressively without crippling
> > interaction.  This increases the number of error recovery paths covered
> > per unit of wall clock time.
> > 
> It seems artificial. Injecting failures into slab or page allocator causes
> vastly greater range of errors and it should be. I feel what you really
> want is new fault capability.

When conducting an expensive test, one would naturally prefer not to
repeat it on cases that are nearly the same, and therefore unlikely to
expose a bug, at least until all the "more distinctive" cases have
been hit.  Which cases actually do contain a bug is of course
not knowable a priori, and "distinctiveness" is subjective.

The claim of this patch is that uniqueness of call stack is 
a better proxy for likelihood to contain a bug than mere number
of calls to should_fail() -- which can be thought of as the null proxy.

> Fault injection is designed be extensible. It's not only for failslab,
> fail_page_alloc, and fail_make_request.

Sure.

> Common debugfs entries for fault capabilities will be complicated
> soon by pushing new entries for every fault case or pattern.

True.  "space" seems useful only for storage allocation calls.
Should it be dropped from the common set of debugfs entries?


