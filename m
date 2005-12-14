Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbVLNQ0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbVLNQ0P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 11:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbVLNQ0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 11:26:15 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:3767 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964816AbVLNQ0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 11:26:14 -0500
Message-ID: <43A047A1.9030308@us.ibm.com>
Date: Wed, 14 Dec 2005 08:26:09 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: linux-kernel@vger.kernel.org, andrea@suse.de,
       Sridhar Samudrala <sri@us.ibm.com>, pavel@suse.cz,
       Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 1/6] Create Critical Page Pool
References: <439FCECA.3060909@us.ibm.com> <439FCF4E.3090202@us.ibm.com> <Pine.LNX.4.63.0512140829410.2723@cuia.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.63.0512140829410.2723@cuia.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Tue, 13 Dec 2005, Matthew Dobson wrote:
> 
> 
>>Create the basic Critical Page Pool.  Any allocation specifying 
>>__GFP_CRITICAL will, as a last resort before failing the allocation, try 
>>to get a page from the critical pool.  For now, only singleton (order 0) 
>>pages are supported.
> 
> 
> How are you going to limit the number of GFP_CRITICAL
> allocations to something smaller than the number of
> pages in the pool ?

We can't.


> Unless you can do that, all guarantees are off...

Well, I was careful not to use the word guarantee in my post. ;)  The idea
is not to offer a 100% guarantee that the pool will never be exhausted.
The idea is to offer a pool that, sized appropriately, offers a very good
chance of surviving your emergency situation.  The definition of what is a
critical allocation and what the emergency situation is left intentionally
somewhat vague, so as to offer more flexibility.  For our use, certain
networking allocations are critical and our emergency situation is a 2
minute window of potential exreme memory pressure.  For others it could be
something completely different, but the expectation is that the emergency
situation would be of a finite time, since the pool is a fixed size.

Thanks!

-Matt
