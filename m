Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264027AbUKZVOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264027AbUKZVOP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 16:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264047AbUKZUpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 15:45:54 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:9128 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S264137AbUKZU2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 15:28:47 -0500
Subject: Re: Suspend 2 merge: 17/51: Disable MCE checking during suspend.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041125223155.GB2711@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101295216.5805.256.camel@desktop.cunninghams>
	 <20041125181954.GG1417@openzaurus.ucw.cz>
	 <1101420341.27250.58.camel@desktop.cunninghams>
	 <20041125223155.GB2711@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1101422304.27250.97.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 26 Nov 2004 09:38:24 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-11-26 at 09:31, Pavel Machek wrote:
> Hi!
> 
> > > > Avoid a potential SMP deadlock here.
> > > 
> > > ..and loose MCE report.
> > 
> > Deadlock or get an MCE report and do a printk when we're shutting down
> > anyway?
> 
> If MCE happens, I'd like user to report it. Loosing it is wrong,
> deadlocking may be actually better because at least you get the
> report. I'd BUG(). 
> 
> MCEs are hardware problem, right? They should not be common.

It's not them occurring that's the problem, it's checking for them that
involves an SMP call :<

> static void mce_work_fn(void *data)
> {
>         if (!test_suspend_state(SUSPEND_RUNNING))
>                 on_each_cpu(mce_checkregs, NULL, 1, 1);
>         schedule_delayed_work(&mce_work, MCE_RATE);
> }

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

