Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270530AbUKBAXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270530AbUKBAXl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 19:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265486AbUKBAXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 19:23:39 -0500
Received: from tron.kn.vutbr.cz ([147.229.191.152]:49924 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S266359AbUKBAWw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 19:22:52 -0500
Message-ID: <4186D332.6090600@stud.feec.vutbr.cz>
Date: Tue, 02 Nov 2004 01:22:10 +0100
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Florian Schmidt <mista.tapas@gmx.net>, Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
References: <20041031120721.GA19450@elte.hu> <20041031124828.GA22008@elte.hu> <1099227269.1459.45.camel@krustophenia.net> <20041031131318.GA23437@elte.hu> <20041031134016.GA24645@elte.hu> <20041031162059.1a3dd9eb@mango.fruits.de> <20041031165913.2d0ad21e@mango.fruits.de> <20041031200621.212ee044@mango.fruits.de> <20041101134235.GA18009@elte.hu> <20041101135358.GA19718@elte.hu> <20041101140630.GA20448@elte.hu>
In-Reply-To: <20041101140630.GA20448@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  identified this incoming email as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-4.2 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0000]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is after "modprobe -r uhci-hcd" on -V0.6.5:

BUG: sleeping function called from invalid context rmmod(5093) at 
kernel/mutex.c:30
in_atomic():1 [00000001], irqs_disabled():1
  [<c01060d3>] dump_stack+0x23/0x30 (20)
  [<c011b2e2>] __might_sleep+0xc2/0xe0 (36)
  [<c0134d78>] __mutex_lock+0x38/0x50 (24)
  [<c0134dad>] _mutex_lock+0x1d/0x20 (16)
  [<c01482c4>] do_drain+0x24/0x60 (32)
  [<c0148269>] smp_call_function_all_cpus+0x29/0x60 (28)
  [<c0148327>] drain_cpu_caches+0x27/0x60 (28)
  [<c014837c>] __cache_shrink+0x1c/0x100 (36)
  [<c014855d>] kmem_cache_destroy+0x9d/0x190 (28)
  [<f8a40e24>] uhci_hcd_cleanup+0x24/0x67 [uhci_hcd] (16)
  [<c0138c40>] sys_delete_module+0x120/0x150 (96)
  [<c0105293>] syscall_call+0x7/0xb (-8124)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c0148263>] .... smp_call_function_all_cpus+0x23/0x60
.....[<c0148327>] ..   ( <= drain_cpu_caches+0x27/0x60)
.. [<c0136b0d>] .... print_traces+0x1d/0x90
.....[<c01060d3>] ..   ( <= dump_stack+0x23/0x30)


Michal
