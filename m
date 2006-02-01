Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWBAJti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWBAJti (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 04:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWBAJti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 04:49:38 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:29012 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750726AbWBAJth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 04:49:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=V6xJBSTP5MBLIoyDvHBTT8NNa4XnVhH/FKhZzO+4+UdEaPyNyQsgsljAnhfBrH6b8getAcEL7rk0jL6bnRnPuzqhyJTZgyg9HbB3P+g1DsauD58r8OLJjfv5wogOU6qLDWiIwprXa9JOxtqOSMd+APp/GX20zLDXOa8QryBSonM=  ;
Message-ID: <43E0842A.105@yahoo.com.au>
Date: Wed, 01 Feb 2006 20:49:30 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Arjan van de Ven <arjan@infradead.org>,
       Ray Bryant <raybry@mpdtxmail.amd.com>,
       Dave McCracken <dmccr@us.ibm.com>, Robin Holt <holt@sgi.com>,
       Hugh Dickins <hugh@veritas.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH/RFC] Shared page tables
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]> <200601240210.04337.ak@suse.de> <1138086398.2977.19.camel@laptopd505.fenrus.org> <200601240818.28696.ak@suse.de>
In-Reply-To: <200601240818.28696.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

> 
> Well, we first have to figure out if the shared page tables
> are really worth all the ugly code, nasty locking and other problems 
> (inefficient TLB flush etc.) I personally would prefer
> to make large pages work better before going down that path.
> 

Other thing I wonder about - less efficient page table placement
on NUMA systems might harm TLB miss latency on some systems
(although we don't always do a great job of trying to localise these
things yet anyway). Another is possible increased lock contention on
widely shared page tables like libc.

I agree that it is not something which needs to be rushed in any
time soon. We've already got significant concessions and complexity
in the memory manager for databases (hugepages, direct io / raw io)
so a few % improvement on database performance doesn't put it on our
must have list IMO.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
