Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965027AbVKVRz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027AbVKVRz5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 12:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965036AbVKVRz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 12:55:57 -0500
Received: from hermes.domdv.de ([193.102.202.1]:34571 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S965027AbVKVRz4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 12:55:56 -0500
Message-ID: <43835BA0.6000702@domdv.de>
Date: Tue, 22 Nov 2005 18:55:44 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051004)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brian Gerst <bgerst@didntduck.org>
CC: Andi Kleen <ak@suse.de>, Benjamin LaHaise <bcrl@kvack.org>,
       linux-kernel@vger.kernel.org
Subject: Re: rfc/rft: use r10 as current on x86-64
References: <20051122165204.GG1127@kvack.org> <20051122171040.GY20775@brahms.suse.de> <4383597E.7060300@didntduck.org>
In-Reply-To: <4383597E.7060300@didntduck.org>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:
> Andi Kleen wrote:
> 
>> On Tue, Nov 22, 2005 at 11:52:04AM -0500, Benjamin LaHaise wrote:
>>
>>> Hello Andi et al,
>>>
>>> The patch below converts x86-64 to use r10 as the current pointer
>>> instead of gs:pcurrent.  This results in a ~34KB savings in the code
>>> segment of the kernel.  I've tested this with running a few regular
>>> applications, plus a few 32 bit binaries.  If this patch is
>>> interesting, it probably makes sense to merge the thread info
>>> structure into the task_struct so that the assembly bits for syscall
>>> entry can be cleaned up.  Comments?
>>
>>
>> I think you could get most of the benefit by just dropping
>> the volatile and "memory" from read_pda(). With that gcc would
>> usually CSE current into a register and it would would work essentially
>> the same way with only minor more .text overhead, but r10 would be still
>> available.
> 
> 
> It seems that GCC is reluctant to use the extended registers anyways
> because of the rex prefix, so I don't think dedicating r10 to current
> will cause that many problems.

Be aware of assembler that uses r10, e.g.
arch/x86_64/crypto/aes-x86_64-asm.S
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
