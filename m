Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270770AbUJURnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270770AbUJURnO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 13:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270789AbUJURnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 13:43:06 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:24212 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S270770AbUJURlt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 13:41:49 -0400
Date: Thu, 21 Oct 2004 13:41:09 -0400
To: "Eugeny S. Mints" <emints@ru.mvista.com>
Cc: john cooper <john.cooper@timesys.com>, Esben Nielsen <simlo@phys.au.dk>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Jens Axboe <axboe@suse.de>, Rui Nuno Capela <rncbc@rncbc.org>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041021174109.GB26318@yoda.timesys>
References: <Pine.OSF.4.05.10410211601500.11909-100000@da410.ifa.au.dk> <4177CD3C.9020201@timesys.com> <4177DA11.4090902@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4177DA11.4090902@ru.mvista.com>
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 07:47:29PM +0400, Eugeny S. Mints wrote:
> Seems it is too coplex model at least for the first step. The one of 
> possible trade-offs coming on mind is to trace the number of resources 
> (mutexes) held by a process and to restore original priority only when 
> resource count reaches 0. This is one of the sollutions accepted by RTOS 
> guys.

That complicates analysis, though, since you now have to look at all
critical sections that the shared-with-high-priority-threads critical
sections nest in.  IMHO, it's important that the inherited priority
be given up as soon as the resource is released.

-Scott
