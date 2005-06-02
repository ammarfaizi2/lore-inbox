Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVFBPwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVFBPwj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 11:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVFBPwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 11:52:38 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:42494 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261174AbVFBPwV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 11:52:21 -0400
Message-ID: <429F2B26.9070509@austin.ibm.com>
Date: Thu, 02 Jun 2005 10:52:06 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
Reply-To: jschopp@austin.ibm.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: "Martin J. Bligh" <mbligh@mbligh.org>, Mel Gorman <mel@csn.ul.ie>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Avoiding external fragmentation with a placement policy Version
 12
References: <20050531112048.D2511E57A@skynet.csn.ul.ie> <429E20B6.2000907@austin.ibm.com> <429E4023.2010308@yahoo.com.au> <423970000.1117668514@flay> <429E483D.8010106@yahoo.com.au> <434510000.1117670555@flay> <429E50B8.1060405@yahoo.com.au>
In-Reply-To: <429E50B8.1060405@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I see your point... Mel's patch has failure cases though.
> For example, someone turns swap off, or mlocks some memory
> (I guess we then add the page migration defrag patch and
> problem is solved?).

This reminds me that page migration defrag will be pretty useless 
without something like this done first.  There will be stuff that can't 
be migrated and it needs to be grouped together somehow.

In summary here are the reasons I see to run with Mel's patch:

1. It really helps with medium-large allocations under memory pressure.
2. Page migration defrag will need it.
3. Memory hotplug remove will need it.

On the downside we have:

1. Slightly more complexity in the allocator.

I'd personally trade a little extra complexity for any of the 3 upsides.

