Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964970AbWBANMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbWBANMq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 08:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbWBANMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 08:12:46 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:29854 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964958AbWBANMp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 08:12:45 -0500
Date: Wed, 1 Feb 2006 14:11:11 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Avoid moving tasks when a schedule can be made.
Message-ID: <20060201131111.GA27793@elte.hu>
References: <1138736609.7088.35.camel@localhost.localdomain> <20060201130818.GA26481@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060201130818.GA26481@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> i think the right approach would be to split up this work into smaller 
> chunks. Or rather, lets first see how this can happen: why is 
> can_migrate() false for so many tasks? Are they all cpu-hot? If yes, 
> shouldnt we simply skip only up to a limit of tasks in this case - 
> it's not like we want to spend 1.5 msecs searching for a cache-cold 
> task which might give us a 50 usecs advantage over cache-hot tasks ...

the only legimate case where we have to skip alot of tasks is the case 
when there are alot of CPU-bound (->cpus_alowed) tasks in the runqueue.  
In that case the scheduler really has to skip that task. But that is not 
an issue in your workload.

	Ingo
