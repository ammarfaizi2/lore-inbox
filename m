Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbVKGDDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbVKGDDr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 22:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbVKGDDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 22:03:47 -0500
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:54694 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932414AbVKGDDq (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sun, 6 Nov 2005 22:03:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=tNnZtr0QwMOGMJEjs7dMDvp19OcCtEpGJS5q4xpnjKAo1/5MBvrMSktHh+tThAdrRdSivMw+ibVsNYHvuwhC0f9so0GplQ/b2TvyuH7cQoDUHkxYlsrBAMZbB0GdBoaW+Ac0kGYrlqGn2bAiHbL3JnGq0hZZDj/34vBhbQ8kQkg=  ;
Message-ID: <436EC491.3040603@yahoo.com.au>
Date: Mon, 07 Nov 2005 14:05:53 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Bob Picco <bob.picco@hp.com>
CC: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: [patch 7/14] mm: remove bad_range
References: <436DBAC3.7090902@yahoo.com.au> <436DBCBC.5000906@yahoo.com.au> <436DBCE2.4050502@yahoo.com.au> <436DBD11.8010600@yahoo.com.au> <436DBD31.8060801@yahoo.com.au> <436DBD82.2070500@yahoo.com.au> <436DBDA9.2040908@yahoo.com.au> <436DBDC8.5090308@yahoo.com.au> <20051106173732.GI28839@localhost.localdomain> <436EA6B2.3070807@yahoo.com.au> <20051107030005.GM28839@localhost.localdomain>
In-Reply-To: <20051107030005.GM28839@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob Picco wrote:
> Nick Piggin wrote:	[Sun Nov 06 2005, 07:58:26PM EST]
> 

>>Hmm, right - in __free_pages_bulk.
>>
>>Could we make a different call here, or is the full array of bad_range
>>checks required?
> 
> Not the full array. Just the pfn_valid call. Seems CONFIG_HOLES_IN_ZONE is
> already in page_alloc.c, perhaps just in __free_pages_bulk as a replacement
> for the bad_range call which isn't within a  BUG_ON check. It's somewhat of a 
> wart but already there. Otherwise we might want arch_holes_in_zone inline 
> which is only required by ia64 and noop for other arches.
> 

Ideally yes, it would be hidden away in an arch specific header file.

In the meantime I will just replace it with an ifdefed pfn_valid call.

> The only place I didn't look closely is the BUG_ON in expand. I'll do that
> tomorrow.
> 

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
