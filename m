Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbUJWU1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbUJWU1Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 16:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbUJWU1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 16:27:15 -0400
Received: from mx2.elte.hu ([157.181.151.9]:55170 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261173AbUJWUXt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 16:23:49 -0400
Date: Sat, 23 Oct 2004 22:24:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-U10.2
Message-ID: <20041023202451.GA24099@elte.hu>
References: <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041023185132.GA1268@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041023185132.GA1268@us.ibm.com>
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


* Paul E. McKenney <paulmck@us.ibm.com> wrote:

> o	In rcupdate.h, I believe that the:
> 
> 	+# define rcu_read_unlock_nort()                rcu_read_lock_nort()
> 
> 	should instead be:
> 
> 	+# define rcu_read_unlock_nort()                rcu_read_unlock()

yeah, correct - fortunately this is a non-default path, but still a nice
fix.

> o	The rcu_read_lock_spin(), rcu_read_lock_read(),
> 	rcu_read_lock_bh_read(), rcu_read_lock_sem(), and
> 	rcu_read_lock_bh_spin() APIs cannot be called recursively.
> 	But you probably already knew that.  ;-)
> 
> 	I don't understand why the rcu_read_lock_sem() API gets its
> 	own #ifdef.

actually, rcu_read_lock_read() is the variant that _can_ be called
recursively and which i used in the networking code quite extensively.
The others are only useful if the locking is 'flat' in the original
code, or if the locking is extensively rewritten. (I havent tried to
convert the IPC code back from the 'flat' locking to the original
'nested' locking, but i've done it for the networking code.)

> o	Some recent RCU patches acquire the update-side lock
> 	under rcu_read_lock(), which I believe will deadlock here.

which codepaths do you mean? Things are looking pretty good in -U10.3 so
far.

	Ingo
