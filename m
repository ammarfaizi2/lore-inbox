Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266139AbUHATyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266139AbUHATyw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 15:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266153AbUHATyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 15:54:52 -0400
Received: from mx1.elte.hu ([157.181.1.137]:44196 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266139AbUHATyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 15:54:50 -0400
Date: Sun, 1 Aug 2004 21:30:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, mingo@redhat.com,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: [patch] voluntary-preempt-2.6.8-rc2-O2
Message-ID: <20040801193043.GA20277@elte.hu>
References: <20040713143947.GG21066@holomorphy.com> <1090732537.738.2.camel@mindpipe> <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040729222657.GA10449@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


here's the latest version of the voluntary-preempt patch:
  
  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-O2

this patch is mainly a stabilization effort. I dropped the irq-threads
code added in -M5 and rewrote it from scratch based on -L2 - it is
simpler and should be more robust.

The same /proc/irq/* configuration switches are still present, but i
added the following additional rule: if _any_ handler of a given IRQ is
marked as non-threaded then all handlers will be executed non-threaded
as well.

E.g. if you have the following handlers on IRQ 10:

 10:      11584   IO-APIC-level  eth0, eth1, eth2

and you change /proc/irq/16/eth1/threaded from 1 to 0 then the eth0 and
eth2 handlers will be executed non-threaded as well. (This rule only
enforces what the hardware enforces anyway, none of the previous patches
allowed true separation of these handlers.)

i also changed the IO-APIC level-triggered code to be robust when
redirection is done. The noapic workaround should not be necessary
anymore.

the keyboard lockups are now hopefully all gone too - i've tested
IO-APIC and non-IO-APIC setups as well and NumLock/ScrollLock works fine
in all sorts of workloads.

Let me know if you still have any problems.

	Ingo
