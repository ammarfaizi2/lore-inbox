Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272373AbTGYWnh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 18:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272375AbTGYWng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 18:43:36 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:8969 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S272373AbTGYWng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 18:43:36 -0400
Subject: Re: [patch] sched-2.6.0-test1-G3, interactivity changes, audio
	latency
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0307252146550.16235-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0307252146550.16235-100000@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1059173917.573.6.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3.99 
Date: Sat, 26 Jul 2003 00:58:38 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-07-25 at 21:59, Ingo Molnar wrote:
> my current "interactivity changes" scheduler patchset can be found at:
> 
> 	redhat.com/~mingo/O(1)-scheduler/sched-2.6.0-test1-G3
> 
> (this patch is mostly orthogonal to Con's patchset, but obviously collides
> patch-wise. The patch should also cleanly apply to 2.6.0-test1-bk2.)

For my workloads, this patch behaves just a little bit better than -G2,
but overall, X still feels jumpy, even under no load. I haven't been
able to reproduce any XMMS sound skips, due to the raising of
CHILD_PENALTY.

I've seen much better response times and less jerkiness of the system by
setting MAX_SLEEP_AVG at 1000000000 and STARVATION_LIMIT to HZ. With
these settings, under heavy load, no process starvation or slowdown can
be perceived, an opening new terminals, or launching processes is nearly
as fast as when the system is under no load. This is great, as the
vanilla scheduler is unable to handle this correctly.

Additionally, renicing X to -20 gives pretty good results for X
applications, like Evolution, but there are still some remanents of
jerkiness from time to time.


