Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760344AbWLFJIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760344AbWLFJIE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 04:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760348AbWLFJIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 04:08:04 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:33186 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760347AbWLFJIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 04:08:01 -0500
Date: Wed, 6 Dec 2006 10:07:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jiri Kosina <jikos@jikos.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] let WARN_ON() output the condition
Message-ID: <20061206090715.GA30931@elte.hu>
References: <Pine.LNX.4.64.0612060149220.28502@twin.jikos.cz> <20061206083730.GB24851@elte.hu> <Pine.LNX.4.64.0612060940130.28502@twin.jikos.cz> <20061206085428.GA28160@elte.hu> <Pine.LNX.4.64.0612060957180.28502@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612060957180.28502@twin.jikos.cz>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -4.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.4 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jiri Kosina <jikos@jikos.cz> wrote:

> > but i agree with you in theory that your proposed output is better, but 
> > the side-effect issue is a killer i think. Could you try to rework it to 
> > not evaluate the condition twice and to make it dependent on 
> > CONFIG_DEBUG_BUGVERBOSE? You can avoid the evaluation side-effect issue 
> > by doing something like:
> > 	int __c = (c);							\
> >                                                                         \
> >         if (unlikely(__c)) {                                            \
> >                 if (debug_locks_off())                                  \
> >                         WARN_ON(__c);                                   \
> >                 __ret = 1;                                              \
> > 
> 
> Yep, making it dependent on CONFIG_DEBUG_BUGVERBOSE makes sense. 
> Andrew, will you take such patch? (when I also fix the 
> evaluating-twice issue).

i'll probably ack such a patch, it can be useful even when the line 
number is unique: if someone reports a WARN_ON() from an old kernel i 
dont have to dig up the exact source but can see it right from the 
condition what happened. Useful redundancy in bug output can be quite 
useful at times. Please post it and we'll see whether it's acceptable.

	Ingo
