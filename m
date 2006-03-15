Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWCOW1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWCOW1E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 17:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbWCOW1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 17:27:04 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:34188 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932090AbWCOW1B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 17:27:01 -0500
Date: Wed, 15 Mar 2006 23:24:41 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jeff Garzik <jeff@garzik.org>
Cc: Lee Revell <rlrevell@joe-job.com>,
       "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Andi Kleen <ak@suse.de>, Jason Baron <jbaron@redhat.com>,
       linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
Subject: Re: libata/sata_nv latency on NVIDIA CK804 [was Re: AMD64 X2 lost ticks on PM timer]
Message-ID: <20060315222441.GA24074@elte.hu>
References: <200602280022.40769.darkray@ic3man.com> <4408BEB5.7000407@garzik.org> <20060303234330.GA14401@ti64.telemetry-investments.com> <200603040107.27639.ak@suse.de> <20060315213638.GA17817@ti64.telemetry-investments.com> <1142459152.1671.64.camel@mindpipe> <20060315215848.GB18241@elte.hu> <441893AB.1070300@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <441893AB.1070300@garzik.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.8 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jeff Garzik <jeff@garzik.org> wrote:

> Ingo Molnar wrote:
> >in this particular case there's only very simple (and non-IO) 
> >instructions in that codepath (no loops either), except for 
> >ata_bmdma_status() which does IO ops: so i agree with you that the most 
> >likely candidate for the delay is the readb() or the inb() in 
> >ata_bdma_status().
> >
> >I'm wondering which one of the two. inb()s are known to be horrible on 
> >some systems - but i've never seen them take 16 milliseconds. If it's 
> >the inb(), then that could also involve SMM mode and IO 
> 
> 
> ata_bmdma_status() is just a single IO read, and even 1ms is highly 
> improbable.

well, it's a PIO inb() op i think, and could thus in theory trigger SMM 
BIOS code.

> I'd look elsewhere.  There are a ton of udelay() calls in the legacy 
> PCI IDE BMDMA code paths (sata_nv uses these), so I'm not surprised 
> there is latency in general, in a libata+sata_nv configuration. [...]

they would show up in the latency trace ... the latency trace is very 
clear, and in the previous mail i described the precise codepath where 
we observed the latency. Only that single PIO read is there AFAICS.
  
	Ingo
