Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWGRLdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWGRLdy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 07:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWGRLdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 07:33:54 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:1475 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932177AbWGRLdx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 07:33:53 -0400
Message-ID: <44BCC720.7050601@vmware.com>
Date: Tue, 18 Jul 2006 04:33:52 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 18/33] Subarch support for CPUID instruction
References: <20060718091807.467468000@sous-sol.org>	 <20060718091953.003336000@sous-sol.org> <1153217686.3038.37.camel@laptopd505.fenrus.org>
In-Reply-To: <1153217686.3038.37.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Tue, 2006-07-18 at 00:00 -0700, Chris Wright wrote:
>   
>> plain text document attachment (i386-cpuid)
>> Allow subarchitectures to modify the CPUID instruction.  This allows
>> the subarch to provide a limited set of CPUID feature flags during CPU
>> identification.  Add a subarch implementation for Xen that traps to the
>> hypervisor where unsupported feature flags can be hidden from guests.
>>     
>
> Hi,
>
> I'm wondering if this is entirely the wrong level of abstraction; to me
> it feels the subarch shouldn't override the actual cpuid, but the cpu
> feature flags that linux uses. That's a lot less messy: cpuid has many
> many pieces of information which are near impossible to filter in
> practice, however filtering the USAGE of it is trivial; linux basically
> flattens the cpuid namespace into a simple bitmap of "what the kernel
> can use". That is really what the subarch should filter/fixup, just like
> we do for cpu quirks etc etc.
>   

You really need a CPUID hook.  The instruction is non-virtualizable, and 
anything claiming to be a hypervisor really has to support masking and 
flattening the cpuid namespace for the instruction itself.  It is used 
in assembler code and very early in boot.  The alternative is injecting 
a bunch of Xen-specific code to filter feature bits into the i386 layer, 
which is both bad for Linux and bad for Xen - and was quite ugly in the 
last set of Xen patches.

Zach
