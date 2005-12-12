Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750926AbVLLEO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbVLLEO7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 23:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbVLLEO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 23:14:59 -0500
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:15498 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1750926AbVLLEO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 23:14:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=z+su4xjZbM6U1nYtgYkAJFAyv0rmw9a6rqYlTSYfdZRK5ietqOw+g48/MdV7O0cIYREkbtD2CyMZU6E6aBjb3Umwe6B5ZtnipmMUqbPq3RrPgA4KqfYB5TcsyhMgyUuP8RAV7/zRTlxCGiVCx+0mMdJjbo+UM1kuDFGRvzEAf4g=  ;
Message-ID: <439CF93D.5090207@yahoo.com.au>
Date: Mon, 12 Dec 2005 15:14:53 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org,
       Hugh Dickins <hugh@veritas.com>, linux-mm@kvack.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [RFC 1/6] Framework
References: <20051210005440.3887.34478.sendpatchset@schroedinger.engr.sgi.com> <20051210005445.3887.94119.sendpatchset@schroedinger.engr.sgi.com> <439CF2A2.60105@yahoo.com.au> <20051212035631.GX11190@wotan.suse.de>
In-Reply-To: <20051212035631.GX11190@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Mon, Dec 12, 2005 at 02:46:42PM +1100, Nick Piggin wrote:
> 
>>Christoph Lameter wrote:
>>
>>
>>>+/*
>>>+ * For use when we know that interrupts are disabled.
>>>+ */
>>>+static inline void __mod_zone_page_state(struct zone *zone, enum 
>>>zone_stat_item item, int delta)
>>>+{
>>
>>Before this goes through, I have a full patch to do similar for the
>>rest of the statistics, and which will make names consistent with what
>>you have (shouldn't be a lot of clashes though).
> 
> 
> I also have a patch to change them all to local_t, greatly simplifying
> it (e.g. the counters can be done inline then) 
> 

Cool. That is a patch that should go on top of mine, because most of
my patch is aimed at moving modifications under interrupts-off sections,
so you would then be able to use __local_xxx operations very easily for
most of the counters here.

However I'm still worried about the use of locals tripling the cacheline
size of a hot-path structure on some 64-bit architectures. Probably we
should get them to try to move to the atomic64 scheme before using
local_t here.

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
