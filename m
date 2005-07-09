Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbVGIQpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbVGIQpE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 12:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbVGIQpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 12:45:04 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:9637 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S261577AbVGIQpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 12:45:01 -0400
Date: Sat, 9 Jul 2005 09:44:55 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, arjanv@infradead.org,
       guichaz@gmail.com
Subject: Re: [patch] compress the stack layout of do_page_fault(), x86
Message-Id: <20050709094455.0ef508e3.rdunlap@xenotime.net>
In-Reply-To: <20050709152924.GA13492@elte.hu>
References: <20050709144116.GA9444@elte.hu>
	<20050709152924.GA13492@elte.hu>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Jul 2005 17:29:24 +0200 Ingo Molnar wrote:

| 
| Guillaume noticed a bug in the patch, si_signo should be used instead of 
| SIGSEGV. (doh) New patch below.
| 
| 	Ingo
| 
| -----
| 
| this patch pushes the creation of a rare signal frame (SIGBUS or 
| SIGSEGV) into a separate function, thus saving stackspace in the main 
| do_page_fault() stackframe. The effect is 132 bytes less of stack used 
| by the typical do_page_fault() invocation - resulting in a denser 
| cache-layout.
| 
| (another minor effect is that in case of kernel crashes that come from a 
| pagefault, we add less space to the already existing frame, giving the 
| crash functions a slightly higher chance to do their stuff without 
| overflowing the stack.)
| 
| (the changes also result in slightly cleaner code.)
| 
| build and boot tested.

Hi Ingo-

Just to clarify this, "boot tested" does not mean that this
changed code was tested, right?
or do you have a test case that was tested?

Thanks,
---
~Randy
