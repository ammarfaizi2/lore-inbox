Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbWCNE66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbWCNE66 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 23:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWCNE66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 23:58:58 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:49668 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750948AbWCNE66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 23:58:58 -0500
Message-ID: <44164CDD.6030608@vmware.com>
Date: Mon, 13 Mar 2006 20:55:57 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Jyothy Reddy <jreddy@vmware.com>,
       Jack Lo <jlo@vmware.com>, Kip Macy <kmacy@fsmware.com>,
       Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 0/24] VMI i386 Linux virtualization interface proposal
References: <200603131758.k2DHwQM7005618@zach-dev.vmware.com> <441610DE.5060709@us.ibm.com> <44164013.1080404@vmware.com> <Pine.LNX.4.63.0603132304200.17874@cuia.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.63.0603132304200.17874@cuia.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Mon, 13 Mar 2006, Zachary Amsden wrote:
>
>   
>> About performance - I actually believe that it is possible to implement 
>> VMI Linux in such a way that it actually has _better_ performance on Xen 
>> than the current XenoLinux kernels.
>>     
>
> How would VMI allow page table batching at fault time?
> (one of the future optimizations that are probably worth
> making for Xen)
>   

This is exactly what we do.  All page table transitions from P->NP or 
P->P already require a flushing call (FlushTLB or InvalPage).  The 
remaining transitions, NP->P require explicit flushing, and we have 
added the appropriate call sites to do so.  It turns out, the external 
MMU cache on Sparc provided exactly the required hook point in this case 
- update_mmu_cache().

Zach
