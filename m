Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261827AbVBDG13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbVBDG13 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 01:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbVBDG13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 01:27:29 -0500
Received: from smtp103.mail.sc5.yahoo.com ([66.163.169.222]:40283 "HELO
	smtp103.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263364AbVBDG1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 01:27:18 -0500
Subject: Re: page fault scalability patch V16 [3/4]: Drop page_table_lock
	in handle_mm_fault
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       hugh@veritas.com, linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org
In-Reply-To: <1107313778.5131.32.camel@npiggin-nld.site>
References: <41E5B7AD.40304@yahoo.com.au>
	 <Pine.LNX.4.58.0501121552170.12669@schroedinger.engr.sgi.com>
	 <41E5BC60.3090309@yahoo.com.au>
	 <Pine.LNX.4.58.0501121611590.12872@schroedinger.engr.sgi.com>
	 <20050113031807.GA97340@muc.de>
	 <Pine.LNX.4.58.0501130907050.18742@schroedinger.engr.sgi.com>
	 <20050113180205.GA17600@muc.de>
	 <Pine.LNX.4.58.0501131701150.21743@schroedinger.engr.sgi.com>
	 <20050114043944.GB41559@muc.de>
	 <Pine.LNX.4.58.0501140838240.27382@schroedinger.engr.sgi.com>
	 <20050114170140.GB4634@muc.de>
	 <Pine.LNX.4.58.0501281233560.19266@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.58.0501281237010.19266@schroedinger.engr.sgi.com>
	 <41FF00CE.8060904@yahoo.com.au>
	 <Pine.LNX.4.58.0502011047330.3205@schroedinger.engr.sgi.com>
	 <1107304296.5131.13.camel@npiggin-nld.site>
	 <Pine.LNX.4.58.0502011718240.5549@schroedinger.engr.sgi.com>
	 <1107308498.5131.28.camel@npiggin-nld.site>
	 <Pine.LNX.4.58.0502011843570.6511@schroedinger.engr.sgi.com>
	 <1107313778.5131.32.camel@npiggin-nld.site>
Content-Type: text/plain
Date: Fri, 04 Feb 2005 17:27:10 +1100
Message-Id: <1107498430.5461.17.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-02-02 at 14:09 +1100, Nick Piggin wrote:
> On Tue, 2005-02-01 at 18:49 -0800, Christoph Lameter wrote:
> > On Wed, 2 Feb 2005, Nick Piggin wrote:

> > I mean we could just speculatively copy, risk copying crap and
> > discard that later when we find that the pte has changed. This would
> > simplify the function:
> > 
> 
> I think this may be the better approach. Anyone else?
> 

Not to say it is perfect either. Normal semantics say not to touch
a page if it is not somehow pinned. So this may cause problems in
corner cases (DEBUG_PAGEALLOC comes to mind... hopefully nothing else).

But I think a plain read of the page when it isn't pinned is less
yucky than writing into the non-pinned struct page.



