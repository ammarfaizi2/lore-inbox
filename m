Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265857AbUE1Hh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265857AbUE1Hh0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 03:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263040AbUE1Hh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 03:37:26 -0400
Received: from mx1.elte.hu ([157.181.1.137]:32216 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265864AbUE1Hg5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 03:36:57 -0400
Date: Fri, 28 May 2004 09:38:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [3/4] [PATCH]Diskdump - yet another crash dump function
Message-ID: <20040528073814.GA11289@elte.hu>
References: <20pwP-55v-5@gated-at.bofh.it> <20suK-7C5-11@gated-at.bofh.it> <20tAB-5c-31@gated-at.bofh.it> <20AiB-69m-17@gated-at.bofh.it> <m34qq1v9p6.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m34qq1v9p6.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@muc.de> wrote:

> > yeah, this is arguably the biggest (and i think only) conceptual item
> > that needs to be solved before this can be integrated.
> 
> I would think netdump is more important than this though (so if
> anything should be integrated i would start with netdump)

i think both are important. Dumping to disks is a frequent customer
request, and not all setups can dump to a network, for performance,
security or reliability reasons. The diskdump format is the same as the
netdump format, and can be handled/analyzed by the same userspace tools,
so in this sense it's an extension of netdump to another class of IO
devices.

> > it would also be easier to enable diskdump in a driver if this was
> > handled in add_timer()/del_timer()/mod_timer()/tasklet_schedule().
> 
> I don't think it's a good idea to add this to these fast paths. Timers
> are critical for lots of things, tasklet_schedule too.
> 
> How about a standard wrapper that does the check and everybody who may
> need that uses the wrappers ?

that's what the patch does currently. It needs to be decided one way or
another. But it doesnt make alot of sense to introduce another vector of
APIs for this purpose - it would need possibly wide driver changes for
no good reason.

	Ingo
