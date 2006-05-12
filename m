Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWELNuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWELNuX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 09:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWELNuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 09:50:23 -0400
Received: from ns2.suse.de ([195.135.220.15]:45198 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932074AbWELNuW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 09:50:22 -0400
To: Tomasz Malesinski <tmal@mimuw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Segfault on the i386 enter instruction
References: <20060512131654.GB2994@duch.mimuw.edu.pl>
From: Andi Kleen <ak@suse.de>
Date: 12 May 2006 15:50:20 +0200
In-Reply-To: <20060512131654.GB2994@duch.mimuw.edu.pl>
Message-ID: <p734pzv73oj.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Malesinski <tmal@mimuw.edu.pl> writes:

> The code attached below segfaults on the enter instruction. It works
> when a stack frame is created by the three commented out
> instructions and also when the first operand of the enter instruction
> is small (less than about 6500 on my system).

The difference is the value of the stack pointer when the page fault
of extending the stack downwards occurs. For the long sequence 
ESP is already changed when it happens. For ENTER the CPU undoes
the change before raising the fault. The page fault handler
checks the page fault against ESP to catch invalid references below
the stack.

I don't think the 64bit kernel does anything different here than the 
32bit kernel. I tested it on a 32bit box and it faulted there too.

Handling it like you expect would require to disassemble 
the function in the page fault handler and it's probably not 
worth doing that for this weird case.

-Andi
