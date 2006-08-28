Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbWH1TlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWH1TlT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 15:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWH1TlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 15:41:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13221 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751094AbWH1TlS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 15:41:18 -0400
Date: Mon, 28 Aug 2006 12:40:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: dipankar@in.ibm.com, Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Paul E McKenney <paulmck@us.ibm.com>
Subject: Re: [PATCH 0/4] RCU: various merge candidates
Message-Id: <20060828124058.cca5f5ab.akpm@osdl.org>
In-Reply-To: <20060828191642.GA32697@in.ibm.com>
References: <20060828160845.GB3325@in.ibm.com>
	<20060828120611.afad8b0f.akpm@osdl.org>
	<20060828191642.GA32697@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2006 00:46:42 +0530
Dipankar Sarma <dipankar@in.ibm.com> wrote:

> srcu (sleepable rcu) patches independent of the core RCU implementation
> changes in the patchset. You can queue these up either before
> or after srcu.
> 
> ...
>
> rcutorture fix patches independent of rcu implementation changes
> in this patchset.

So this patchset is largely orthogonal to the presently-queued stuff?
 
> > 
> > Now what?
> 
> Heh. I can always re-submit against -mm after I wait for a day or two
> for comments :)

That would be good, thanks.  We were seriously considering merging all the
SRCU stuff for 2.6.18, because
cpufreq-make-the-transition_notifier-chain-use-srcu.patch fixes a cpufreq
down()-in-irq-disabled warning at suspend time.

But that's a lot of new stuff just to fix a warning about something which
won't actually cause any misbehaviour.  We could just as well do

	if (irqs_disabled())
		down_read_trylock(...);	/* suspend */
	else
		down_read(...);

in cpufreq to temporarily shut the thing up.


