Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261768AbVC3GvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbVC3GvH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 01:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbVC3GvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 01:51:07 -0500
Received: from mx1.elte.hu ([157.181.1.137]:33981 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261768AbVC3GvD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 01:51:03 -0500
Date: Wed, 30 Mar 2005 08:50:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Esben Nielsen <simlo@phys.au.dk>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
Message-ID: <20050330065011.GA18417@elte.hu>
References: <Pine.OSF.4.05.10503242307330.25274-100000@da410.phys.au.dk> <Pine.LNX.4.58.0503261047190.27746@localhost.localdomain> <1112164313.3691.100.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112164313.3691.100.camel@localhost.localdomain>
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

> OK, I'm declaring defeat here. I've been fighting race conditions all 
> day, and it's now 1 in the morning where I live. It looks like this 
> implementation has no other choice but to have the waking up "pending 
> owner" take the wait_list lock once again.  How heavy of a overhead is 
> that really?

as i mentioned it before, taking a lock is not a big issue at all. Since 
you have to touch the lock data structure anyway (and all of it fits 
into a single cacheline), it doesnt really matter whether it's atomic 
flag setting/clearing, or raw spinlock based.

later on, once things are stable and well-understood, we can still 
attempt to micro-optimize it.

	Ingo
