Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbWC3HPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWC3HPv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 02:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWC3HPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 02:15:51 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:26298 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751203AbWC3HPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 02:15:50 -0500
Date: Thu, 30 Mar 2006 09:13:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: emin ak <eminak71@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rt10 crash on ppc
Message-ID: <20060330071322.GA3137@elte.hu>
References: <2cf1ee820603270656w6697778ai83935217ea5ab3a5@mail.gmail.com> <2cf1ee820603271231l69187925j3150098097c7ca15@mail.gmail.com> <44288FB3.5030208@yahoo.com.au> <20060329150815.GA24741@elte.hu> <442B4890.6000905@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442B4890.6000905@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Yes, that patch is basically what I had in mind.
> 
> Is -rt ever allocating memory from really-hard-don't-preempt-me 
> context? I guess not, unless the zone->lock is one of those locks too, 
> right?

no. zone->lock (and all the slab locks, and all the other MM locks) are 
fully preemptible too.

> Should you add a
> 
>  #else
>     BUG_ON(_really_dont_preempt_me());
>  #endif
> 
> just for safety, or will such misusage get caught elsewhere (eg. when 
> attempting to take zone->lock).

it should be caught immediately, by the cond_resched().

	Ingo
