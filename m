Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030268AbVH0AYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbVH0AYl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 20:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965182AbVH0AYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 20:24:41 -0400
Received: from ns2.suse.de ([195.135.220.15]:6553 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965181AbVH0AYj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 20:24:39 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: [PATCH] Only process_die notifier in ia64_do_page_fault if KPROBES is configured.
Date: Sat, 27 Aug 2005 02:24:25 +0200
User-Agent: KMail/1.8
Cc: Rusty Lynch <rusty.lynch@intel.com>, linux-mm@kvack.org,
       prasanna@in.ibm.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, anil.s.keshavamurthy@intel.com
References: <200508262246.j7QMkEoT013490@linux.jf.intel.com> <Pine.LNX.4.62.0508261559450.17433@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0508261559450.17433@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508270224.26423.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 27 August 2005 01:05, Christoph Lameter wrote:
> On Fri, 26 Aug 2005, Rusty Lynch wrote:
> > Just to be sure everyone understands the overhead involved, kprobes only
> > registers a single notifier.  If kprobes is disabled (CONFIG_KPROBES is
> > off) then the overhead on a page fault is the overhead to execute an
> > empty notifier chain.
>
> Its the overhead of using registers to pass parameters, performing a
> function call that does nothing etc. A waste of computing resources. All
> of that unconditionally in a performance critical execution path that
> is executed a gazillion times for an optional feature that I frankly
> find not useful at all and that is disabled by default.

In the old days notifier_call_chain used to be inline. Then someone looking
at code size out of lined it. Perhaps it should be inlined again or notifier.h
could supply a special faster inline version for time critical code.

Then it would be simple if (global_var != NULL) { ... } in the fast path.
In addition the call chain could be declared __read_mostly.

I suspect with these changes Christoph's concerns would go away, right?

-Andi
