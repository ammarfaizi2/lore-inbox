Return-Path: <linux-kernel-owner+w=401wt.eu-S932489AbXALK6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbXALK6T (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 05:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932666AbXALK6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 05:58:18 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:50637 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932489AbXALK6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 05:58:18 -0500
Date: Fri, 12 Jan 2007 11:19:31 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: kvm & dyntick
Message-ID: <20070112101931.GA11635@elte.hu>
References: <45A66106.5030608@qumranet.com> <20070112062006.GA32714@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070112062006.GA32714@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> > dyntick-enabled guest:
> > - reduce the load on the host when the guest is idling
> >   (currently an idle guest consumes a few percent cpu)
> 
> yeah. KVM under -rt already works with dynticks enabled on both the 
> host and the guest. (but it's more optimal to use a dedicated 
> hypercall to set the next guest-interrupt)

using the dynticks code from the -rt kernel makes the overhead of an 
idle guest go down by a factor of 10-15:

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 2556 mingo     15   0  598m 159m 157m R  1.5  8.0   0:26.20 qemu

( for this to work on my system i have added a 'hyper' clocksource 
  hypercall API for KVM guests to use - this is needed instead of the 
  running-to-slowly TSC. )

	Ingo
