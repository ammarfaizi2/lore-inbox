Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbVCaNdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVCaNdf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 08:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbVCaNdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 08:33:35 -0500
Received: from mx1.elte.hu ([157.181.1.137]:55494 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261438AbVCaNdd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 08:33:33 -0500
Date: Thu, 31 Mar 2005 15:33:25 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Esben Nielsen <simlo@phys.au.dk>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
Message-ID: <20050331133325.GA31903@elte.hu>
References: <Pine.OSF.4.05.10503311301210.11827-100000@da410.phys.au.dk> <1112271270.3691.209.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112271270.3691.209.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
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

> > I was going to say the opposit. I know that there are many more rt_locks
> > locks around and the fields thus will take more memory when put there but
> > I believe it is more logical to have the fields there.
> 
> It seems logical to be there, but in practicality, it's not.
> 
> The problem is that the flags represent a state of the task with 
> respect to a single lock.  When the task loses ownership of a lock, 
> the state of the task changes. But the the lock has a different state 
> at that moment (it has a new onwner).  Now when it releases the lock, 
> it might give the lock to another task, and that becomes the pending 
> owner. Now the state of the lock is the same as in the beginning. But 
> the first task needs to see this change.
> 
> You can still pull this off by testing the state of the lock and 
> compare it to the current owner, but I too like the fact that you 
> don't increase the size of the kernel statically.  There are a lot 
> more locks in the kernel than tasks on most systems. And those systems 
> that will have more tasks than locks, need a lot of memory anyway.  So 
> we only punish the big systems (that expect to be punished) and keep 
> the little guys safe.

no system is punished. Since task_struct embedds 2 locks already, moving 
the field(s) into task_struct is already a win.

	Ingo
