Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbWBWNVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWBWNVQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 08:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWBWNVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 08:21:15 -0500
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:63095 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751347AbWBWNVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 08:21:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=aRyp6DPIxL/T7Q5yx6AvI/hpOr9D7+Ef0ess2M3eqfZuwVukXQmgii4IYXKaDHNE5XFLCgCuuOKfggpkQIa2i3WjYtD6EwMoBQQqZTOOLF10aK1y5qPiJlqdKXylAP1iYZhlTJIaPCi5d0MPnDtxGWcvdAbz82LiYVyBU3g2UkQ=  ;
Message-ID: <43FDB55E.7090607@yahoo.com.au>
Date: Fri, 24 Feb 2006 00:15:10 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@intel.linux.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [Patch 3/3] prepopulate/cache cleared pages
References: <1140686238.2972.30.camel@laptopd505.fenrus.org> <200602231041.00566.ak@suse.de> <20060223124152.GA4008@elte.hu> <200602231406.43899.ak@suse.de>
In-Reply-To: <200602231406.43899.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Thursday 23 February 2006 13:41, Ingo Molnar wrote:
> 
> 
>>What Arjan did is quite nifty, as it moves the page clearing out from 
>>under the mmap_sem-held critical section.
> 
> 
> So that was the point not the rescheduling under lock? Or both?
> 
> BTW since it touches your area of work you could comment what
> you think about not using voluntary preempt points for fast sleep locks
> like I later proposed.
> 
> 
>>How that is achieved is really  
>>secondary, it's pretty clear that it could be done in some nicer way.
> 
> 
> Great we agree then.
> 

I'm worried about the situation where we allocate but don't use the
new page: it blows quite a bit of cache. Then, when we do get around
to using it, it will be cold(er).

Good to see someone trying to improve this area, though.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
