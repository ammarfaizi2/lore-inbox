Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030341AbVKRFog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030341AbVKRFog (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 00:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbVKRFog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 00:44:36 -0500
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:54938 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S964891AbVKRFof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 00:44:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=3UD/Crr9tG1E3lilBXo6qvJZTH0WQpfNAQSGxKVr9DrzuN4xBu6c8FeQ3nSE3peIRlJ06VJjoXIjYjdH4g8sKTlddW0nw3Xc26HnWPTNrOwcJkroSHGC2MFQ9LfSOPAWDZAX7jvhqBClQ1tafLyHcvTZ/7IdyB6fuvTVnJY3PL4=  ;
Message-ID: <437D6AD0.5080909@yahoo.com.au>
Date: Fri, 18 Nov 2005 16:46:56 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: hugh@veritas.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] unpaged: COW on VM_UNPAGED
References: <Pine.LNX.4.61.0511171925290.4563@goblin.wat.veritas.com>	<Pine.LNX.4.61.0511171936440.4563@goblin.wat.veritas.com> <20051117.155230.25121238.davem@davemloft.net>
In-Reply-To: <20051117.155230.25121238.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> From: Hugh Dickins <hugh@veritas.com>
> Date: Thu, 17 Nov 2005 19:37:23 +0000 (GMT)
> 
> 
>>Remove the BUG_ON(vma->vm_flags & VM_UNPAGED) from do_wp_page, and let
>>it do Copy-On-Write without touching the VM_UNPAGED's page counts - but
>>this is incomplete, because the anonymous page it inserts will itself
>>need to be handled, here and in other functions - next patch.
>>
>>We still don't copy the page if the pfn is invalid, because the
>>copy_user_highpage interface does not allow it.  But that's not been
>>a problem in the past: can be added in later if the need arises.
>>
>>Signed-off-by: Hugh Dickins <hugh@veritas.com>
> 
> 
> Do we even need this?  It is a very serious question...
> 

I think for 2.6.15, yes. We [read: I :(] was too hasty in removing
this completely. However I think it would not be unresonable to spit
out a warning, and remove it in 2.6.??

Looks like Hugh's done a very good job of this, however keeping
complexity down is always a good thing.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
