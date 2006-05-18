Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWERJgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWERJgT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 05:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWERJgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 05:36:19 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:37014
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751139AbWERJgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 05:36:18 -0400
Message-Id: <446C5C6E.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Thu, 18 May 2006 11:37:18 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: Re: [discuss] Re: [PATCH 2/3] reliable stack trace support
	(x86-64)
References: <4469FC22.76E4.0078.0@novell.com> <200605161713.39575.ak@suse.de> <446A14B7.76E4.0078.0@novell.com> <200605161905.11907.ak@suse.de>
In-Reply-To: <200605161905.11907.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Andi Kleen <ak@suse.de> 16.05.06 19:05 >>>
>On Tuesday 16 May 2006 18:06, Jan Beulich wrote:
>> >>> Andi Kleen <ak@suse.de> 16.05.06 17:13 >>>
>> On Tuesday 16 May 2006 16:21, Jan Beulich wrote:
>> >> These are the x86_64-specific pieces to enable reliable stack traces. The
>> >> only restriction with this is that it currently cannot unwind across the
>> >> interrupt->normal stack boundary, as that transition is lacking proper
>> >> annotation.
>> >
>> >It would be nice if you could submit a patch to fix that.
>> 
>> But I don't know how to fix it. See my other mail 
>which mail?

Reply to Ingo (with you on cc) regarding patch 1/3. Just saying that I don't know much about expressions here.

>> - I have no experience with expressions, nor have I ever seen them in 
>> use.
>
>I remember Jim Houston used a hack of just loading the old stack into a register
>and defining that as a base register in CFI. I guess i would be willing 
>to trade a few moves for that (should be pretty much free on a OOO CPU anyways) 
>You think that trick would work?

I don't think that would, because without CONFIG_DEBUG_INFO none of the preserved registers get saved, hence there's no
register to use for this. Thus the price would not only be a move, but also a save/push and a reload/pop.
 
>> >> +#define UNW_PC(frame) (frame)->regs.rip
>> >> +#define UNW_SP(frame) (frame)->regs.rsp
>> >
>> >I think we alreay have instruction_pointer(). Better add a stack_pointer() 
>> >in ptrace.h too.
>> 
>> I could do that, but the macros will have to remain, as they don't access pt_regs directly, so I guess it'd be
>> pointless to change it.
>
>UNW_PC() is instruction_pointer(&frame->regs), isn't it?

Yes. But the intention is that the user of UNW_PC doesn't need to know any details of what fields frame has (i.e. the
parameter of UNW_PC must only be frame), so you can't replace it with instruction_pointer().

Jan
