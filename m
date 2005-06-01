Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbVFAXdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbVFAXdx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 19:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVFAXco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 19:32:44 -0400
Received: from dvhart.com ([64.146.134.43]:52902 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261499AbVFAX2j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 19:28:39 -0400
Date: Wed, 01 Jun 2005 16:28:34 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>, jschopp@austin.ibm.com
Cc: Mel Gorman <mel@csn.ul.ie>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Avoiding external fragmentation with a placement policy Version 12
Message-ID: <423970000.1117668514@flay>
In-Reply-To: <429E4023.2010308@yahoo.com.au>
References: <20050531112048.D2511E57A@skynet.csn.ul.ie> <429E20B6.2000907@austin.ibm.com> <429E4023.2010308@yahoo.com.au>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Thursday, June 02, 2005 09:09:23 +1000 Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Joel Schopp wrote:
> 
>> 
>> Other than the very minor whitespace changes above I have nothing bad to 
>> say about this patch.  I think it is about time to pick in up in -mm for 
>> wider testing.
>> 
> 
> It adds a lot of complexity to the page allocator and while
> it might be very good, the only improvement we've been shown
> yet is allocating lots of MAX_ORDER allocations I think? (ie.
> not very useful)

I agree that MAX_ORDER allocs aren't interesting, but we can hit 
frag problems easily at way less than max order. CIFS does it, NFS 
does it, jumbo frame gigabit ethernet does it, to name a few. The 
most common failure I see is order 3. 

Keep a machine up for a while, get it thoroughly fragmented, then 
push it reasonably hard constant pressure, and try allocating anything
large. 

Seems to me we're basically pointing a blunderbuss at memory, and 
blowing away large portions, and *hoping* something falls out the
bottom that's a big enough chunk?

M.

