Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbVHWF3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbVHWF3O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 01:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbVHWF3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 01:29:14 -0400
Received: from mx1.elte.hu ([157.181.1.137]:42721 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S1750701AbVHWF3N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 01:29:13 -0400
Date: Tue, 23 Aug 2005 07:29:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: dwalker@mvista.com, Karsten Wiese <annabellesgarden@yahoo.de>,
       george anzinger <george@mvista.com>, Adrian Bunk <bunk@stusta.de>,
       Sven-Thorsten Dietrich <sven@mvista.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] RT-patch update to remove the global pi_lock
Message-ID: <20050823052934.GA26526@elte.hu>
References: <1124704837.5208.22.camel@localhost.localdomain> <20050822101632.GA28803@elte.hu> <1124710309.5208.30.camel@localhost.localdomain> <20050822113858.GA1160@elte.hu> <1124715755.5647.4.camel@localhost.localdomain> <20050822183355.GB13888@elte.hu> <1124739657.5809.6.camel@localhost.localdomain> <1124739895.5809.11.camel@localhost.localdomain> <1124749192.17515.16.camel@dhcp153.mvista.com> <1124756775.5350.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124756775.5350.14.camel@localhost.localdomain>
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

> > One downside would be an increase in mutex structure size though.
> 
> If I do need to add an additional lock to the mutex, I would abstract 
> it all, so that the old global pi_lock can be used if configured.  
> This way, a UP or a low memory 2x SMP machine can still use the old 
> method, but when it needs to grow, switch over to the new non-global 
> pi_locking method.  But, maybe I can still get away with just using 
> the wait_lock and not add any more overhead to the size of the mutex.

We want to reduce configurability, not increase it. Having something 
like a selectable _core design property_ leads to madness and hard to 
maintain code very quickly.

also, we already have a per-lock spinlock. Why not use that?

	Ingo
