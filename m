Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbULXSVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbULXSVw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 13:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbULXSVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 13:21:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:35025 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261413AbULXSVg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 13:21:36 -0500
Date: Fri, 24 Dec 2004 10:21:24 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
cc: Paul Mackerras <paulus@samba.org>, Christoph Lameter <clameter@sgi.com>,
       Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       linux-mm@kvack.org, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Prezeroing V2 [0/3]: Why and When it works
In-Reply-To: <1103879668.4131.15.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.58.0412241018430.2654@ppc970.osdl.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com>
  <41C20E3E.3070209@yahoo.com.au>  <Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com>
  <Pine.LNX.4.58.0412231119540.31791@schroedinger.engr.sgi.com> 
 <16843.13418.630413.64809@cargo.ozlabs.ibm.com>  <Pine.LNX.4.58.0412231325420.2654@ppc970.osdl.org>
 <1103879668.4131.15.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 Dec 2004, Arjan van de Ven wrote:
> 
> problem is.. will it buy you anything if you use the page again
> anyway... since such pages will be cold cached now. So for sure some of
> it is only shifting latency from kernel side to userspace side, but
> readprofile doesn't measure the later so it *looks* better...

Absolutely. I would want to see some real benchmarks before we do this.  
Not just some microbenchmark of "how many page faults can we take without
_using_ the page at all".

I agree 100% with you that we shouldn't shift the costs around. Having a
hice hot-spot that we know about is a good thing, and it means that
performance profiles show what the time is really spent on. Often getting
rid of the hotspot just smears out the work over a wider area, making
other optimizations (like trying to make the memory footprint _smaller_
and removing the work entirely that way) totally impossible because now
the performance profile just has a constant background noise and you can't 
tell what the real problem is.

		Linus
