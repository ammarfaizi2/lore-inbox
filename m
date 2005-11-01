Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbVKATDD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbVKATDD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 14:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbVKATDC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 14:03:02 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:6536 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751118AbVKATDA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 14:03:00 -0500
Date: Tue, 1 Nov 2005 20:02:49 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Rob Landley <rob@landley.net>
Cc: Mel Gorman <mel@csn.ul.ie>, Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-ID: <20051101190249.GA16738@elte.hu>
References: <20051030235440.6938a0e9.akpm@osdl.org> <Pine.LNX.4.58.0511011358520.14884@skynet> <20051101144622.GC9911@elte.hu> <200511011233.36713.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511011233.36713.rob@landley.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Rob Landley <rob@landley.net> wrote:

> On Tuesday 01 November 2005 08:46, Ingo Molnar wrote:
> > how will the 100% solution handle a simple kmalloc()-ed kernel buffer,
> > that is pinned down, and to/from which live pointers may exist? That
> > alone can prevent RAM from being removable.
> 
> Would you like to apply your "100% or nothing" argument to the virtual 
> memory management subsystem and see how it sounds in that context?  
> (As an argument that we shouldn't _have_ one?)

that would be comparing apples to oranges. There is a big difference 
between "VM failures under high load", and "failure of VM functionality 
for no user-visible reason". The fragmentation problem here has nothing 
to do with pathological workloads. It has to do with 'unlucky' 
allocation patterns that pin down RAM areas which thus become 
non-removable. The RAM module will be non-removable for no user-visible 
reason. Possible under zero load, and with lots of free RAM otherwise.

	Ingo
