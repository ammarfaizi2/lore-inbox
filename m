Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751681AbWEPIX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681AbWEPIX5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 04:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751682AbWEPIX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 04:23:57 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:10000 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751680AbWEPIX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 04:23:57 -0400
Message-ID: <44698A74.3090400@vmware.com>
Date: Tue, 16 May 2006 01:16:52 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       virtualization <virtualization@lists.osdl.org>,
       Gerd Hoffmann <kraxel@suse.de>
Subject: Re: [PATCH] Gerd Hoffman's move-vsyscall-into-user-address-range
 patch
References: <1147759423.5492.102.camel@localhost.localdomain> <20060516064723.GA14121@elte.hu>
In-Reply-To: <20060516064723.GA14121@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Rusty Russell <rusty@rustcorp.com.au> wrote:
>
>   
>> AFAICT we'll pay one extra TLB entry for this patch.  Zach had a patch 
>> which left the vsyscall page at the top of memory (minus hole for 
>> hypervisor) and patched the ELF header at boot.
>>     
>
> i'd suggest the solution from exec-shield (which has been there for a 
> long time), which also randomizes the vsyscall vma. Exploits are already 
> starting to use the vsyscall page (with predictable addresses) to 
> circumvent randomization, it provides 'interesting' instructions to act 
> as a syscall-functionality building block. Moving that address to 
> another predictable place solves the virtualization problem, but doesnt 
> solve the address-space randomization problem.
>   

Let's dive into it.  How do you get the randomization without 
sacrificing syscall performance?  Do you randomize on boot, dynamically, 
or on a per-process level?  Because I can see some issues with 
per-process randomization that will certainly cost some amount of cycles 
on the system call path.  Marginal perhaps, but that is exactly where 
you don't want to shed cycles unnecessarily, and the complexity of the 
whole thing will go up quite a bit I think.

Zach
