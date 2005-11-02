Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932613AbVKBHmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932613AbVKBHmb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 02:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932623AbVKBHmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 02:42:31 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:47238 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932613AbVKBHma (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 02:42:30 -0500
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
From: Dave Hansen <haveblue@us.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, Mel Gorman <mel@csn.ul.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
In-Reply-To: <43680D8C.5080500@yahoo.com.au>
References: <20051030235440.6938a0e9.akpm@osdl.org>
	 <27700000.1130769270@[10.10.2.4]> <4366A8D1.7020507@yahoo.com.au>
	 <Pine.LNX.4.58.0510312333240.29390@skynet> <4366C559.5090504@yahoo.com.au>
	 <Pine.LNX.4.58.0511010137020.29390@skynet> <4366D469.2010202@yahoo.com.au>
	 <Pine.LNX.4.58.0511011014060.14884@skynet> <20051101135651.GA8502@elte.hu>
	 <1130854224.14475.60.camel@localhost>  <20051101142959.GA9272@elte.hu>
	 <1130856555.14475.77.camel@localhost>  <43680D8C.5080500@yahoo.com.au>
Content-Type: text/plain
Date: Wed, 02 Nov 2005 08:42:18 +0100
Message-Id: <1130917338.14475.133.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-02 at 11:51 +1100, Nick Piggin wrote:
> Look: if you have to guarantee memory can be shrunk, set aside a zone
> for it (that only fills with user reclaimable areas). This is better
> than the current frag patches because it will give you the 100%
> guarantee that you need (provided we have page migration to move mlocked
> pages).

With Mel's patches, you can easily add the same guarantee.  Look at the
code in  fallback_alloc() (patch 5/8).  It would be quite easy to modify
the fallback lists to disallow fallbacks into areas from which we would
like to remove memory.  That was left out for simplicity.  As you say,
they're quite complex as it is.  Would you be interested in seeing a
patch to provide those kinds of guarantees?

We've had a bit of experience with a hotpluggable zone approach  before.
Just like the current topic patches, you're right, that approach can
also provide strong guarantees.  However, the issue comes if the system
ever needs to move memory between such zones, such as if a user ever
decides that they'd prefer to break hotplug guarantees rather than OOM.

Do you think changing what a particular area of memory is being used for
would ever be needed?

One other thing, if we decide to take the zones approach, it would have
no other side benefits for the kernel.  It would be for hotplug only and
I don't think even the large page users would get much benefit.  

-- Dave

