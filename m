Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263364AbTC0SAa>; Thu, 27 Mar 2003 13:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263365AbTC0SAa>; Thu, 27 Mar 2003 13:00:30 -0500
Received: from vbws78.voicebs.com ([66.238.160.78]:41991 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S263364AbTC0SA2>; Thu, 27 Mar 2003 13:00:28 -0500
Message-ID: <3E833EDD.9050007@didntduck.org>
Date: Thu, 27 Mar 2003 13:11:41 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm offsets for i386
References: <mailman.1048773360.3585.linux-kernel2news@redhat.com> <200303271728.h2RHSDc28540@devserv.devel.redhat.com>
In-Reply-To: <200303271728.h2RHSDc28540@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:
>>[Resend]
>>
>>This patch creates an asm-offsets.c file for i386, and removes the
>>hardcoded constants from several asm files.
>>
>>--
>>				Brian Gerst
> 
> 
> Doesn't seem to be worth the trouble because thread_info
> is a small structure, not embedded into a big structure
> as thread_struct was. DaveM removed the automatic
> offset generation on sparc64 and I am thinking to do
> the same on sparc.
> 
> I'm not surprised that nobody answered, the patch seems
> to be rather pointless.
> 
> We might want to add something like this:
> 
>     if (TI_CPU         != offsetof(struct thread_info, cpu) ||
>         TI_PREEMPT     != offsetof(struct thread_info, preempt_count) ||
>         TI_SOFTIRQ     != offsetof(struct thread_info, softirq_count) ||
>         TI_HARDIRQ     != offsetof(struct thread_info, hardirq_count))
>             thread_info_offsets_are_bolixed_linus();
> 
> It gives out an link time error.
> 
> -- Pete
> 

I already caught one bug with this, since someone recently added values 
to the feature flags array and didn't fix up the vendor id offset.  What 
you propose fails with some non-gcc compilers (Intel's compiler for 
example, which supports gcc extensions) that don't optimize it away.

--
				Brian Gerst

