Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751625AbWCOW4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbWCOW4Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 17:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751818AbWCOW4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 17:56:25 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:30470 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751625AbWCOW4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 17:56:24 -0500
Message-ID: <44189B97.2040802@vmware.com>
Date: Wed, 15 Mar 2006 14:56:23 -0800
From: Daniel Arai <arai@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
Cc: Zachary Amsden <zach@vmware.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Anne Holler <anne@vmware.com>, Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Rik Van Riel <riel@redhat.com>, Jyothy Reddy <jreddy@vmware.com>,
       Jack Lo <jlo@vmware.com>, Kip Macy <kmacy@fsmware.com>,
       Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 1/24] i386 Vmi documentation
References: <200603131759.k2DHxeep005627@zach-dev.vmware.com> <20060313224902.GD12807@sorel.sous-sol.org> <4416078C.4030705@vmware.com> <20060314212742.GL12807@sorel.sous-sol.org> <441743BD.1070108@vmware.com> <20060315025720.GN12807@sorel.sous-sol.org>
In-Reply-To: <20060315025720.GN12807@sorel.sous-sol.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Zachary Amsden (zach@vmware.com) wrote:
> 
>>>1) can't use stack based args, so have to allocate each data structure,
>>>which could conceivably fail unless it's some fixed buffer.
>>
>>We use a fixed buffer that is private to our VMI layer.  It's a per-cpu 
>>packing struct for hypercalls.  Dynamically allocating from the kernel 
>>inside the interface layer is a really great way to get into a whole lot 
>>of trouble.
> 
> 
> Heh, indeed that's why I asked.  per-cpu buffer means ROM state knows
> which vcpu is current.  How is this done in OS agnostic method w/out
> trapping to hypervisor?  Some shared data that ROM and VMM know about,
> and VMM updates as it schedules each vcpu?

Each VCPU gets a private data area at the same linear address. The VMM 
constructs private page table shadows for each VCPU, and the shadows magically 
contain the right mappings for that VCPU's private data area.

Other hypervisor implementations (especially those that don't make use of shadow 
page tables) would have to come up with something along the lines that you're 
suggesting.

Dan.
