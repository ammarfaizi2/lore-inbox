Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbWGENKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbWGENKX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 09:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbWGENKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 09:10:23 -0400
Received: from cantor2.suse.de ([195.135.220.15]:12211 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964837AbWGENKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 09:10:22 -0400
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] i386: early pagefault handler
References: <200607050745_MC3-1-C42B-9937@compuserve.com>
From: Andi Kleen <ak@suse.de>
Date: 05 Jul 2006 15:10:11 +0200
In-Reply-To: <200607050745_MC3-1-C42B-9937@compuserve.com>
Message-ID: <p73veqcp58s.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert <76306.1226@compuserve.com> writes:

> Page faults during kernel initialization can be hard to diagnose.
> 
> Add a handler that prints the fault address, EIP and top of stack
> when an early page fault happens.

You should do it for all the exceptions then
(except perhaps NMI). Isn't much more work - see the x86-64 code.



> +hlt_loop:
> +	hlt

There are still supported i386 CPUs that don't support HLT and
would recursively fault here.

> +	rep ; nop
> +	jmp 1b

Looks a bit weird to not jump to hlt back again but ok.
The HLT is unlikely to come back anyways because interrupts 
are off.

-Andi
