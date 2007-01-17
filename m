Return-Path: <linux-kernel-owner+w=401wt.eu-S932189AbXAQKD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbXAQKD6 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 05:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbXAQKD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 05:03:58 -0500
Received: from smtp.osdl.org ([65.172.181.24]:57138 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932189AbXAQKD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 05:03:57 -0500
Date: Wed, 17 Jan 2007 02:03:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [patch] fix emergency reboot: call reboot notifier list if
 possible
Message-Id: <20070117020343.8622e44d.akpm@osdl.org>
In-Reply-To: <20070117093917.GA7538@elte.hu>
References: <20070117091319.GA30036@elte.hu>
	<20070117092233.GA30197@flint.arm.linux.org.uk>
	<20070117093917.GA7538@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 17 Jan 2007 10:39:17 +0100 Ingo Molnar <mingo@elte.hu> wrote:
> 
> * Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> 
> > On Wed, Jan 17, 2007 at 10:13:19AM +0100, Ingo Molnar wrote:
> > > we dont call the reboot notifiers during emergency reboot mainly because 
> > > it could be called from atomic context and reboot notifiers are a 
> > > blocking notifier list. But actually the kernel is often perfectly 
> > > reschedulable in this stage, so we could as well process the 
> > > reboot_notifier_list.
> > 
> > My experience has been that when there has been the need to use this
> > facility, the kernel hasn't been reschedulable. [...]
> 
> this decision is totally automatic - so if your situation happens and 
> the kernel isnt reschedulable, then the notifier chain wont be called 
> and nothing changes from your perspective. Hm, perhaps this should be 
> dependent on CONFIG_PREEMPT, to make sure preempt_count() is reliable?
> 
> but from my perspective this patch fixes a real regression.
> 
> updated patch attached below.
> 

Making it dependent upon CONFIG_PREEMPT seems a bit sucky.  Perhaps pass in
some "you were called from /proc/sysrq-trigger" notification?

Also, there are ways of telling if the kernel has oopsed (oops counter,
oops_in_progress, etc) which should perhaps be tested.

Or just learn to type `reboot -fn' ;)

