Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbVFAIBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbVFAIBs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 04:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbVFAIBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 04:01:48 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:43364 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261325AbVFAIBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 04:01:46 -0400
Subject: Re: [RFC] x86-64: Use SSE for copy_page and clear_page
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: michael@optusnet.com.au
Cc: Andi Kleen <ak@muc.de>, Denis Vlasenko <vda@ilport.com.ua>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Jeff Garzik <jgarzik@pobox.com>, Benjamin LaHaise <bcrl@kvack.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <m2zmuaee2z.fsf@mo.optusnet.com.au>
References: <20050530181626.GA10212@kvack.org>
	 <20050530193225.GC25794@muc.de> <200505311137.00011.vda@ilport.com.ua>
	 <200505311215.06495.vda@ilport.com.ua> <20050531092358.GA9372@muc.de>
	 <m2zmuaee2z.fsf@mo.optusnet.com.au>
Content-Type: text/plain
Date: Wed, 01 Jun 2005 18:01:39 +1000
Message-Id: <1117612899.5188.61.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-01 at 17:22 +1000, michael@optusnet.com.au wrote:
> Andi Kleen <ak@muc.de> writes:
> 

> > fork is only a corner case. The main case is a process allocating
> > memory using brk/mmap and then using it.
> 
> Key point: "using it". This normally involves writes to memory. Most
> applications don't commonly read memory that they haven't previously
> written to. (valgrind et al call that behaviour a "bug" :).

Then in that case you have doubled your memory bandwidth
requirement for those cachelines.

> 
> Given that, I'd say you really don't want the page zero routines
> touching the cache.
> 

The principle of locality-of-data (ie. the reason why caches
even work) says that you do ;)

Clearly some things benefit from not going through the cache.
But I don't think we should fundamentally change behaviour of
this *just* because it is worth a percent on kernel compiles.

Also, I think that trends in CPU design (more cache, further
from memory, multiple CPUs & cores) should favour stores
going to cache rather than straight to memory... But I'm
just speculating.

-- 
SUSE Labs, Novell Inc.



Send instant messages to your online friends http://au.messenger.yahoo.com 
