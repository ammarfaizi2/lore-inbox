Return-Path: <linux-kernel-owner+w=401wt.eu-S1160995AbXALGYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160995AbXALGYi (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 01:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161005AbXALGYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 01:24:37 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:41727 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1160995AbXALGYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 01:24:36 -0500
Date: Fri, 12 Jan 2007 07:20:07 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: kvm & dyntick
Message-ID: <20070112062006.GA32714@elte.hu>
References: <45A66106.5030608@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45A66106.5030608@qumranet.com>
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


* Avi Kivity <avi@qumranet.com> wrote:

> It occurs to me that kvm could benefit greatly from dyntick:
> 
> dyntick-enabled host:
> - generate virtual interrupts at whatever HZ the guest programs its 
> timers, be it 100, 250, 1000 or whatever
> - avoid expensive vmexits due to useless timer interrupts
> 
> dyntick-enabled guest:
> - reduce the load on the host when the guest is idling
>   (currently an idle guest consumes a few percent cpu)

yeah. KVM under -rt already works with dynticks enabled on both the host 
and the guest. (but it's more optimal to use a dedicated hypercall to 
set the next guest-interrupt)

> What are the current plans wrt dyntick?  Is it planned for 2.6.21?

yeah, we hope to have it in v2.6.21.

note that s390 (and more recently Xen too) uses a next_timer_interrupt() 
based method to stop the guest tick - which works in terms of reducing 
guest load, but it doesnt stop the host-side interrupt. The highest 
quality approach is to have dynticks on both the host and the guest, and 
this also gives high-resolution timers and a modernized 
time/timer-events subsystem for both the host and the guest.

	Ingo
