Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261314AbTC2XMG>; Sat, 29 Mar 2003 18:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261349AbTC2XMG>; Sat, 29 Mar 2003 18:12:06 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:48650
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261314AbTC2XMF>; Sat, 29 Mar 2003 18:12:05 -0500
Subject: Re: Bad interactive behaviour in 2.5.65-66 (sched.c)
From: Robert Love <rml@tech9.net>
To: Peter Lundkvist <p.lundkvist@telia.com>, akpm@digeo.com, mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3E8610EA.8080309@telia.com>
References: <3E8610EA.8080309@telia.com>
Content-Type: text/plain
Organization: 
Message-Id: <1048980204.13757.17.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 29 Mar 2003 18:23:24 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-29 at 16:32, Peter Lundkvist wrote:

> I have seen long delays when starting e.g. xterm from my
> window manager (sawfish) either by keyboard-shortcut or by
> menu command (by mouse) starting from 2.5.65. Sometimes it
> starts immediately, sometimes after up to 2 seconds (idle
> system). If I start a new xterm from xterm it always start
> immediately. 2.5.64 always behaved OK.

You are not alone...

> My first try to solve this problem  was to use some
> scheduler parameters from 2.6.64:
>     #define MAX_TIMESLICE         (300 * HZ / 1000)
>     #define CHILD_PENALTY         95
>     #define MAX_SLEEP_AVG         (2*HZ)
>     #define STARVATION_LIMIT      (2*HZ)
> 
> but got the same behaviour.

Expected.

> 2nd try was to use sched.c, sched.h from 2.5.64 in a
> 2.5.66 build + one line patch in fork.c:
> -       p->last_run = jiffies;
> +       p->sleep_timestamp = jiffies;
> 
> Now the system behaves as it should!

This seems to confirm it was one of the interactivity changes that went
into 2.5.65.  I figured as much but it is nice to get confirmation. 
Thank you for trying this.

Now to figure out which one...

> My system is a P-III 700 (Inspiron 4000),
> and Debian (X is running at nice = -10).

I wonder if the reniced X is a factor?

	Robert Love

