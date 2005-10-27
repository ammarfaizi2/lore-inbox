Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbVJ0VLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbVJ0VLg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 17:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932632AbVJ0VLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 17:11:35 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:2017 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932265AbVJ0VLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 17:11:34 -0400
Subject: Re: Overruns are killing my recordings.
From: Lee Revell <rlrevell@joe-job.com>
To: Avuton Olrich <avuton@gmail.com>
Cc: Patrick McFarland <diablod3@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3aa654a40510271257t62d2fd82n5f2bcbcae2bcba9d@mail.gmail.com>
References: <3aa654a40510271212j13e0843s9de81c02f4e766ac@mail.gmail.com>
	 <200510271528.28919.diablod3@gmail.com>
	 <3aa654a40510271257t62d2fd82n5f2bcbcae2bcba9d@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 27 Oct 2005 17:06:54 -0400
Message-Id: <1130447216.19492.87.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-27 at 12:57 -0700, Avuton Olrich wrote:
> On 10/27/05, Patrick McFarland <diablod3@gmail.com> wrote:
> > > I have ecasound output (at bottom) to show that it's getting
> > > interrupted for up to 6 seconds, and all I really need to know is how
> > > I figure out what the problem device driver is, so I can file a more
> > > specific bug.
> >
> > I don't know if ecasound uses jack or not, but jack should be set to use
> > realtime mode. Without realtime, kiss sane low latency auto-input/output
> > goodbye.
> 
> ecasound utilizes jack if it's on, which I don't really need so I
> don't run it, but it is taking advantage of SCHED_FIFO. But truely
> this is not what I'm trying to get to. I have something in this
> computer that is interrupting everything +/- 6 seconds and I'd like to
> find out what it is, I'm really just not sure the best way to find out
> what the 'offender' is.

Are you trying to record from the onboard nforce sound device or the
Audigy?  Do you have the same problem with the other device?

Make sure ecasound isn't doing something stupid like writing to the disk
from the audio thread, setting the disk IO thread to SCHED_FIFO, passing
data between the audio capture and disk threads in a non RT safe manner,
etc.

Also why are you using an -mm kernel?  It's highly experimental.  Most
audio people use the -rt kernel.

Lee

