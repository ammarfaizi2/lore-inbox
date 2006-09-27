Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbWI0DIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWI0DIf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 23:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWI0DIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 23:08:35 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:8683 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932327AbWI0DIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 23:08:34 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Bill Huey (hui) <billh@gnuppy.monkey.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>, John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] move put_task_struct() reaping into a thread [Re: 2.6.18-rt1]
References: <20060920141907.GA30765@elte.hu>
	<20060921065624.GA9841@gnuppy.monkey.org>
Date: Tue, 26 Sep 2006 20:55:41 -0600
In-Reply-To: <20060921065624.GA9841@gnuppy.monkey.org> (Bill Huey's message of
	"Wed, 20 Sep 2006 23:56:24 -0700")
Message-ID: <m1irjaqaqa.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Huey (hui) <billh@gnuppy.monkey.org> writes:

> On Wed, Sep 20, 2006 at 04:19:07PM +0200, Ingo Molnar wrote:
>> I'm pleased to announce the 2.6.18-rt1 tree, which can be downloaded 
>> from the usual place:
> ... 
>> as usual, bugreports, fixes and suggestions are welcome,
>
> Speaking of which...
>
> This patch moves put_task_struct() reaping into a thread instead of an
> RCU callback function as discussed with Esben publically and Ingo privately:

Stupid question.

Why does the rt tree make all calls to put_task_struct an rcu action?
We only need the rcu callback from kernel/exit.c

Nothing else needs those semantics.

I agree that put_task_struct is the most common point so this is unlikely
to remove your issues with rcu callbacks but it just seems completely backwards
to increase the number of rcu callbacks in the rt tree.

Eric
