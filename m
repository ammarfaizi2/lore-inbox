Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751481AbWIALRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbWIALRy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 07:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWIALRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 07:17:54 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:39875 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751481AbWIALRx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 07:17:53 -0400
Date: Fri, 1 Sep 2006 13:10:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Steven Whitehouse <swhiteho@redhat.com>, linux-kernel@vger.kernel.org,
       Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, hch@infradead.org
Subject: Re: [PATCH 02/16] GFS2: Core locking interface
Message-ID: <20060901111004.GA8517@elte.hu>
References: <1157030977.3384.786.camel@quoit.chygwyn.com> <Pine.LNX.4.61.0609010852470.25521@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0609010852470.25521@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

> I suppose so. If they were initialized statically, this function could 
> possibly be dropped.
> 
> >+typedef void lm_lockspace_t;
> >+typedef void lm_lock_t;
> >+typedef void lm_fsdata_t;
> 
> Try to avoid typedefs for
> - simple types like these (int/void/etc.)
> - structures

yeah. If we dont want to expose a type externally, we forward declare 
the structure, and pointers to it can then be used and passed around. 
That's also more type-safe (and obviously more readable) than a typedef 
to void.

> >+		error = glock_wait_internal(gh);
> >+		if (error == GLR_CANCELED) {
> >+			msleep(100);
> 
> msleep is a busy-waiter IIRC. Really want to do that - what about some 
> schedulling?

no. mdelay() is the busy-waiter - msleep() is scheduling based.

> >+			borked = 1;
> >+			serious = error;
> 
> This got me a laugh :)

me too - the hidden joys of code review :-)

	Ingo
