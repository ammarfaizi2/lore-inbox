Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263843AbUEXCon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263843AbUEXCon (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 22:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263850AbUEXCon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 22:44:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:31428 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263843AbUEXCoa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 22:44:30 -0400
Date: Sun, 23 May 2004 19:43:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Phy Prabab <phyprabab@yahoo.com>
Cc: wli@holomorphy.com, jakob@unthought.net, linux-kernel@vger.kernel.org
Subject: Re: Help understanding slow down
Message-Id: <20040523194352.4468da09.akpm@osdl.org>
In-Reply-To: <20040524015153.32010.qmail@web90003.mail.scd.yahoo.com>
References: <20040524012828.GK1833@holomorphy.com>
	<20040524015153.32010.qmail@web90003.mail.scd.yahoo.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phy Prabab <phyprabab@yahoo.com> wrote:
>
> Okay, so ran the test with vmstat running.  I ran it
>  capturing every 1 sec.  Here is an excert:

That was horridly wordwrapped.

procs                      memory      swap         io     system         cpu
 r  b   swpd   free   buff  cache   si   so    bi   bo   in    cs us sy id wa
 1  0      0 8153848  17000  82348    0    0     0    0 4568  4028  6 16 78  0
 0  1      0 8154168  17008  82340    0    0     0  160 4596  4079  7 17 76  1
 1  0      0 8153848  17008  82340    0    0     0    0 4511  3998  7 16 76  0
 1  0      0 8153912  17008  82340    0    0     0    0 4460  3952  7 14 79  0
 1  0      0 8153784  17016  82332    0    0     0    0 4437  3962  7 16 77  0
 1  0      0 8153528  17016  82332    0    0     0    0 4444  3927  7 14 78  0
 1  1      0 8153784  17024  82392    0    0     0  144 4399  3895  7 15 77  1
 0  0      0 8153592  17024  82392    0    0     0    0 4367  3821  7 15 78  0
 1  0      0 8153848  17024  82392    0    0     0    0 4393  3926  6 16 78  0
 1  0      0 8153528  17024  82460    0    0     0    0 4438  3960  8 14 78  0
 1  0      0 8154040  17024  82460    0    0     0    0 4415  3912  6 15 78  0
 1  1      0 8153720  17032  82452    0    0     0  140 4457  3953  7 15 77  1
 1  0      0 8153784  17032  82452    0    0     0    0 4437  3889  7 14 79  0
 0  0      0 8153784  17040  82444    0    0     0    0 4398  3903  8 15 77  0
 1  0      0 8153464  17040  82444    0    0     0    0 4398  3902  7 14 79  0
 0  0      0 8153528  17040  82444    0    0     0    0 4447  3922  6 17 77  0
 0  1      0 8153720  17052  82432    0    0     0  144 4490  3960  6 16 77  1
 0  0      0 8153656  17056  82428    0    0     0    0 4449  3954  7 15 78  0

This is a single-CPU machine, yes?

Your application is spending most of the time in an explicit sleep of some
form.  Suggest you run strace against it and see what it's up to.
