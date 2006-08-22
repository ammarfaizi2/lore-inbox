Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751403AbWHVRgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbWHVRgh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 13:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWHVRgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 13:36:37 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:7899 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751403AbWHVRgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 13:36:36 -0400
Message-ID: <44EB40A3.50700@vmware.com>
Date: Tue, 22 Aug 2006 10:36:35 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
Cc: virtualization@lists.osdl.org, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] paravirt.h
References: <1155202505.18420.5.camel@localhost.localdomain> <200608221550.57603.ak@muc.de> <20060822142519.GX11651@stusta.de> <200608221654.10558.ak@muc.de>
In-Reply-To: <200608221654.10558.ak@muc.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Tuesday 22 August 2006 16:25, Adrian Bunk wrote:
>   
>> On Tue, Aug 22, 2006 at 03:50:57PM +0200, Andi Kleen wrote:
>>     
>>>> this would need a "const after boot" section; which is really not hard
>>>> to make and probably useful for a lot more things.... todo++
>>>>         
>>> except for anything that needs tlb entries in user space. And it only gives you
>>> false sense of security. --todo
>>>       
>> What's the alternative?
>>     
>
> The alternative is to not protect it, since protecting it doesn't
> offer any significant additional security over not protecting it.
>   

Didn't someone point out yet that if you are vulnerable to someone 
loading a kernel module of their choosing, you lose, plain and simple?  
You don't need paravirt-ops to implement a rootkit, and it doesn't make 
it any easier, and write protecting it is totally useless.  How do you 
think VMware runs on Linux?  It takes over the hardware entirely, loads 
a hypervisor, and starts running in a completely different world.  And 
it doesn't even need to use a single _GPL'd export to do that.

Write protection is great as a debug option to find accidental memory 
corruptions.  It is useless as a technique to prevent subversion.  Um 
hello, you're already at CPL-0.  Just rewrite the page tables already.

>> Change it from a struct to a compile time choice?
>>     
>
> One of the design goals of paravirt-ops was to allow single binaries
> that run on both native hardware and on hypervisors. So that would
> be a non starter.

Strongly agree.

Zach
