Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270586AbUJUKBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270586AbUJUKBg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 06:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269399AbUJUJ4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 05:56:44 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:12195
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S270650AbUJUJzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 05:55:55 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Christoph Hellwig <hch@infradead.org>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
In-Reply-To: <20041021093532.GA2482@infradead.org>
References: <20041014143131.GA20258@elte.hu>
	 <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu>
	 <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu>
	 <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu>
	 <20041020094508.GA29080@elte.hu>
	 <30690.195.245.190.93.1098349976.squirrel@195.245.190.93>
	 <1098350190.26758.24.camel@thomas>  <20041021093532.GA2482@infradead.org>
Content-Type: text/plain
Organization: linutronix
Message-Id: <1098352072.26758.27.camel@thomas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 21 Oct 2004 11:47:52 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-21 at 11:35, Christoph Hellwig wrote:
> On Thu, Oct 21, 2004 at 11:16:30AM +0200, Thomas Gleixner wrote:
> > On Thu, 2004-10-21 at 11:12, Rui Nuno Capela wrote:
> > >  [<e018e139>] queuecommand+0x70/0x7c [usb_storage] (24)
> > 
> > As I already pointed out, this is a problem due to up(sema) in
> > queuecommand. That's one of the semaphore abuse points, which needs to
> > be fixed. 
> > 
> > The problem is that semaphores are hold by Process A and released by
> > Process B, which makes Ingo's checks trigger
> 
> Which is perfectly valid for a semaphore.
> 

In fact this is used where wait_for_completion() is the correct thing to
do. It's not waiting for a resource. It's waiting for completion of a
commoand.

tglx


