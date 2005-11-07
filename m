Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbVKGBEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbVKGBEQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 20:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbVKGBEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 20:04:16 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:38734 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932394AbVKGBEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 20:04:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=cJaDLSk5q0e8KZBpEifJXucE8OD+MoAuwlRwkf2poZRsMjg1W1X5rmHV1d7nDBUi2KQmHp2PoA0/44bq/hdAvSFuUYyXBEHfb8J2JAL2Da9IDWbsaz+D14C2LCSeOlSOxZRCrTLpgoo0E8dRGl8qSkLKhN3pHos8GFsO8REbpms=  ;
Message-ID: <436EA88C.3050104@yahoo.com.au>
Date: Mon, 07 Nov 2005 12:06:20 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch 1/14] mm: opt rmqueue
References: <436DBAC3.7090902@yahoo.com.au> <436DBCBC.5000906@yahoo.com.au> <p73br0x3ceq.fsf@verdi.suse.de>
In-Reply-To: <p73br0x3ceq.fsf@verdi.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> writes:
> 
> 
>>1/14
>>
>>-- 
>>SUSE Labs, Novell Inc.
>>
>>Slightly optimise some page allocation and freeing functions by
>>taking advantage of knowing whether or not interrupts are disabled.
> 
> 
> Another thing that could optimize that would be to use local_t
> for the per zone statistics and the VM statistics (i have an
> old patch for the later, needs polishing up for the current
> kernel) 
> With an architecture optimized for it (like i386/x86-64) they
> generate much better code.
> 

Yes, all this turning on and off of interrupts does have a
significant cost here.

With the full patchset applied, most of the hot path statistics
get put under areas that already require interrupts to be off,
however there are still a few I didn't get around to doing.
zone_statistics on CONFIG_NUMA, for example.

I wonder if local_t is still good on architectures like ppc64
where it still requires an ll/sc sequence?

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
