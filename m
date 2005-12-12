Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbVLLDvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbVLLDvU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 22:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbVLLDvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 22:51:20 -0500
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:15461 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751075AbVLLDvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 22:51:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=VaOdSe9RXJb8aCHkjscUIYg6PL8loLIR0Utbsbo9NXZ77h9WUsz4GbzL4UGIO5cGSblsSR3HfDzHQjrNxxypDAif30IyX0Q5GrbBc6Nt04+h3x8m1AgkDjEHYIxgSzvPeUe5dqzK7EqTDmGISMtrVsuc31Ub7p4C1/7cnrSd2as=  ;
Message-ID: <439CF3B1.4050803@yahoo.com.au>
Date: Mon, 12 Dec 2005 14:51:13 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Andi Kleen <ak@suse.de>, Christoph Lameter <clameter@sgi.com>,
       linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       linux-mm@kvack.org
Subject: Re: [RFC 3/6] Make nr_pagecache a per zone counter
References: <20051210005440.3887.34478.sendpatchset@schroedinger.engr.sgi.com> <20051210005456.3887.94412.sendpatchset@schroedinger.engr.sgi.com> <20051211183241.GD4267@dmt.cnet> <20051211194840.GU11190@wotan.suse.de> <20051211204943.GA4375@dmt.cnet>
In-Reply-To: <20051211204943.GA4375@dmt.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> On Sun, Dec 11, 2005 at 08:48:40PM +0100, Andi Kleen wrote:
> 
>>>By the way, why does nr_pagecache needs to be an atomic variable on UP systems?
>>
>>At least on X86 UP atomic doesn't use the LOCK prefix and is thus quite
>>cheap. I would expect other architectures who care about UP performance
>>(= not IA64) to be similar.
> 
> 
> But in practice the variable does not need to be an atomic type for UP, but
> simply a word, since stores are atomic on UP systems, no?
> 
> Several arches seem to use additional atomicity instructions on 
> atomic functions:
> 

Yeah, this is to protect from interrupts and is common to most
load store architectures. It is possible we could have
atomic_xxx_irq / atomic_xxx_irqsave functions for these, however
I think nobody has yet demostrated the improvements outweigh the
complexity that would be added.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
