Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750931AbWCOFzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbWCOFzO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 00:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbWCOFzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 00:55:14 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:47120 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750931AbWCOFzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 00:55:12 -0500
Message-ID: <4417AC0B.5040503@vmware.com>
Date: Tue, 14 Mar 2006 21:54:19 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 8/24] i386 Vmi syscall assembly
References: <200603131805.k2DI5BVv005686@zach-dev.vmware.com> <20060315030115.GO12807@sorel.sous-sol.org>
In-Reply-To: <20060315030115.GO12807@sorel.sous-sol.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Zachary Amsden (zach@vmware.com) wrote:
>   
>> These changes are sufficient to glue the Linux low level entry points to
>> hypervisor event injection by emulating the native processor exception
>> frame interface.
>>     
>
> There's a bit more going on in the Xen changes to entry.S.  The STI/CLI
> abstraction definitely gets partway there.  Then there's some bits that
> use (in your terms) __STI, __CLI.  It's in code that's a pure addition
> so it's tempting to simply make a mechanism for the additions, but it's a bit
> too intertwined to just separate that code, as there's calls from core
> entry.S into the Xen additions.
>   

Yes, entry.S in Xen is a lot more complicated because of the event 
channel stuff.  I don't think we're adverse to supporting the event 
channel interface, I just think that you can actually get a cleaner and 
simpler implementation without it.

>> N.B. Sti; Sysexit is a required abstraction, as the STI instruction implies
>> holdoff of interrupts, which is destroyed by any NOP padding.
>>     
>
> Or just disable systenter ;-)  Random question...do you support systenter?
> Sounds slower than int80, since it should require 3->0->1->0->3 transitions.
> Just idly curious if you've done benchmarks to see the difference.
>   

Still required for VMI kernels on native - so the padding of sti doesn't 
affect the holdoff in that case.  We actually do use sysenter.  We've 
done the benchmarks, and found the tradeoffs and benefits are similar 
for both approaches.

Zach
