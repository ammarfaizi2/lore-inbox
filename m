Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbWC1WlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbWC1WlD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 17:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbWC1WlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 17:41:03 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:65177 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932473AbWC1WlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 17:41:01 -0500
Subject: Re: realtime-preempt 2.6.16-rt7-10 bug?
From: Lee Revell <rlrevell@joe-job.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Shayne O'Connor" <machine@machinehasnoagenda.com>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, ardour-dev@lists.ardour.org,
       Paul Davis <paul@linuxaudiosystems.com>
In-Reply-To: <1143579439.12960.5.camel@localhost.localdomain>
References: <1143559994.2959.5.camel@machine>
	 <1143579439.12960.5.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 28 Mar 2006 17:40:57 -0500
Message-Id: <1143585658.11792.113.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-28 at 15:57 -0500, Steven Rostedt wrote:
> On Wed, 2006-03-29 at 02:33 +1100, Shayne O'Connor wrote:
> > i've compiled the 2.6.16 kernel with the realtime-preempt patches, but
> > have run into some problems while using Ardour for realtime audio.
> > Ardour crashes whenever i stop recording, and after running dmesg i'm
> > suspecting a bug in the realtime patch (i've tried rt7 and rt10, both
> > have the same problem):
> > 
> 
> Hmm, this may be a bug in Ardour.  Since it's for realtime audio, I
> assume that it knows about the timeofday hack, which is the only way to
> get this bug.  The user application set itself to be uninterruptible by
> calling gettimeofday with the two pointers and the integer 1.  This sets
> the task's flag to be uninterruptible (PF_NOSCHED).  But then it did a
> write to the file system (ext3) which did a schedule. Thus you got a
> BUG.

Specifically it unlinked a file.

Shayne, is your /tmp a tmpfs or ext3?

Lee

