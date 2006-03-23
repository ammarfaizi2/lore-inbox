Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWCWAyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWCWAyE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 19:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWCWAyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 19:54:04 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:45245 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932086AbWCWAyD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 19:54:03 -0500
Message-ID: <4421F190.2050908@us.ibm.com>
Date: Wed, 22 Mar 2006 18:53:36 -0600
From: Anthony Liguori <aliguori@us.ibm.com>
User-Agent: Mail/News 1.5 (X11/20060309)
MIME-Version: 1.0
To: Zachary Amsden <zach@vmware.com>
CC: Chris Wright <chrisw@sous-sol.org>,
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
References: <200603131802.k2DI2nv8005665@zach-dev.vmware.com>	<200603222115.46926.ak@suse.de>	<20060322214025.GJ15997@sorel.sous-sol.org> <4421EC44.7010500@us.ibm.com> <4421EFD9.8060402@vmware.com>
In-Reply-To: <4421EFD9.8060402@vmware.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden wrote:
>> Hi Chris,
>>
>> Would you have less trouble if the "ROM" were actually more like a 
>> module?  Specifically, if it had a proper elf header and symbol 
>> table, used symbols as entry points, and was a GPL interface (so that 
>> ROM's had to be GPL)?  Then it's just a kernel module that's hidden 
>> in the option ROM space and has a C interface.
>>
>> I know you end up losing the ability to do crazy inlining of the ROM 
>> code but I think it becomes a much less hairy interface that way.
>
> Actually, I think you still can get the ability to do crazy inlining 
> of the ROM code.  You have three exports from the ELF module:
>
> vmi_init - enter paravirtual mode
> vmi_annotate - apply inline transformations based on inlining
> vmi_exit - exit paravirtual mode (required for module unloading).

Hrm, I was actually thinking that each of the VMI calls would be an 
export (vmi_init, vmi_set_pxe, etc.).  I know that you want the 
hypervisor to drive the inlining but I that's sufficiently hairy (not to 
mention, there's not AFAIK performance data yet to justify it) that I 
think it ought to be left for VMI 2.0.

> But you can't require the ROM to be GPL'd.  It has to be 
> multi-licensed for compatibility with other open source or, even 
> proprietary operating systems.  If the ROM is licensed for use only 
> under the GPL, then by including it in your kernel and allowing it to 
> patch your kernel code, you leave your non-GPL kernel in a 
> questionable license state.  If the ROM is licensed under an open 
> license, with a clause allowing its inclusion into GPL'd software, 
> then I don't think you have a problem.  Course I could be wrong.  This 
> is sort of a unique situation, and finding an identical comparison is 
> tricky.

Multi-licensing is fine as long as one is GPL :-)

Regards,

Anthony Liguori

> Zach

