Return-Path: <linux-kernel-owner+w=401wt.eu-S964836AbWLULUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWLULUJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 06:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbWLULUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 06:20:09 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:42042 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964836AbWLULUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 06:20:07 -0500
Date: Thu, 21 Dec 2006 12:15:33 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] x86_64: fix boot hang caused by CALGARY_IOMMU_ENABLED_BY_DEFAULT
Message-ID: <20061221111533.GA31433@elte.hu>
References: <20061220102846.GA17139@elte.hu> <20061220113052.GA30145@rhun.ibm.com> <20061220162338.GC11804@elte.hu> <20061220180953.GM30145@rhun.ibm.com> <20061221103702.GA19451@elte.hu> <20061221110914.GY30145@rhun.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061221110914.GY30145@rhun.ibm.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Muli Ben-Yehuda <muli@il.ibm.com> wrote:

> > but i still /strongly/ disagree with your attitude that mainline is 
> > 'experimental' and hence there's nothing to see here, move over.
> 
> We can agree to disagree about how "experimental" mainline should be. 
> [...]

there's not much to disagree about. Mainline early bootup _must not 
break_, and if it breaks, it must be easy for the tester to figure it 
out. Simple as that. If it ever breaks and the user cannot give us other 
feedback but: "my laptop hung", we screwed up the process!

once the system has booted up into a minimal state, up to the stage 
where say netconsole works, we've got an exponentially increasing number 
of measures to find /all the other bugs/. But early bootup is like 
sacred. It's not experimental at all. Really. Having a system that 
doesnt even boot and gives no feedback at all is an absolute showstopper 
and a lost tester to us.

if we need draconian measures such as having two versions of early 
bootup code present in the kernel and a runtime boot switch to trigger 
between the old-trusted and the new-unknown one [perhaps even 
automatically, via the help of Grub] then so it be - but we cannot 
tolerate hung bootups.

	Ingo
