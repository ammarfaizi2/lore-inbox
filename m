Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbVDIHIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVDIHIH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 03:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVDIHIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 03:08:07 -0400
Received: from mx1.elte.hu ([157.181.1.137]:21485 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261289AbVDIHIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 03:08:04 -0400
Date: Sat, 9 Apr 2005 09:07:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: davidm@hpl.hp.com
Cc: "Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: unlocked context-switches
Message-ID: <20050409070738.GA5444@elte.hu>
References: <3R6Ir-89Y-23@gated-at.bofh.it> <ugoecowjci.fsf@panda.mostang.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ugoecowjci.fsf@panda.mostang.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-2.223, required 5.9,
	BAYES_00 -4.90, SUBJ_HAS_UNIQ_ID 2.68
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* David Mosberger-Tang <David.Mosberger@acm.org> wrote:

>  > The ia64_switch_to() code includes a section that can change a
>  > pinned MMU mapping (when the stack for the new process is in a
>  > different granule from the stack for the old process).  The code
>  > beyond the ".map" label in arch/ia64/kernel/entry.S includes the
>  > comment:
> 
> Also, there was a nasty dead-lock that could trigger if the 
> context-switch was interrupted by a TLB flush IPI.  I don't remember 
> the details offhand, but I'm pretty sure it had to do with 
> switch_mm(), so I suspect it may not be enough to disable irqs just 
> for ia64_switch_to().  Tread with care!

we'll see. The patch certainly needs more testing. Generally we do 
switch_mm()'s outside of the scheduler as well, without disabling 
interrupts.

	Ingo
