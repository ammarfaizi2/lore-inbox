Return-Path: <linux-kernel-owner+w=401wt.eu-S1751188AbXANIo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbXANIo3 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 03:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbXANIo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 03:44:28 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:47994 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751188AbXANIo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 03:44:28 -0500
Date: Sun, 14 Jan 2007 09:39:54 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: kvm & dyntick
Message-ID: <20070114083954.GB2913@elte.hu>
References: <45A66106.5030608@qumranet.com> <20070112062006.GA32714@elte.hu> <20070112101931.GA11635@elte.hu> <45A7BF9F.5090508@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45A7BF9F.5090508@qumranet.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Avi Kivity <avi@qumranet.com> wrote:

> >( for this to work on my system i have added a 'hyper' clocksource
> >  hypercall API for KVM guests to use - this is needed instead of the 
> >  running-to-slowly TSC. )
> >  
> 
> What's the problem with the TSC?  The only issue I'm aware of is that 
> the tsc might go backwards if the vcpu is migrated to another host cpu 
> (easily fixed).

this is not a problem of KVM - this is a problem of this laptop: its TSC 
stops when going idle. So the TSC is fundamentally unusable for reliable 
timekeeping - and qemu doesnt offer pmtimer emulation to fall back to, 
so the dyntick kernel refused to go high-res under KVM. Once i added the 
hyper clocksource to fall back to, it could utilize the PIT and the 
lapic for clock-events.

	Ingo
