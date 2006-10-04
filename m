Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161211AbWJDMJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161211AbWJDMJG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 08:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161208AbWJDMJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 08:09:06 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:17202
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1161211AbWJDMJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 08:09:04 -0400
Message-Id: <4523C0CD.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Wed, 04 Oct 2006 13:10:21 +0100
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: "Ingo Molnar" <mingo@elte.hu>, "Eric Rannaud" <eric.rannaud@gmail.com>,
       "Andrew Morton" <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>,
       "Chandra Seetharaman" <sekharan@us.ibm.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <nagar@watson.ibm.com>
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18)
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com>
 <200610041252.48721.ak@suse.de> <4523BE20.76E4.0078.0@novell.com>
 <200610041403.37318.ak@suse.de>
In-Reply-To: <200610041403.37318.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Andi Kleen <ak@suse.de> 04.10.06 14:03 >>>
>On Wednesday 04 October 2006 13:58, Jan Beulich wrote:
>> >> >Proposed patch appended. Jan, what do you think?
>> >> 
>> >> As said above - I thought we added zero-termination already.
>> >
>> >For head.S but not for kernel_thread I think. At least I can't
>> >find any existing code for kernel_thread().
>> 
>> 2.6.18-git11 (i386) already has an annotated version of
>> kernel_thread_helper() in entry.S, including the pushing of a
>> fake (zero) return address. x86-64 has child_rip with the
>> added push even in original 2.6.18.
>
>True. 
>
>I wonder why it didn't work then and why my patch fixed the crash. 

That what I'm curious about too.

>Ok the pushl is outside the CFI_STARTPROC
>
>ENTRY(kernel_thread_helper)
>        pushl $0                # fake return address for unwinder
>        CFI_STARTPROC

Intentionally - before the push there is *no* return address at all.

Jan
