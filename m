Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbVDDXBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbVDDXBR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 19:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbVDDXBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 19:01:10 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:52669 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261475AbVDDXA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 19:00:27 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.43-00
From: Steven Rostedt <rostedt@goodmis.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>, Gene Heskett <gene.heskett@verizon.net>,
       LKML <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <Pine.LNX.4.61.0504041640490.31810@montezuma.fsmlabs.com>
References: <200504011834.22600.gene.heskett@verizon.net>
	 <20050402051254.GA23786@elte.hu>
	 <1112470675.27149.14.camel@localhost.localdomain>
	 <1112472372.27149.23.camel@localhost.localdomain>
	 <20050402203550.GB16230@elte.hu>
	 <1112474659.27149.39.camel@localhost.localdomain>
	 <1112479772.27149.48.camel@localhost.localdomain>
	 <1112486812.27149.76.camel@localhost.localdomain>
	 <20050404200043.GA16736@elte.hu>
	 <1112647253.5147.17.camel@localhost.localdomain>
	 <20050404204725.GA17818@elte.hu>
	 <1112649296.5147.21.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0504041640490.31810@montezuma.fsmlabs.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 04 Apr 2005 18:59:26 -0400
Message-Id: <1112655566.5147.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-04 at 16:51 -0600, Zwane Mwaikambo wrote:

> I'm sure a lot of the yield() users could be converted to 
> schedule_timeout(), some of the users i saw were for low memory conditions 
> where we want other tasks to make progress and complete so that we a bit 
> more free memory.
> 

I've stated earlier that I was locked up in fs/inode.c with the
__wait_on_freeing_inode. Can this be switched to a schedule_timeout?

Of course schedule_timeout is not too good with RT as well. Although you
can prevent a live_deadlock, but we bring up the problem of priority
inversion again. The process needing to run can still be starved by
another higher priority process that is lower in priority as the one
doing the waiting.

The schedule_timeout should stop the livelock. But what is the effect of
switching to it?

-- Steve


