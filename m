Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbWCaDVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWCaDVM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 22:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWCaDVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 22:21:11 -0500
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:25774 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751225AbWCaDVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 22:21:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=iEtjA5ahD8qw50kbBPlpqxkgbgm9L40KDFiK/GnhFCdAm/h9aZQ7wR9KHupxFtEAS973gSuM9kGKt73B9n+P2VfuxR4+XlZ2Gr246n2SfNnG2ZtQkgd/ol6B4wv8HPpoHclBH2Y+9Ou5hGQChk9Nc4EJby/Kt8taayAS1T+VNVU=  ;
Message-ID: <442C7B51.1060203@yahoo.com.au>
Date: Fri, 31 Mar 2006 10:44:01 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: Zoltan Menyhart <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Synchronizing Bit operations V2
References: <Pine.LNX.4.64.0603301300430.1014@schroedinger.engr.sgi.com> <Pine.LNX.4.64.0603301615540.2023@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0603301615540.2023@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> Changelog:
> 
> V2
> 	- Fix various oversights
> 	- Follow Hans Boehm's scheme for the barrier logic
> 
> The following patchset implements the ability to specify a
> synchronization mode for bit operations.
> 
> I.e. instead of set_bit(x,y) we can do set_bit(x,y, mode).
> 
> The following modes are supported:
> 

This has acquire and release, instead of the generic kernel
memory barriers rmb and wmb. As such, I don't think it would
get merged.

> Note that the current semantics for bitops IA64 are broken. Both
> smp_mb__after/before_clear_bit are now set to full memory barriers
> to compensate which may affect performance.

I think you should fight the fights you can win and get a 90%
solution ;) at any rate you do need to fix the existing routines
unless you plan to audit all callers...

First, fix up ia64 in 2.6-head, this means fixing test_and_set_bit
and friends, smp_mb__*_clear_bit, and all the atomic operations that
both modify and return a value.

Then add test_and_set_bit_lock / clear_bit_unlock, and apply them
to a couple of critical places like page lock and buffer lock.

Is this being planned?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
