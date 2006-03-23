Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbWCWAqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbWCWAqT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 19:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWCWAqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 19:46:19 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:35343 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751050AbWCWAqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 19:46:18 -0500
Message-ID: <4421EFD9.8060402@vmware.com>
Date: Wed, 22 Mar 2006 16:46:17 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: Chris Wright <chrisw@sous-sol.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       virtualization@lists.osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christopher Li <chrisl@vmware.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>, Andi Kleen <ak@suse.de>,
       Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Anne Holler <anne@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Jyothy Reddy <jreddy@vmware.com>, Kip Macy <kmacy@fsmware.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [Xen-devel] Re: [RFC, PATCH 5/24] i386 Vmi code patching
References: <200603131802.k2DI2nv8005665@zach-dev.vmware.com>	<200603222115.46926.ak@suse.de>	<20060322214025.GJ15997@sorel.sous-sol.org> <4421EC44.7010500@us.ibm.com>
In-Reply-To: <4421EC44.7010500@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anthony Liguori wrote:
> Chris Wright wrote:
>> * Andi Kleen (ak@suse.de) wrote:
>>  
>>> The disassembly stuff indeed doesn't look like something
>>> that belongs in the kernel.
>>>     
>>
>> Strongly agreed.  The strict ABI requirements put forth here are not
>> in-line with Linux, IMO.  I think source compatibility is the limit of
>> reasonable, and any ROM code be in-tree if something like this were to
>> be viable upstream.
>>   
>
> Hi Chris,
>
> Would you have less trouble if the "ROM" were actually more like a 
> module?  Specifically, if it had a proper elf header and symbol table, 
> used symbols as entry points, and was a GPL interface (so that ROM's 
> had to be GPL)?  Then it's just a kernel module that's hidden in the 
> option ROM space and has a C interface.
>
> I know you end up losing the ability to do crazy inlining of the ROM 
> code but I think it becomes a much less hairy interface that way.

Actually, I think you still can get the ability to do crazy inlining of 
the ROM code.  You have three exports from the ELF module:

vmi_init - enter paravirtual mode
vmi_annotate - apply inline transformations based on inlining
vmi_exit - exit paravirtual mode (required for module unloading).

But you can't require the ROM to be GPL'd.  It has to be multi-licensed 
for compatibility with other open source or, even proprietary operating 
systems.  If the ROM is licensed for use only under the GPL, then by 
including it in your kernel and allowing it to patch your kernel code, 
you leave your non-GPL kernel in a questionable license state.  If the 
ROM is licensed under an open license, with a clause allowing its 
inclusion into GPL'd software, then I don't think you have a problem.  
Course I could be wrong.  This is sort of a unique situation, and 
finding an identical comparison is tricky.

Zach
