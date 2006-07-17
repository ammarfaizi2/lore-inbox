Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWGQSHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWGQSHV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 14:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWGQSHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 14:07:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23760 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751111AbWGQSHU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 14:07:20 -0400
Date: Mon, 17 Jul 2006 11:08:26 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Krzysztof Halasa <khc@pm.waw.pl>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] i386: fix recursive fault in page-fault handler
In-Reply-To: <200607171322_MC3-1-C53B-6253@compuserve.com>
Message-ID: <Pine.LNX.4.64.0607171107390.15611@evo.osdl.org>
References: <200607171322_MC3-1-C53B-6253@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Jul 2006, Chuck Ebbert wrote:
>
> Krzysztof Halasa reported recursive faults in do_page_fault()
> causing a stream of partial oops messages on the console. Fix
> by adding a fixup for that code.

This patch is really too ugly to live. Does it even work? If 'tsk' is 
broken, I'd expect the die() to oops anyway - it does

	if (notify_die(DIE_OOPS, str, regs, err,
                       current->thread.trap_no, SIGSEG...

anyway (where that "current->thread.trap_no" gets dereferenced).

		Linus
