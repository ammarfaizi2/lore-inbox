Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030832AbWJDMDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030832AbWJDMDp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 08:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030791AbWJDMDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 08:03:45 -0400
Received: from ns2.suse.de ([195.135.220.15]:35042 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030833AbWJDMDo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 08:03:44 -0400
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18)
Date: Wed, 4 Oct 2006 14:03:37 +0200
User-Agent: KMail/1.9.3
Cc: "Ingo Molnar" <mingo@elte.hu>, "Eric Rannaud" <eric.rannaud@gmail.com>,
       "Andrew Morton" <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>,
       "Chandra Seetharaman" <sekharan@us.ibm.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       nagar@watson.ibm.com
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com> <200610041252.48721.ak@suse.de> <4523BE20.76E4.0078.0@novell.com>
In-Reply-To: <4523BE20.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610041403.37318.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 October 2006 13:58, Jan Beulich wrote:
> >> >Proposed patch appended. Jan, what do you think?
> >> 
> >> As said above - I thought we added zero-termination already.
> >
> >For head.S but not for kernel_thread I think. At least I can't
> >find any existing code for kernel_thread().
> 
> 2.6.18-git11 (i386) already has an annotated version of
> kernel_thread_helper() in entry.S, including the pushing of a
> fake (zero) return address. x86-64 has child_rip with the
> added push even in original 2.6.18.

True. 

I wonder why it didn't work then and why my patch fixed the crash. 

Ok the pushl is outside the CFI_STARTPROC

ENTRY(kernel_thread_helper)
        pushl $0                # fake return address for unwinder
        CFI_STARTPROC
..

-Andi

