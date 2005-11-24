Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbVKXTOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbVKXTOz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 14:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbVKXTOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 14:14:55 -0500
Received: from teetot.devrandom.net ([66.35.250.243]:62125 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S1750709AbVKXTOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 14:14:55 -0500
Date: Thu, 24 Nov 2005 11:16:36 -0800
From: thockin@hockin.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andi Kleen <ak@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Gerd Knorr <kraxel@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
Message-ID: <20051124191636.GC2468@hockin.org>
References: <p7364qjjhqx.fsf@verdi.suse.de> <1132764133.7268.51.camel@localhost.localdomain> <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain> <20051123165923.GJ20775@brahms.suse.de> <1132783243.13095.17.camel@localhost.localdomain> <20051124131310.GE20775@brahms.suse.de> <m1zmnugom7.fsf@ebiederm.dsl.xmission.com> <20051124133907.GG20775@brahms.suse.de> <m1u0e2gnab.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1u0e2gnab.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2005 at 06:58:52AM -0700, Eric W. Biederman wrote:
> > That's supposed to be done by hardware, no? 
> > At least the K8 has a hardware scrubber (although it's not always enabled)
> 
> Recent good implementations like the Opteron will do it for you.
> Older or cheaper memory controllers will not.

Beware of errata - there's at leats one errata on Opteron which forces you
to choose between x4 (chipkill) ECC and scrubber.  One or the other, but
not both.  There are plenty of errata on the scrubber alone.  Worse, if my
(brain)memory is correct, without the scrubber, correctable errors are
corrected on the fly, but never written back to DRAM.

> Having an architecturally sane software scrubber as backup for
> the hardware implementations is nice, and except in the cases
> where someone disables the lock prefix it is takes very little
> code on x86.
> 
> Even on the Opteron you could theoretically have the case of a brain-dead
> external memory controller, although that is not likely.
