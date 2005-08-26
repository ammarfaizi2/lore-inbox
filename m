Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965165AbVHZXZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965165AbVHZXZv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 19:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965125AbVHZXZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 19:25:50 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:30697 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965108AbVHZXZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 19:25:50 -0400
Date: Fri, 26 Aug 2005 16:05:50 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Rusty Lynch <rusty.lynch@intel.com>
cc: linux-mm@kvack.org, prasanna@in.ibm.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, anil.s.keshavamurthy@intel.com
Subject: Re:[PATCH] Only process_die notifier in ia64_do_page_fault if KPROBES
 is configured.
In-Reply-To: <200508262246.j7QMkEoT013490@linux.jf.intel.com>
Message-ID: <Pine.LNX.4.62.0508261559450.17433@schroedinger.engr.sgi.com>
References: <200508262246.j7QMkEoT013490@linux.jf.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Aug 2005, Rusty Lynch wrote:

> Just to be sure everyone understands the overhead involved, kprobes only 
> registers a single notifier.  If kprobes is disabled (CONFIG_KPROBES is
> off) then the overhead on a page fault is the overhead to execute an empty
> notifier chain.

Its the overhead of using registers to pass parameters, performing a 
function call that does nothing etc. A waste of computing resources. All 
of that unconditionally in a performance critical execution path that 
is executed a gazillion times for an optional feature that I frankly 
find not useful at all and that is disabled by default.
