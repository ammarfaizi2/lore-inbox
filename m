Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbVKABOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbVKABOM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 20:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbVKABOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 20:14:12 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:39075 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S964890AbVKABOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 20:14:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=OrJqC08AEPmbYkm/q68J1XXa86RYCsEv7lutUEzuk11N970H47V+I/VIy1fyx0Rkkc0Vl0oNi7VCaxWD9Tqvcqp+gRgoBNuK5hJZGap2EwtZQFGEyxxlrRJ8vVBf1plF60a8t4OEaVmH2i2xmxhdxDqmUPpehmQsXP8zoMGeAqQ=  ;
Message-ID: <4366C188.5090607@yahoo.com.au>
Date: Tue, 01 Nov 2005 12:14:48 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Rohit Seth <rohit.seth@intel.com>
CC: akpm@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Clean up of __alloc_pages
References: <20051028183326.A28611@unix-os.sc.intel.com>	 <4362DF80.3060802@yahoo.com.au> <1130792107.4853.24.camel@akash.sc.intel.com>
In-Reply-To: <1130792107.4853.24.camel@akash.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rohit Seth wrote:
> On Sat, 2005-10-29 at 12:33 +1000, Nick Piggin wrote:

>>If you don't do this, then a GFP_HIGH allocator can allocate right
>>down to its limit before it kicks kswapd, then it either will fail or
>>will have to do direct reclaim.
>>
> 
> 
> You are right if there are only GFP_HIGH requests coming in then the
> allocation will go down to (min - min/2) before kicking in kswapd.
> Though if the requester is not ready to wait, there is another good shot
> at allocation succeed before we get into direct reclaim (and this is
> happening based on can_try_harder flag).
> 

Still, it is a change in behaviour that I would rather not introduce
with a cleanup patch (and is something we don't want to introduce anyway).

So if you could fix that up it would be good.

>>How about moving the zone_statistics up into the 'if (page)'
>>test of get_page_from_freelist? This way we don't have to
>>evaluate page_zone().
>>
> 
> 
> Let us keep this as is for now.  Will revisit once after the
> pcp_prefer_allocation patches get in place. 
> 

Well page_zone is yet another cacheline that doesn't need to be touched,
and that is introduced by this patch. But the line is likely to be hot,
and get_page_from_freelist does not have the required 'zonelist' which
I didn't notice before.

So OK, revisit this later.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
