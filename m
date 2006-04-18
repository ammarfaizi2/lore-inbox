Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWDRSTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWDRSTa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 14:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWDRSTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 14:19:30 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:13703 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750750AbWDRST3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 14:19:29 -0400
Subject: Re: irqbalance mandatory on SMP kernels?
From: Arjan van de Ven <arjan@infradead.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Lee Revell <rlrevell@joe-job.com>, "Martin J. Bligh" <mbligh@mbligh.org>,
       "Robert M. Stockmann" <stock@stokkie.net>, linux-kernel@vger.kernel.org,
       Randy Dunlap <rddunlap@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andre Hedrick <andre@linux-ide.org>,
       Manfred Spraul <manfreds@colorfullife.com>, Alan Cox <alan@redhat.com>,
       Kamal Deen <kamal@kdeen.net>
In-Reply-To: <20060418163539.GB10933@thunk.org>
References: <Pine.LNX.4.44.0604171438490.14894-100000@hubble.stokkie.net>
	 <4443A6D9.6040706@mbligh.org> <1145286094.16138.22.camel@mindpipe>
	 <20060418163539.GB10933@thunk.org>
Content-Type: text/plain
Date: Tue, 18 Apr 2006 20:19:17 +0200
Message-Id: <1145384357.2976.39.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Which brings up an interesting question --- why do we have an IRQ
> balancer in the kernel at all?  

good question; at least RHEL disables it and uses the userspace one
(which only decides to change the balance at most every 10 seconds, but
has a strong tendency to leave the irqs as they are)

> but spreading IRQ's across all of the CPU's doesn't seem like it's
> ever the right answer.

well it is in some cases, imagine having 2 cpus and 2 gige nics that are
very busy doing webserving. That's an obvious case where 1-nic-per-cpu
ends up doing the right thing... the way it ends up is that each nic has
a full cpu for itself and it's own apaches... almost fully independent
of the other one. Now if you moved both irqs to the same cpu, the
apaches would follow, because if they didn't then you'd be bouncing
their data *all the time*. And at that point the other cpu will become
bored ;)

This is what the userspace irqbalance has in its policy more or less:
spread the irqs within the same class to different processors. And as
secondary policy it tries to spread it out a bit, but that's only
secondary.


