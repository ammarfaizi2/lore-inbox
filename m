Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965031AbVKVRoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965031AbVKVRoR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 12:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965033AbVKVRoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 12:44:16 -0500
Received: from quark.didntduck.org ([69.55.226.66]:14533 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S965031AbVKVRoO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 12:44:14 -0500
Message-ID: <4383597E.7060300@didntduck.org>
Date: Tue, 22 Nov 2005 12:46:38 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mail/News 1.5 (X11/20051105)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Benjamin LaHaise <bcrl@kvack.org>, linux-kernel@vger.kernel.org
Subject: Re: rfc/rft: use r10 as current on x86-64
References: <20051122165204.GG1127@kvack.org> <20051122171040.GY20775@brahms.suse.de>
In-Reply-To: <20051122171040.GY20775@brahms.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Tue, Nov 22, 2005 at 11:52:04AM -0500, Benjamin LaHaise wrote:
>> Hello Andi et al,
>>
>> The patch below converts x86-64 to use r10 as the current pointer instead 
>> of gs:pcurrent.  This results in a ~34KB savings in the code segment of 
>> the kernel.  I've tested this with running a few regular applications, 
>> plus a few 32 bit binaries.  If this patch is interesting, it probably 
>> makes sense to merge the thread info structure into the task_struct so 
>> that the assembly bits for syscall entry can be cleaned up.  Comments?
> 
> I think you could get most of the benefit by just dropping
> the volatile and "memory" from read_pda(). With that gcc would
> usually CSE current into a register and it would would work essentially
> the same way with only minor more .text overhead, but r10 would be still
> available.

It seems that GCC is reluctant to use the extended registers anyways 
because of the rex prefix, so I don't think dedicating r10 to current 
will cause that many problems.

--
				Brian Gerst
