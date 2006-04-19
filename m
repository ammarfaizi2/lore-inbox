Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWDSMmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWDSMmN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 08:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWDSMmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 08:42:13 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:36230 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1750747AbWDSMmM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 08:42:12 -0400
Date: Wed, 19 Apr 2006 14:42:10 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Lee Revell <rlrevell@joe-job.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       "Robert M. Stockmann" <stock@stokkie.net>, linux-kernel@vger.kernel.org,
       Randy Dunlap <rddunlap@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andre Hedrick <andre@linux-ide.org>,
       Manfred Spraul <manfreds@colorfullife.com>, Alan Cox <alan@redhat.com>,
       Kamal Deen <kamal@kdeen.net>
Subject: Re: irqbalance mandatory on SMP kernels?
Message-ID: <20060419124210.GB24807@harddisk-recovery.com>
References: <Pine.LNX.4.44.0604171438490.14894-100000@hubble.stokkie.net> <4443A6D9.6040706@mbligh.org> <1145286094.16138.22.camel@mindpipe> <20060418163539.GB10933@thunk.org> <1145384357.2976.39.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145384357.2976.39.camel@laptopd505.fenrus.org>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2006 at 08:19:17PM +0200, Arjan van de Ven wrote:
> > but spreading IRQ's across all of the CPU's doesn't seem like it's
> > ever the right answer.
> 
> well it is in some cases, imagine having 2 cpus and 2 gige nics that are
> very busy doing webserving. That's an obvious case where 1-nic-per-cpu
> ends up doing the right thing... the way it ends up is that each nic has
> a full cpu for itself and it's own apaches... almost fully independent
> of the other one. Now if you moved both irqs to the same cpu, the
> apaches would follow, because if they didn't then you'd be bouncing
> their data *all the time*. And at that point the other cpu will become
> bored ;)

So what happens with a dual amd64 system where each CPU has its "own"
NIC? Something like this:


MEM0 <--> CPU0 <--- HT ---> CPU1 <--> MEM1
           ^                 ^
           |                 |
           HT                HT
           |                 |
           v                 v
      PCI bridge0      PCI1 bridge
           ^                 ^
           |                 |
          PCI               PCI
           |                 |
           v                 v
       GigE NIC0         GigE NIC1

The "best" approach would be to run an Apache on each CPU using local
memory and NIC and having the IRQs handled by the local CPU. Does the
irq balancer allow such a configuraion, or would it be hamperd by the
process scheduler deciding to run both Apaches on a single CPU?


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
