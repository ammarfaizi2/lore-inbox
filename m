Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270507AbUJTUIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270507AbUJTUIA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 16:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270494AbUJTUCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 16:02:44 -0400
Received: from mx2.elte.hu ([157.181.151.9]:24208 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268907AbUJTT7A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:59:00 -0400
Date: Wed, 20 Oct 2004 21:59:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: John Hawkes <hawkes@oss.sgi.com>
Cc: nickpiggin@yahoo.com.au, akpm@osdl.org, linux-kernel@vger.kernel.org,
       jbarnes@sgi.com, hawkes@sgi.com
Subject: Re: [PATCH, 2.6.9] improved load_balance() tolerance for pinned tasks
Message-ID: <20041020195930.GA29735@elte.hu>
References: <200410201936.i9KJa4FF026174@oss.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410201936.i9KJa4FF026174@oss.sgi.com>
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


* John Hawkes <hawkes@oss.sgi.com> wrote:

> A large number of processes that are pinned to a single CPU results in
> every other CPU's load_balance() seeing this overloaded CPU as "busiest",
> yet move_tasks() never finds a task to pull-migrate.  This condition
> occurs during module unload, but can also occur as a denial-of-service
> using sys_sched_setaffinity().  Several hundred CPUs performing this
> fruitless load_balance() will livelock on the busiest CPU's runqueue
> lock.  A smaller number of CPUs will livelock if the pinned task count
> gets high.  This simple patch remedies the more common first problem:
> after a move_tasks() failure to migrate anything, the balance_interval
> increments.  Using a simple increment, vs.  the more dramatic doubling of
> the balance_interval, is conservative and yet also effective.
> 
> John Hawkes
> 
> 
> Signed-off-by: John Hawkes <hawkes@sgi.com>

looks good to me.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
