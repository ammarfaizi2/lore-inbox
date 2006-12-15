Return-Path: <linux-kernel-owner+w=401wt.eu-S1752063AbWLOMRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063AbWLOMRf (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 07:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752066AbWLOMRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 07:17:34 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:35084
	"EHLO public.id2-vpn.continvity.gns.novell.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752063AbWLOMRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 07:17:33 -0500
Message-Id: <4582A0A9.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Fri, 15 Dec 2006 12:18:33 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: "Andrew Morton" <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>,
       "Andi Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19, more unwinder problems ...
References: <20061215101546.GA2296@elte.hu>
 <45828D19.76E4.0078.0@novell.com> <20061215112435.GA14824@elte.hu>
In-Reply-To: <20061215112435.GA14824@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Ingo Molnar <mingo@elte.hu> 15.12.06 12:24 >>>
>
>* Jan Beulich <jbeulich@novell.com> wrote:
>
>> validating that the item read is between current and previous stack 
>> pointer, which in turn are being derived from register state and 
>> unwind information.
>
>i still dont quite get it - and i feel deja vu. Didnt we agree that the 
>right way to go about this is to validate all stack information based on 
>what the kernel already knows about all the stacks that the task may 
>use? I.e. only allow pointers into the kernel stack and into the various 
>kernel stacks. No 'probe kernel pointer' or anything. If the unwind data 
>or register state ever points outside that basic filter, abandon the 
>walk. Am i missing something?

No, we didn't agree on this. Linus asked me to, but I didn't agree (Andi
seemed to tend towards Linus' opinion), based on my intentions of rather
(mid to long term) removing all this a priori knowledge of what stacks may
be switched from/to. Also, I think a filter like you suggest can far too
easily get out of sync with reality (as an example, on i386 I had long ago
submitted a patch to enhance the double fault handling, which hadn't
been rejected with a reason but also wasn't picked up - in that light I
would immediately question whether the double fault stack, in anticipation
of the double fault handler hopefully calling the unwinder rather sooner
than later to get out information, if possible, on what lead to the double
fault, should be treated positively by that filter, and whether, once that
stack finally gets converted to a per-CPU ones, it would be remembered
to update the filter accordingly).

Basically, as I stated before, I wouldn't try to veto a change that does
that (especially under the impression that my opinion here doesn't seem
to count), but I would neither put me as Signed-off-by or Acked-by
under it.

Jan
