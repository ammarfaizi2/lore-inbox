Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262861AbVCWIAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbVCWIAJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 03:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVCWH7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 02:59:45 -0500
Received: from mx1.elte.hu ([157.181.1.137]:57044 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261233AbVCWH7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 02:59:21 -0500
Date: Wed, 23 Mar 2005 08:58:54 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, linux-kernel@vger.kernel.org,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
Message-ID: <20050323075854.GA4348@elte.hu>
References: <20050322054345.GB1296@us.ibm.com> <20050322072413.GA6149@elte.hu> <20050322092331.GA21465@elte.hu> <20050322093201.GA21945@elte.hu> <20050322100153.GA23143@elte.hu> <20050322112856.GA25129@elte.hu> <20050323061601.GE1294@us.ibm.com> <20050323063317.GB31626@elte.hu> <20050323071604.GA32712@elte.hu> <Pine.LNX.4.58.0503230251180.13140@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503230251180.13140@localhost.localdomain>
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

> > i think the 'migrate read-count' method is not adequate either, because
> > all callbacks queued within an RCU read section must be called after the
> > lock has been dropped - while with the migration method CPU#1 would be
> > free to process callbacks queued in the RCU read section still active on
> > CPU#2.
> 
> Although you can't disable preemption for the duration of the
> rcu_readlock, what about pinning the process to a CPU while it has the
> lock.  Would this help solve the migration issue?

yes, but that's rather gross. PREEMPT_BKL was opposed by Linus precisely
because it used such a method - once that was fixed, PREEMPT_BKL got
accepted. It also limits the execution flow quite much. I'd rather not
do it if there's any other method.

	Ingo
