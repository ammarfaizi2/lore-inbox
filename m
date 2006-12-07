Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163392AbWLGVU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163392AbWLGVU4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 16:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163390AbWLGVU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 16:20:56 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52819 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163389AbWLGVUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 16:20:55 -0500
Subject: Re: v2.6.19-rt6, yum/rpm
From: Arjan van de Ven <arjan@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
       Mike Galbraith <efault@gmx.de>, Clark Williams <williams@redhat.com>,
       Sergei Shtylyov <sshtylyov@ru.mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Giandomenico De Tullio <ghisha@email.it>
In-Reply-To: <20061207205819.GA21953@elte.hu>
References: <20061205171114.GA25926@elte.hu>
	 <1165524358.9244.33.camel@cmn3.stanford.edu>
	 <20061207205819.GA21953@elte.hu>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 07 Dec 2006 22:20:45 +0100
Message-Id: <1165526445.27217.59.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-07 at 21:58 +0100, Ingo Molnar wrote:
> * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> 
> > Much better performance in terms of xruns with Jackd. Hardly any at 
> > all as it should be. I'm starting to test -rt8 right now.
> > 
> > Now, I still don't have an smp machine to test so the improvement 
> > could be because I'm just running 64 bit up instead of smp. Or it 
> > could have been the hardware on that other machine that had some 
> > problem (either because it was starting to fail or because the kernel 
> > drivers for that hardware were somehow triggering the xruns).
> 
> i think it's the UP vs. SMP difference. We are chasing some SMP 
> latencies right now that trigger on boxes that have deeper C sleep 
> states. idle=poll seems to work around those problems.

well C-states do cause latencies... as advertized in
the /proc/acpi/processor/CPU0/power file.

You can prevent linux from going into c-states that just take too long,
by setting the latency you can tolerate via the
set_acceptable_latency(). You can see the active maximum latency via the
same power file...

(right now audio playback is the main user of this api; of other parts
should use it too lets talk about it)


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

