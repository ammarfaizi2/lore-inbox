Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVAWDBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVAWDBf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 22:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVAWDBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 22:01:35 -0500
Received: from mail.joq.us ([67.65.12.105]:12682 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261193AbVAWDBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 22:01:13 -0500
To: Con Kolivas <kernel@kolivas.org>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, linux <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, rlrevell@joe-job.com,
       paul@linuxaudiosystems.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt 
 scheduling
References: <41EEE1B1.9080909@kolivas.org> <41EF00ED.4070908@kolivas.org>
	<873bwwga0w.fsf@sulphur.joq.us> <41EF123D.703@kolivas.org>
	<87ekgges2o.fsf@sulphur.joq.us> <41EF2E7E.8070604@kolivas.org>
	<87oefkd7ew.fsf@sulphur.joq.us>
	<10752.195.245.190.93.1106211979.squirrel@195.245.190.93>
	<65352.195.245.190.94.1106240981.squirrel@195.245.190.94>
	<41F19907.2020809@kolivas.org> <87k6q6c7fz.fsf@sulphur.joq.us>
	<41F1F735.1000603@kolivas.org> <41F1F7AF.7000105@kolivas.org>
	<41F1FC1D.10308@kolivas.org> <87wtu55i3x.fsf@sulphur.joq.us>
	<41F2F7C1.70404@kolivas.org>
From: "Jack O'Quin" <joq@io.com>
Date: Sat, 22 Jan 2005 21:02:22 -0600
In-Reply-To: <41F2F7C1.70404@kolivas.org> (Con Kolivas's message of "Sun, 23
 Jan 2005 12:02:57 +1100")
Message-ID: <87r7kcu9tt.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> writes:

> Jack O'Quin wrote:
>> Neither run exhibits reliable audio performance.  There is some low
>> latency performance problem with your system.  Maybe ReiserFS is
>> causing trouble even with logging turned off.  Perhaps the problem is
>> somewhere else.  Maybe some device is misbehaving.
>>
>> Until you solve this problem, beware of drawing conclusions.

> Sigh.. I guess you want me to do all the benchmarking. 

Not at all.  I am willing to continue running audio benchmarks for you
and Ingo both.  I have been spending significant amounts of time doing
that.  I can't work on it full-time, but will continue doing tests as
requested.  I just assumed you wanted to be able to produce similar
results on your own system.  I would, if I were in your place.

I think you misunderstood my comment.  I was pointing out that your
system currently has too low a signal/noise ratio to draw conclusions
about scheduling and latency.  How can we tell whether the scheduler
is working or not when there are extremely long XRUNS (~20msec) even
running SCHED_FIFO?  Clearly, something is broken.  We need to figure
out what the latency problem is with your system before putting too
much faith in those results.

> Well it's easy enough to get good results. I'll simply turn off all
> services and not run a desktop. This is all on ext3 on a fully laden
> desktop by the way, but if you want to get the results you're
> looking for I can easily drop down to a console and get perfect
> results.

That would prove absolutely nothing.  The whole purpose in requesting
SCHED_FIFO (or an approximation, like SCHED_ISO) is for audio to work
reliably in a loaded system.  You were running your tests in the right
environment.  Your results showed it wasn't working, but did not
necessarily indicate a scheduler problem.

My tests were all done with GNOME, metacity, xemacs, and galeon
running.  I still use ext2 because back when I tuned my system for
audio, ext3 had very poor low latency behavior.  Maybe that has
changed.  Or, maybe it hasn't and that is the cause of the latency
spikes you're seeing.  I can't figure that out remotely, but I can
suggest some things to try.  First, make sure the JACK tmp directory
is mounted on a tmpfs[1].  Then, try the test with ext2, instead of
ext3.

  [1] http://www.affenbande.org/~tapas/wiki/index.php?Jackd%20and%20tmpfs%20%28or%20shmfs%29

Tuning Linux PC's for low-latency audio is currently an art, not a
science.  But, a considerable body of experience has grown up over the
past few years[2].  It can be done.  (If nothing else, you may develop
more sympathy for all the crap Linux audio developers have been
putting up with for so long.)

  [2] http://affenbande.org/~tapas/wiki/index.php?Low%20latency%20for%20audio%20work%20on%20linux%202.6.x

I recommend testing these schedulers on the best available low latency
kernel for the clearest signal/noise ratio before drawing any final
conclusions.  Right now, that seems to be Ingo's RP version.

The original request that started this whole exercise was for 2.6.10
numbers, which morphed into 2.6.11-rc1.  Working on the mainline of
development makes sense.  And, the mainline is getting a lot better.
But, 2.6.10 is still far from clean as a vehicle for soft-RT.  Your
tests prove that.
-- 
  joq
