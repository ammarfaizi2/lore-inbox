Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269799AbUH0A2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269799AbUH0A2f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 20:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269812AbUH0AUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 20:20:10 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:15791 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S269844AbUH0AQA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 20:16:00 -0400
Subject: Re: [Lhms-devel] Re: [RFC] buddy allocator without bitmap [3/4]
From: Dave Hansen <haveblue@us.ibm.com>
To: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, lhms <lhms-devel@lists.sourceforge.net>,
       William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <412E7AB6.8020707@jp.fujitsu.com>
References: <412DD34A.70802@jp.fujitsu.com>
	 <1093535709.2984.24.camel@nighthawk>  <412E7AB6.8020707@jp.fujitsu.com>
Content-Type: text/plain
Message-Id: <1093565707.2984.394.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 26 Aug 2004 17:15:08 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-26 at 17:05, Hiroyuki KAMEZAWA wrote:
> Currently, I think zone->nr_mem_map itself is very vague.
> I'm now looking for another way to remove this part entirely.
> 
> I think mem_section approarch may be helpful to remove this part,
> but to implement full feature of CONFIG_NONLINEAR,
> I'll need lots of different kind of patches.
> (If mem_map is guaranteed to be contiguous in one mem_section)

This is definitely a true assumption right now.  

> 1. Now, I think some small parts, some essence of mem_section which
>    makes pfn_valid() faster may be good.

The only question is what it will take when there's a partially populate
mem_section.  We'll almost certainly have to allow it, but the real
question is whether or not we will ever have a partially populated one
that's not at the end of memory.  

> And another way,
> 
> 2. A method which enables page -> page's max_order calculation
>    may be good and consistent way in this no-bitmap approach.
> 
> But this problem would be my week-end homework :).

Instead of adding more stuff to the mem_section, we might be able to
(ab)use more stuff in the mem_map's mem_map, like I am with
page->section right now.  

-- Dave

