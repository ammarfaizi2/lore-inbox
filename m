Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbWJQRml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbWJQRml (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 13:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWJQRml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 13:42:41 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:8050 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751360AbWJQRmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 13:42:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=UGVhoWiP3HvIodGz1shAGNeUrRBvIjsjRJuksR0PrSutCU8P25kfGeDIIr5f3xkVh1LfRZ0Fz5CJ01zirIBs6tQEBABlTfRERT/sRQvLuItqQu9ptq2xo131i3O4ioYY8bsQCRGadgVlLYCivI8ixg8FEW09PYP10ycP1WFMj1Y=  ;
Message-ID: <4535160E.2010908@yahoo.com.au>
Date: Wed, 18 Oct 2006 03:42:38 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Bligh <mbligh@google.com>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Nick Piggin <npiggin@suse.de>
Subject: Re: [RFC] Remove temp_priority
References: <45351423.70804@google.com>
In-Reply-To: <45351423.70804@google.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh wrote:
> This is not tested yet. What do you think?
> 
> This patch removes temp_priority, as it is racy. We're setting
> prev_priority from it, and yet temp_priority could have been
> set back to DEF_PRIORITY by another reclaimer.

I like it. I wonder if we should get kswapd to stick its priority
into the zone at the point where zone_watermark_ok becomes true,
rather than setting all zones to the lowest priority? That would
require a bit more logic though I guess.

For that matter (going off the topic a bit), I wonder if
try_to_free_pages should have a watermark check there too? This
might help reduce the latency issue you brought up where one process
has reclaimed a lot of pages, but another isn't making any progress
and has to go through the full priority range? Maybe that's
statistically pretty unlikely?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
