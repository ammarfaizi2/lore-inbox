Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751490AbWGMHKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbWGMHKb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 03:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWGMHKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 03:10:31 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:61123 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751490AbWGMHKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 03:10:31 -0400
Date: Thu, 13 Jul 2006 09:04:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Albert Cahalan <acahalan@gmail.com>
Cc: torvalds@osdl.org, ak@suse.de, alan@lxorguk.ukuu.org.uk,
       arjan@infradead.org, bunk@stusta.de, akpm@osdl.org,
       rlrevell@joe-job.com, linux-kernel@vger.kernel.org,
       Roland McGrath <roland@redhat.com>
Subject: Re: utrace vs. ptrace
Message-ID: <20060713070445.GA30842@elte.hu>
References: <787b0d920607122243g24f5a003p1f004c9a1779f75c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <787b0d920607122243g24f5a003p1f004c9a1779f75c@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Albert Cahalan <acahalan@gmail.com> wrote:

> The utrace stuff offers some hope for eventually fixing this mess. 
> Please accept that or something similar.

yeah. Much of the API and usage problems of ptrace stem from its (mostly 
artificial) coupling to signals (and other, mostly historical baggage).

utrace gets rid of all of that baggage and artificial coupling! The 
utrace patchset first rips out all of ptrace (completely!), then adds 
utrace (which is in essence the CPU state fiddling bits of ptrace), then 
adds the ptrace API as an utrace module. It really doesnt get cleaner 
than that. See:

  http://people.redhat.com/roland/utrace/0-intro.txt

and:

  http://people.redhat.com/roland/utrace/

for the actual code.

utrace enables exciting things like a global crash-handling daemon that 
can collect live info from crashing (segfaulting) apps transparently, 
_without_ having all apps in the system ptraced in advance!

One of the biggest QA problems Linux has is that we very frequently lose 
information about the 'first incidence of crashing'. [Some of the GUIs 
have automatic crash-reporting, but those solutions are obviously 
limited to those GUIs and they dont use ptrace and have various 
shortcomings.]

utrace enables something like 'transparent live debugging': an app 
crashes in your distro, a window pops up, and you can 'hand over' a 
debugging session to a developer you trust. Or you can instruct the 
system to generate a coredump. Or you can generate a shorter summary of 
the crash, sent to a central site.

utrace enables the distro to automatically (and transparently) download 
debuginfo packages of an app that segfaults so that next time the crash 
happens there's better info to debug it - without the user having to 
bother about this.

utrace enables multiple debugging infrastructures being attached to the 
same task.

and last but not least, utrace enables the prototyping of debuging 
infrastructure without having to revamp the kernel APIs all the time.

Even if i wanted i couldnt over-hype utrace: it is by far the most 
important thing that happened to ptrace (and Linux debugging in general) 
in the past 10 years or so.

	Ingo
