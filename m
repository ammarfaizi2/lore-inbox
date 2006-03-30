Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWC3TEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWC3TEW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 14:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWC3TEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 14:04:22 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:6799 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750740AbWC3TEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 14:04:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Oo1sO5kfhGc6noFrL23YP8GmMywsh2BFisZnguK0WmxOAGbQ6u2Ux/EaTnOX73cT91EBPTlCPSUOWp9oZm3Ez8XcvCk83yZ1SNKfFA4ypxrA6dz5HoR7yHz0TohTqoeGgcy5E8uSmL28+Sn8qps9UcsiYkKXIrZYRG+hoilX3AM=  ;
Message-ID: <442B9D18.4050903@yahoo.com.au>
Date: Thu, 30 Mar 2006 18:55:52 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
CC: Christoph Lameter <clameter@sgi.com>, "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Fix unlock_buffer() to work the same way as bit_unlock()
References: <65953E8166311641A685BDF71D865826A23D40@cacexc12.americas.cpqcorp.net> <Pine.LNX.4.64.0603291529160.26011@schroedinger.engr.sgi.com> <442B9A2A.7000306@bull.net>
In-Reply-To: <442B9A2A.7000306@bull.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zoltan Menyhart wrote:

> However, I do not think your implementation would be efficient due to
> selecting the ordering mode at run time:
> 
>> +    switch (mode) {
>> +    case MODE_NONE :
>> +    case MODE_ACQUIRE :
>> +        return cmpxchg_acq(m, old, new);
>> +    case MODE_FENCE :
>> +        smp_mb();
>> +        /* Fall through */
>> +    case MODE_RELEASE :
>> +        return cmpxchg_rel(m, old, new);
> 

BTW. Isn't MODE_FENCE wrong? Seems like a read or write could be moved
above cmpxchg_rel?

I think you need rel+acq rather than acq+rel (if I'm right, then the
same goes for your earlier bitops patches, btw).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
