Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965203AbWEaWM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965203AbWEaWM1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 18:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965204AbWEaWM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 18:12:27 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:21436 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965203AbWEaWM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 18:12:26 -0400
Date: Thu, 1 Jun 2006 00:12:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Andrew Morton <akpm@osdl.org>, Martin Bligh <mbligh@google.com>,
       linux-kernel@vger.kernel.org, apw@shadowen.org
Subject: Re: 2.6.17-rc5-mm1
Message-ID: <20060531221242.GA5269@elte.hu>
References: <447DEF47.6010908@google.com> <20060531140823.580dbece.akpm@osdl.org> <20060531211530.GA2716@elte.hu> <447E0A49.4050105@mbligh.org> <20060531213340.GA3535@elte.hu> <447E0DEC.60203@mbligh.org> <20060531215315.GB4059@elte.hu> <447E11B5.7030203@mbligh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447E11B5.7030203@mbligh.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5002]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Martin J. Bligh <mbligh@mbligh.org> wrote:

> >but ... i fixed the performance problem that caused the previous 
> >DEBUG_MUTEXES scalability problems. (there's no global mutex list 
> >anymore) We also default to e.g. DEBUG_SLAB which is alot more costly.
> 
> OK. So what's the perf impact of the new version on a 32 cpu machine? 
> ;-) Maybe it's fine, maybe it's not.

no idea, but it shouldnt be nearly as bad as say SLAB_DEBUG.

> >i'm wondering, why doesnt your config have DEBUG_MUTEXES disabled? Then 
> >'make oldconfig' would pick it up automatically.
> 
> Because it builds off the same config file all the time. It was 
> created before CONFIG_MUTEXES existed ... creating a situation where 
> we have to explicitly disable new options all the time becomes a 
> maintainance nightmare ;-(

hm, why? Dont you disable DEBUG_SLAB? [that's a default y option too, 
and in your config it's disabled]

a oneliner script:

 sed -i 's/CONFIG_MUTEX_DEBUGGING=y/# CONFIG_MUTEX_DEBUGGING is not set'

ought to do it, unless i'm missing something.

Really, there's an unfortunate friction of interests here:

on one side, the -mm kernel is about showcasing new code and finding 
bugs in them as fast as possible. Having new debugging options enabled 
by default is an important part of the testing effort. Users will care 
more about having no crashes than about having 0.5% more performance in 
select benchmarks.

on the other side, you obviously dont want a 0.5% overhead for select 
benchmarks, as that would mess up the history! A very fair and valid 
position too.

but one side has to give, we cant have both.

> If we don't want to do performance regression checking on -mm, that's 
> fine, but I thought it was useful (has caught several things already).

please dont misunderstand my position as being against your efforts - to 
the contrary, your performance regression testing has proven to be 
valuable numerous times! But you are a single intelligent person whom i 
can possibly talk into adding some scripting to ensure that certain 
options stay off in the .config - but i cannot cat-herd the many -mm 
testers on the other hand to all enable the debug options ;-) So i'm 
kind of forced trying to convince you - i cannot convince the basic 
human testing nature of keeping the defaults ;-)

	Ingo
