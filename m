Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262188AbUKWEqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbUKWEqL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 23:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUKVQd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 11:33:26 -0500
Received: from dvhart.com ([64.146.134.43]:4994 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S262168AbUKVQCe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 11:02:34 -0500
Subject: Re: Information about move_tasks return
From: Darren Hart <darren@dvhart.com>
To: =?ISO-8859-1?Q?C=EDcero?= <cicero.mota@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <ce70c49041122041623155a@mail.gmail.com>
References: <ce70c49041122041623155a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 22 Nov 2004 08:02:24 -0800
Message-Id: <1101139344.21252.65.camel@farah.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-22 at 08:16 -0400, Cícero wrote:
> hi
> 
> I am looking for the result of the function  move_task in
> 
> kernel/sched.c , I have observed that it returns an int value and as I
> print it with printk.
> 
> I have created a int variable 'results_move_task' which capture the result of
> 
> move_task and I print it with printk("%d",results_move_task); I
> observed that it often returns the value '1' and sometimes it returns
> '2' or more. Is it really correct?

/*
 * move_tasks tries to move up to max_nr_move tasks from busiest to this_rq,
 * as part of a balancing operation within "domain". Returns the number of
 * tasks moved.
 *
 * Called with both runqueues locked.
 */
static int move_tasks(runqueue_t *this_rq, int this_cpu, runqueue_t *busiest,
                      unsigned long max_nr_move, struct sched_domain *sd,
                      enum idle_type idle)
{
...


So as the "documentation" states, it returns the number of tasks
actually moved.  For instance, The balancing code may request 4 tasks be
moved, but for various reasons, only 2 were actually moved to other
CPUs, move_tasks() would return 2.

-- 
Darren Hart <darren@dvhart.com>

