Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314231AbSDRD6O>; Wed, 17 Apr 2002 23:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314232AbSDRD6N>; Wed, 17 Apr 2002 23:58:13 -0400
Received: from zero.tech9.net ([209.61.188.187]:3589 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S314231AbSDRD6N>;
	Wed, 17 Apr 2002 23:58:13 -0400
Subject: Re: 2.4.19-pre7+preempt: rpciod[178] exited with preempt_count 1
From: Robert Love <rml@tech9.net>
To: Alex Riesen <riesen@synopsys.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020417224222.A184@steel>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 17 Apr 2002 23:58:19 -0400
Message-Id: <1019102300.5395.33.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-04-17 at 16:42, Alex Riesen wrote:

> just tried your preempt-kernel-rml-2.4.19-pre7-1.patch.
> I'm using automount (v4) here and am getting this in syslog:
> 
> Apr 17 22:32:26 steel kernel: lockd[190] exited with preempt_count 1 
> Apr 17 22:32:26 steel kernel: rpciod[189] exited with preempt_count 1 
> 
> Every time automounter decides to drop an nfs mount.
> Some time ago i've read on lkml that such kind of messages aren't very
> good to see, so decided to drop you a note.

It is most likely caused by nfs neglecting to drop a lock when it exits
- it is not a problem.  The error message is there to catch cases where
a task's preempt_count (consider it a task's eligibility to be
preempted) is nonzero when it exists.  It should always be zero.

In this case it is probably harmless since the count isn't off until the
task exits.  This test may not be worth it with these false positives...

> P.S.
> didn't see them with 2.4.19-pre2-ac2
> interactive feel quiet acceptable, although 2.4.19-pre2-ac2
> 'feels' still better, maybe because of O(1) scheduler, dunno.
> No skips/clicks in xmms while compiling kernel and opening
> a pile of images with gimp. Besides the messages in syslog
> nothing happened

Good to hear.

	Robert Love

