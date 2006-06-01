Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbWFAMTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWFAMTq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 08:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbWFAMTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 08:19:46 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:50716
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750900AbWFAMTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 08:19:45 -0400
Message-Id: <447EF7A8.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Thu, 01 Jun 2006 14:20:24 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: "Jeff Garzik" <jeff@garzik.org>, "Tejun Heo" <htejun@gmail.com>,
       "Andrew Morton" <akpm@osdl.org>,
       "Reuben Farrelly" <reuben-lkml@reub.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-rc5-mm2
References: <20060601014806.e86b3cc0.akpm@osdl.org> <447EB4AD.4060101@reub.net> <20060601025632.6683041e.akpm@osdl.org> <447EBD46.7010607@reub.net> <20060601103315.GA1865@elte.hu> <20060601105300.GA2985@elte.hu>
In-Reply-To: <20060601105300.GA2985@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Jan, the dwarf2 unwinder apparently fails if we call a NULL function. 

That is expected behavior, as a NULL program counter (to the unwinder) means end-of-stack-frames. It can't do anything
in that case, so the only solution I see is to either
- not at all call the unwinder from trap.c if the instruction pointer before the first unwind is not within kernel
space, or
- force fall-through to the old logic if the first unwind attempt didn't yield a change to either rIP or rSP (implying
that in that case there was no unwind information found to start with).

What do you think?

Jan
