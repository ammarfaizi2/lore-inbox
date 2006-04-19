Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWDSOX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWDSOX3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 10:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWDSOX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 10:23:28 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:46513 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750786AbWDSOX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 10:23:28 -0400
Subject: Re: irqbalance mandatory on SMP kernels?
From: Arjan van de Ven <arjan@infradead.org>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Lee Revell <rlrevell@joe-job.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       "Robert M. Stockmann" <stock@stokkie.net>, linux-kernel@vger.kernel.org,
       Randy Dunlap <rddunlap@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andre Hedrick <andre@linux-ide.org>,
       Manfred Spraul <manfreds@colorfullife.com>, Alan Cox <alan@redhat.com>,
       Kamal Deen <kamal@kdeen.net>
In-Reply-To: <20060419124210.GB24807@harddisk-recovery.com>
References: <Pine.LNX.4.44.0604171438490.14894-100000@hubble.stokkie.net>
	 <4443A6D9.6040706@mbligh.org> <1145286094.16138.22.camel@mindpipe>
	 <20060418163539.GB10933@thunk.org>
	 <1145384357.2976.39.camel@laptopd505.fenrus.org>
	 <20060419124210.GB24807@harddisk-recovery.com>
Content-Type: text/plain
Date: Wed, 19 Apr 2006 16:23:14 +0200
Message-Id: <1145456594.3085.42.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-19 at 14:42 +0200, Erik Mouw wrote:
> On Tue, Apr 18, 2006 at 08:19:17PM +0200, Arjan van de Ven wrote:
> > > but spreading IRQ's across all of the CPU's doesn't seem like it's
> > > ever the right answer.
> > 
> > well it is in some cases, imagine having 2 cpus and 2 gige nics that are
> > very busy doing webserving. That's an obvious case where 1-nic-per-cpu
> > ends up doing the right thing... the way it ends up is that each nic has
> > a full cpu for itself and it's own apaches... almost fully independent
> > of the other one. Now if you moved both irqs to the same cpu, the
> > apaches would follow, because if they didn't then you'd be bouncing
> > their data *all the time*. And at that point the other cpu will become
> > bored ;)
> 
> So what happens with a dual amd64 system where each CPU has its "own"
> NIC? Something like this:

as long as the irqs are spread the apaches will (on average) follow your
irq to the right cpu. Only if you put both irqs on the same cpu you have
an issue


