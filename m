Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030299AbWD1Hju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbWD1Hju (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 03:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030302AbWD1Hju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 03:39:50 -0400
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:19121 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030299AbWD1Hjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 03:39:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=gqUCKnJyy+WDm81I4dQTqXQozXxQcw/lcNZImHEzwZyb74ixtLYkthw+BfASlVWs1ddJg9ESmnAZq1gS9gsuadcrQbrNXPd8tffUPzzuI/ByiuPgZpBi+1cGIgM2b/sK2V0HpHu0mIrGwziMpxDoU19Q2FjV0CLV8LsynNbu6q8=  ;
Message-ID: <4451C23D.5000002@yahoo.com.au>
Date: Fri, 28 Apr 2006 17:20:29 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       zach@vmware.com, torvalds@osdl.org
Subject: Re: [PATCH] x86/PAE: Fix pte_clear for the >4GB RAM case
References: <200604272001.k3RK1dmX007637@hera.kernel.org> <200604280808.44496.ak@suse.de> <20060428062704.GH2909@sorel.sous-sol.org> <200604280829.29164.ak@suse.de>
In-Reply-To: <200604280829.29164.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

> No it was me who was confused sorry. Somehow i thought it was defined
> away for !SMP
> 
> (which would make sense because why would you want a compile barrier
> for a barrier that is only needed on SMP?) 

It is maybe not clearly named. smp_wmb() is a memory barrier to the
regular (eg. RAM) cache coherency domain AFAICT. wmb() is also a
barrier to io memory.

There is nothing to distinguish SMP and UP. I guess sometimes smp_
barriers would not even have to be a barrier() on UP, but other
times they would have to be (eg. in the case of concurrent
interrupts, context switches).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
