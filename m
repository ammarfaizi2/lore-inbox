Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbWCWAAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbWCWAAq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 19:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWCWAAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 19:00:46 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:21000 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932421AbWCWAAp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 19:00:45 -0500
Message-ID: <4421E52B.2040503@vmware.com>
Date: Wed, 22 Mar 2006 16:00:43 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
Subject: Re: [RFC, PATCH 10/24] i386 Vmi descriptor changes
References: <200603131806.k2DI6jlJ005700@zach-dev.vmware.com> <200603222124.03284.ak@suse.de>
In-Reply-To: <200603222124.03284.ak@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>> -#define _set_gate(gate_addr,type,dpl,addr,seg) \
>> -do { \
>> -  int __d0, __d1; \
>> -  __asm__ __volatile__ ("movw %%dx,%%ax\n\t" \
>> -	"movw %4,%%dx\n\t" \
>> -	"movl %%eax,%0\n\t" \
>> -	"movl %%edx,%1" \
>> -	:"=m" (*((long *) (gate_addr))), \
>> -	 "=m" (*(1+(long *) (gate_addr))), "=&a" (__d0), "=&d" (__d1) \
>> -	:"i" ((short) (0x8000+(dpl<<13)+(type<<8))), \
>> -	 "3" ((char *) (addr)),"2" ((seg) << 16)); \
>> -} while (0)
>>     
>
>
> The ugly piece of code doesn't do anything priviledged. So why do you want
> to move it?
>
>   

I didn't think I moved it.  I wrote a clean version instead.  It does do 
something problematic for virtualization, by not allowing the VMI layer 
to override the DPL on descriptors or RPL of segments.  It might be 
convenient for the hypervisor platform layer to do that.

Zach
