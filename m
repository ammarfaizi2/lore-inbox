Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbWECNaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbWECNaV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 09:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030203AbWECNaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 09:30:20 -0400
Received: from mail27.syd.optusnet.com.au ([211.29.133.168]:7098 "EHLO
	mail27.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1030199AbWECNaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 09:30:20 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Juho Saarikko <juhos@mbnet.fi>
Subject: Re: [ck] 2.6.16-ck9
Date: Wed, 3 May 2006 23:30:12 +1000
User-Agent: KMail/1.9.1
Cc: ck list <ck@vds.kolivas.org>, linux list <linux-kernel@vger.kernel.org>
References: <200605022338.20534.kernel@kolivas.org> <200605030801.05523.kernel@kolivas.org> <1146646484.4260.6.camel@a88-112-69-25.elisa-laajakaista.fi>
In-Reply-To: <1146646484.4260.6.camel@a88-112-69-25.elisa-laajakaista.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605032330.13131.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 May 2006 18:54, Juho Saarikko wrote:
> On Wed, 2006-05-03 at 01:01, Con Kolivas wrote:
> > The spid will show you any threads with different pids to the main task.
> > Then check the actual scheduling policy they run at. Perhaps FahCore
> > actually manually sets them to SCHED_NORMAL.
>
> And so it does. Annoying. Time to hack kernel to add a new scheduling
> policy, SCHED_STAYIDLE, which is like SCHED_IDLE but cannot be unset
> except by root.
>
> Can't make it the default, since a program running at SCHED_IDLE in a
> machine with 100% CPU usage by some other program will never process
> SIGKILL, and thus can only be killed by setting its scheduling policy to
> normal...

I toyed with the idea of making it one way to convert tasks to SCHED_IDLEPRIO 
but not back to SCHED_NORMAL much like we do for niceing tasks up but not 
back down again. However I personally found this very inconvenient as I often 
might run something idleprio for a while and then change it back. It seems a 
fair thing for a normal user to do.

> Darn obnoxious program, SetiAtHome...

Obviously when they wrote the linux client and added the ability to set the 
priority from within the program to nice 19 they also explicitly set the 
scheduling policy at the same time. This might make sense on some other OS... 
but not linux.

-- 
-ck
