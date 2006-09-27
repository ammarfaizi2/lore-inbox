Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965460AbWI0JNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965460AbWI0JNs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 05:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965461AbWI0JNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 05:13:48 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:7071 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965460AbWI0JNr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 05:13:47 -0400
Date: Wed, 27 Sep 2006 11:05:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>, John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] move put_task_struct() reaping into a thread [Re: 2.6.18-rt1]
Message-ID: <20060927090524.GA20395@elte.hu>
References: <20060920141907.GA30765@elte.hu> <20060921065624.GA9841@gnuppy.monkey.org> <m1irjaqaqa.fsf@ebiederm.dsl.xmission.com> <20060927050856.GA16140@gnuppy.monkey.org> <m11wpxrgnm.fsf@ebiederm.dsl.xmission.com> <20060927063415.GB16140@gnuppy.monkey.org> <m1d59hpy1j.fsf@ebiederm.dsl.xmission.com> <20060927090939.GA17136@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060927090939.GA17136@gnuppy.monkey.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4999]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Bill Huey <billh@gnuppy.monkey.org> wrote:

> > more than just changing locking behavior.  Which is what brought me 
> > into this conversation in the first place.  So removing that point 
> > of discord would be good.
> 
> Yes, there are few places. It was primarily to handle the reaping 
> during the finishing parts of a fork. All in all, it's not at all a 
> critical path.

no. It was primarily to move the put_task_struct() off the 
context-switch fastpath. (In comparison the fork use is much rarer)

	Ingo
