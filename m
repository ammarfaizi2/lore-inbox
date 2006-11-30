Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030567AbWK3Poi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030567AbWK3Poi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 10:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030572AbWK3Poi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 10:44:38 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:14728 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030567AbWK3Poh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 10:44:37 -0500
Date: Thu, 30 Nov 2006 16:44:25 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>, Avi Kivity <avi@qumranet.com>,
       kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH 1/38] KVM: Create kvm-intel.ko module
Message-ID: <20061130154425.GB28507@elte.hu>
References: <456AD5C6.1090406@qumranet.com> <20061127121136.DC69A25015E@cleopatra.q> <20061127123606.GA11825@elte.hu> <20061130142435.GA13372@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061130142435.GA13372@infradead.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -4.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.4 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Hellwig <hch@infradead.org> wrote:

> > please move this from drivers/kvm/ to kernel/kvm/ [or even into a 
> > toplevel kvm/ directory] - KVM is not a "driver", KVM enhances the 
> > core Linux kernel with hypervisor functionality.
> 
> Actually it's exactly a driver.  It's a character driver that exposes 
> the virtualization features of modern x86 hardware. [...]

you are fundamentally wrong. In the end KVM is a fundamental and complex 
infrastructure that enables Linux to provide full hardware capabilities 
to another OS via the resources of this OS. This concept justifies a 
system call and a place in linux/kernel/. It's not fundamentally limited 
to x86 either. Full virtualization (and paravirtualization) makes sense 
on any platform. And there's no reason KVM be limited to full 
virtualization alone - both paravirtualization and accelerated guest 
drivers need a sane hypercall API.

> [...] Pretty similar to things like the msr or mtrr driver that expose 
> cpu features as character drivers aswell.

you can expose everything as character drivers and ioctls, but that 
doesnt make it the right solution. It might /start out/ as a driver, 
because that's an easy to hack model, but the moment something becomes 
important enough (and virtualization certainly is such a model) it 
demands a system call.

Just like inotify started out as an ioctl hack, but then was 
(rightfully) moved to the system-call space. [ Which btw. was on your 
request ;-) ]

	Ingo
