Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261639AbULIWK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbULIWK6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 17:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbULIWK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 17:10:58 -0500
Received: from mx2.elte.hu ([157.181.151.9]:43700 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261639AbULIWKs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 17:10:48 -0500
Date: Thu, 9 Dec 2004 23:10:21 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       "K.R. Foley" <kr@cybsft.com>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>, emann@mrv.com,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-12
Message-ID: <20041209221021.GF14194@elte.hu>
References: <20041207141123.GA12025@elte.hu> <1102526018.25841.308.camel@localhost.localdomain> <32950.192.168.1.5.1102529664.squirrel@192.168.1.5> <1102532625.25841.327.camel@localhost.localdomain> <32788.192.168.1.5.1102541960.squirrel@192.168.1.5> <1102543904.25841.356.camel@localhost.localdomain> <20041209093211.GC14516@elte.hu> <20041209131317.GA31573@elte.hu> <1102602829.25841.393.camel@localhost.localdomain> <1102619992.3882.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102619992.3882.9.camel@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> This looks like it was triggered by bounce_copy_vec calling
> kmap_atomic which is now just kmap with irqs disabled.  Does this need
> to change to __kmap_atomic?  Is this also used to make things more
> preemptible, and start removing the local_irq_saves?  I'd like to know
> so that you don't need to make the patches yourself and I can handle
> things like this, but I need to know what the general ideas are. 
> Also, am I the only one that has highmem support enabled, because this
> looks like this bug would have been triggered by anyone.

the fix would be to find the place that disabled interrupts, and to
check that it's safe to change it to local_irq_disable_nort() (or
whatever other variant is used). Usually it's safe.

	Ingo
