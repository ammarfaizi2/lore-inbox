Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264795AbUIIUBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264795AbUIIUBx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 16:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266898AbUIIT6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 15:58:14 -0400
Received: from mx2.elte.hu ([157.181.151.9]:38814 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264795AbUIITzM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 15:55:12 -0400
Date: Thu, 9 Sep 2004 21:56:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jack Steiner <steiner@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] - Fix potential race condition in wake_up_forked_process()
Message-ID: <20040909195642.GA3435@elte.hu>
References: <20040909194558.GA28653@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909194558.GA28653@sgi.com>
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


* Jack Steiner <steiner@sgi.com> wrote:

> There appears to be a tiny (microscopic) timing hole in
> wake_up_forked_process(). It is possible that a load_balancing
> application could change cpus_allowed on a task as it is being forked.
> Unlikely, but it can happen, especially if preemption is enabled.

there has been alot of work in this area and sched.c in -BK is much
different from 2.6.8.1's sched.c. In particular there's no
wake_up_forked_process() but wake_up_new_task().

more importantly, the whole bootstrapping of a new task has been
reworked and the set_cpus_allowed() race should not exist in -BK
anymore. Could you double-check to make sure?

	Ingo
