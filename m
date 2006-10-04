Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030548AbWJDJYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030548AbWJDJYd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 05:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030770AbWJDJYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 05:24:33 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:2578
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1030548AbWJDJYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 05:24:32 -0400
Message-Id: <45239A38.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Wed, 04 Oct 2006 10:25:44 +0100
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: "Ingo Molnar" <mingo@elte.hu>, "Eric Rannaud" <eric.rannaud@gmail.com>,
       "Andrew Morton" <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>,
       "Chandra Seetharaman" <sekharan@us.ibm.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <nagar@watson.ibm.com>
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18)
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com>
 <Pine.LNX.4.64.0609301237460.3952@g5.osdl.org>
 <200609302230.24070.ak@suse.de>
In-Reply-To: <200609302230.24070.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The lockdep warning in itself is probably valid, but the reason for the 
>> _hang_ is the
>> 
>> 	[  138.831385] Unable to handle kernel paging request at ffffffff82800000 RIP:
>> 	[  138.831439]  [<ffffffff8020b491>] show_trace+0x311/0x380  
>> 
>> and that code is just a total mess. 
>
>The code decides to do a fallback at the top of stack space for some reason.
>
>Hmm, i've seen this working on other kernel threads, but maybe 
>that was luck. Kernel threads don't end up in user space 
>so the normal check for that doesn't work.
>I guess we just need another termination for the kernel threads
>by pushing a 0 there explicitely. Jan, do you agree?

I thought we had done this already.

>> > [  138.751306]  [<ffffffff8021ecc0>] search_extable+0x40/0x70
>
>After here the unwinder seems to become a bit and it shouldn't print
>multiple entries. Jan any ideas why?

Not without raw stack contents.

>Proposed patch appended. Jan, what do you think?

As said above - I thought we added zero-termination already.

Jan
