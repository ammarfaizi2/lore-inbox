Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265800AbUJRKfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265800AbUJRKfh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 06:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266155AbUJRKfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 06:35:36 -0400
Received: from mx2.elte.hu ([157.181.151.9]:56735 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265800AbUJRKfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 06:35:12 -0400
Date: Mon, 18 Oct 2004 12:36:33 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniele Pizzoni <auouo@tin.it>
Cc: kernel-janitors <kernel-janitors@lists.osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/8] replacing/fixing printk with pr_debug/pr_info in arch/i386 - intro
Message-ID: <20041018103633.GA6792@elte.hu>
References: <1098031764.3023.45.camel@pdp11.tsho.org> <20041017161953.GA24810@elte.hu> <1098067288.2892.293.camel@pdp11.tsho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098067288.2892.293.camel@pdp11.tsho.org>
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


* Daniele Pizzoni <auouo@tin.it> wrote:

> On dom, 2004-10-17 at 18:19, Ingo Molnar wrote: 
> > [...]
> > 
> > 1) be careful, there is no inconsistency here. It's a printk that doesnt
> > end in a "\n" in the first line.
> 
> You're right, my fault and a big one!
> 
> Anyway I'm going to ask some questions.

> There's nothing wrong with Dprintk or dprintk. I simply found a
> request to do so on the janitors TODO list. I found out that in
> kernel.h there was really a pr_debug macro and I used it.

ok. 

> The rationale is that in the kernel there are lots of custom dprintk,
> Dprintk, DPRINTK, etc that we need a bit of housekeeping, I think.
> Anyway I didn't like pr_info either (why not a pr_notice...?) but I
> used it: it was in kernel.h I assumed it was for good.

ok - pr_debug() is ok i think for the APIC code. It pairs well with the
other variants: pr_notice(), etc.

> I need a bit of advice now: should I forget about printks' levels,
> consistency and focus on other issues or with a bit of work these
> patches may became worth of?

i'd suggest to first do the Dprintk -> pr_debug replacement patch with
as few output changes as possible. (output changes are unavoidable when
converting a \n-less printout.) Then do any format cleanups in a
separate patch.

(some of your other comments about 'spurious' whitespaces need a
double-check too, sometimes they are done for formatting reasons. So
always take a look at the log output before changing it.)

	Ingo
