Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264881AbUG2Qj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbUG2Qj1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 12:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264917AbUG2Qiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 12:38:55 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:40708 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S268301AbUG2QKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 12:10:20 -0400
Subject: Re: [Patch] Per kthread freezer flags
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: ncunningham@linuxmail.org
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1091103080.2703.6.camel@desktop.cunninghams>
References: <1090999301.8316.12.camel@laptop.cunninghams>
	 <20040728142026.79860177.akpm@osdl.org>
	 <1091053822.1844.4.camel@teapot.felipe-alfaro.com>
	 <1091054194.8867.26.camel@laptop.cunninghams>
	 <1091056916.1844.14.camel@teapot.felipe-alfaro.com>
	 <1091061983.8867.95.camel@laptop.cunninghams>
	 <1091095341.4359.0.camel@teapot.felipe-alfaro.com>
	 <1091103080.2703.6.camel@desktop.cunninghams>
Content-Type: text/plain
Date: Thu, 29 Jul 2004 18:10:07 +0200
Message-Id: <1091117407.2521.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 (1.5.91-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-29 at 22:11 +1000, Nigel Cunningham wrote:
> Hi.
> 
> On Thu, 2004-07-29 at 20:02, Felipe Alfaro Solana wrote:
> > > It doesn't look like I've touched any of those threads. I have doubts
> > > about irqd/0 (is that kirqd reworked?), so you might try making setting
> > > PF_NOFREEZE and seeing if it makes a difference. I haven't done the
> > > switch to rc2-mm1 yet, so haven't gotten to those issues.
> > 
> > kirqd is voluntary-preempt patch by Ingo Molnar. I have also applied
> > several other patches, like Con's Staircase scheduler policy and some
> > latency fixes.
> 
> Okay. So, just to make sure I understand you correctly, suspending works
> fine with all of these other patches added and adding the extra
> refrigerator calls breaks it. Are you at all able to narrow it down to a
> particular change?

Exactly! I'm currently running a highly patched kernel based on 2.6.8-
rc2-bk7 plus Con's work and Ingo's voluntary preempt. They work fine
when suspending to memory (S3) and to disk (S4 via swsusp), but adding
your kthread freezer flags to the mix keeps my CardBus NIC from being
recognized when resuming from S3: I need to unplug it, then plug it to
make it functional again.

However, I'm not sure what causes this behavior.

