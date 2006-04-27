Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbWD0ArK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWD0ArK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 20:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWD0ArK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 20:47:10 -0400
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:47011 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751137AbWD0ArJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 20:47:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=mfiocy1TQVbaBLIiDUcHRkPbS9+CbEdSrAAGee+Va0Y49WU6knVJn7G+mgs+/5bF4U0pATylX2YYu8GPkq1HprOzWwVLmLolBBh0dlxsJ9/2RM8Fx1jGzwC2NDVcZdvph++SrYRUDBbvT6N7Z/gxyYLirWuoleATCicC4B9sbMc=  ;
Message-ID: <445009A2.3030305@yahoo.com.au>
Date: Thu, 27 Apr 2006 10:00:34 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Zachary Amsden <zach@vmware.com>
CC: Andrew Morton <akpm@osdl.com>, Linux-Kernel <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Jan Beulich <jbeulich@novell.com>,
       Keir Fraser <Keir.Fraser@cl.cam.ac.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>
Subject: Re: [PATCH 2/2] I386 convert pae wmb to non smp
References: <200604262203.k3QM3qOC009581@zach-dev.vmware.com>
In-Reply-To: <200604262203.k3QM3qOC009581@zach-dev.vmware.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden wrote:

>Similar to the last bug, on set_pte, we don't want the compiler to re-order
>the write of the PTE, even in non-SMP configurations, since if the write of
>the low word occurs first, the TLB could prefetch a bad highmem mapping which
>has been aliased into low memory.
>

wmb() means that it also orders IO memory. It is no difference for
i386, but smp_wmb() actually has the right semantics of the abstract
Linux memory model.

>Signed-off-by: Zachary Amsden <zach@vmware.com>
>
>Index: linux-2.6.17-rc/include/asm-i386/pgtable-3level.h
>===================================================================
>--- linux-2.6.17-rc.orig/include/asm-i386/pgtable-3level.h	2006-04-26 08:38:57.000000000 -0700
>+++ linux-2.6.17-rc/include/asm-i386/pgtable-3level.h	2006-04-26 14:45:12.000000000 -0700
>@@ -53,7 +53,7 @@ static inline int pte_exec_kernel(pte_t 
> static inline void set_pte(pte_t *ptep, pte_t pte)
> {
> 	ptep->pte_high = pte.pte_high;
>-	smp_wmb();
>+	wmb();
> 	ptep->pte_low = pte.pte_low;
> }
> #define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
>
>  
>

Send instant messages to your online friends http://au.messenger.yahoo.com 
