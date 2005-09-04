Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbVIDBAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbVIDBAy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 21:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbVIDBAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 21:00:54 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:7538 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750722AbVIDBAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 21:00:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=X/kmRSFq0aLmv9GRc1SUCJwjDc4g2Y6TjwbGCViDZKDRgJSkL9/sZY+e9b/y1IHsDCF6Dc2Wpvtqr35m9VZXvOSf5IdO/sa28GdOQtVFXmOuq0vqiPN5aFBDUU5jBeE00QPo5UDazLv5LQD/b1ENAVlKZnSmvAeM2l9jJXk4YII=  ;
Message-ID: <431A4767.4030403@yahoo.com.au>
Date: Sun, 04 Sep 2005 11:01:27 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andi Kleen <ak@suse.de>, Linux Memory Management <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.13] lockless pagecache 2/7
References: <4317F071.1070403@yahoo.com.au> <4317F0F9.1080602@yahoo.com.au>	 <4317F136.4040601@yahoo.com.au>	 <1125666486.30867.11.camel@localhost.localdomain>	 <p73k6hzqk1w.fsf@verdi.suse.de>  <4318C28A.5010000@yahoo.com.au>	 <1125705471.30867.40.camel@localhost.localdomain>	 <4318FF2B.6000805@yahoo.com.au> <1125768697.14987.7.camel@localhost.localdomain>
In-Reply-To: <1125768697.14987.7.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Sad, 2005-09-03 at 11:40 +1000, Nick Piggin wrote:
> 
>>We'll see how things go. I'm fairly sure that for my usage it will
>>be a win even if it is costly. It is replacing an atomic_inc_return,
>>and a read_lock/read_unlock pair.
> 
> 
> Make sure you bench both AMD and Intel - I'd expect it to be a big loss
> on AMD because the AMD stuff will perform atomic locked operations very
> efficiently if they are already exclusive on this CPU or a prefetch_w()
> on them was done 200+ clocks before.
> 

I will try to get numbers for both.

I would be surprised if it was a big loss... but I'm assuming
a locked cmpxchg isn't outlandishly expensive. Basically:

   read_lock_irqsave(cacheline1);
   atomic_inc_return(cacheline2);
   read_unlock_irqrestore(cacheline1);

Turns into

   atomic_cmpxchg();

I'll do some microbenchmarks and get back to you. I'm quite
interested now ;) What sort of AMDs did you have in mind,
Opterons?

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
