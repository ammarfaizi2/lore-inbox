Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVARHxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVARHxl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 02:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbVARHxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 02:53:41 -0500
Received: from gate.crashing.org ([63.228.1.57]:41942 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261161AbVARHxj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 02:53:39 -0500
Subject: Re: [patch 0/3] kallsyms: Add gate page and all symbols support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Keith Owens <kaos@ocs.com.au>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20041228211700.GA21591@mars.ravnborg.org>
References: <28912.1101613127@ocs3.ocs.com.au>
	 <20041228211700.GA21591@mars.ravnborg.org>
Content-Type: text/plain
Date: Tue, 18 Jan 2005 18:52:55 +1100
Message-Id: <1106034775.4499.86.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-28 at 22:17 +0100, Sam Ravnborg wrote:

> > 2 Add in_gate_area_no_task() for use from places where no task is valid.

Can you back that out ? Or at least explain why you need to add this
"no_task" thing and not just use "current" where no task is available ?
I think the above is bogus for 3 reasons:

 - I tend to dislike adding functions
"foo_with_that_parameter_instead_of_that" ... We do it here or there,
but the less we do it, the happier I am :)

 - Since you unconditionally #define in_gate_area() to use
in_gate_area_no_task(), what is the point of having in_gate_area() at
all ? Which rather means, what is the point of adding that "_no_task"
version and not just change in_gate_area to not take a task ?

 - I dislike the fact that you now define the prototype of the function
in the __HAVE_ARCH_GATE_AREA case. I want my arch .h to be the one doing
so, since i want to inline it (to nothing in the ppc64 case since the
vDSO I'm implementing doesn't need any special treatement of the gate
area, it's a normal VMA added to the mm's at exec time).

Ben.


