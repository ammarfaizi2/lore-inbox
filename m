Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVBFMDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVBFMDU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 07:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVBFMDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 07:03:19 -0500
Received: from mx2.elte.hu ([157.181.151.9]:63898 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261187AbVBFMDM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 07:03:12 -0500
Date: Sun, 6 Feb 2005 13:02:44 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, drepper@redhat.com
Subject: Re: [PROPOSAL/PATCH] Remove PT_GNU_STACK support before 2.6.11
Message-ID: <20050206120244.GA28061@elte.hu>
References: <20050206113635.GA30109@wotan.suse.de> <20050206114758.GA8437@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206114758.GA8437@infradead.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Arjan van de Ven <arjan@infradead.org> wrote:

> > [...] when the program has trampolines and has PT_GNU_STACK
> > header with an E bit on the stack it still won't get an executable
> > heap by default  (this is what broke grub)
> 
> this I can fix easy, see the patch below
> 
> the problem is in the read_implies_exec() design, it passed in "does
> it have a PT_GNU_STACK flag" not the value. Easy fix.

> So I rather see the patch below merged instead; it fixes the worst
> problems (RWE not marking the heap executable) while keeping this
> useful feature enabled.
> 
> Signed-off-by: Arjan van de Ven <arjan@infradead.org>

looks good.

 Signed-off-by: Ingo Molnar <mingo@elte.hu>

(I'd like to stress that this problem only affects packages _recompiled_
with new gcc, running on NX capable CPUs - legacy apps or CPUs are in no
way affected. Also, even with a recompile, apps/kernels/distros have a
number of other options as well even without this kernel fix, of varying
granularity: to use the setarch utility, to set the READ_IMPLIES_EXEC
personality bit within the code, or to pass in the noexec=off kernel
commandline option, or to add a oneliner patch to their heap of 1500+
kernel patches, or to fix the application. Also, with Arjan's patch
applied, the execstack utility can be used to remark the binary
permanently, if needed.)

	Ingo
