Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280922AbRKTFwR>; Tue, 20 Nov 2001 00:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280920AbRKTFwH>; Tue, 20 Nov 2001 00:52:07 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:39186 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S280917AbRKTFvy>;
	Tue, 20 Nov 2001 00:51:54 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200111200551.fAK5pp2209301@saturn.cs.uml.edu>
Subject: Re: Bug or feature? Priority in /proc/<pid>/stat for RT processes
To: mlev@despammed.com (Lev Makhlis)
Date: Tue, 20 Nov 2001 00:51:51 -0500 (EST)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), linux-kernel@vger.kernel.org
In-Reply-To: <200111200443.fAK4hlJ25287@portent.dyndns.org> from "Lev Makhlis" at Nov 19, 2001 11:43:46 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lev Makhlis wwrites:
> On Monday 19 November 2001 06:31 am, Albert D. Cahalan wrote:

>> I can tell you what procps will do. The very first thing is
>> to undo your transformation. Don't bother having the kernel
>> muck with the numbers. The procps code will transform the
>> numbers as needed to match UNIX convention and/or the tools
>> which users run to set these values.
>
> Hmm, how would you explain that the kernel mucks with the numbers
> for SCHED_OTHER, but not for SCHED_FIFO/SCHED_RR?

Long ago, the kernel didn't muck with the numbers. It has to
do that now because the numbers used inside the kernel are
different than they used to be. If the interface were being
designed today, it could supply the raw numbers.

> IIRC, procps does not attempt to undo the f(x) = 20 - (10x + 5) / 10
> (assuming HZ=100) transformation currently used for SCHED_OTHER.

Yes it does, more-or-less. This depends on what is being
supplied to the user. You can have the data UNIX-style,
SunOS-style, and traditional Linux-style. Like this:

ps -eo pri,opri,priority

> Granted, procps can do the transformation itself, but procps does not
> have a monopoly on using procfs data -- any other performance-monitoring
> application would have to duplicate the transformation, if it is to be
> consistent with the standard (procps) tools.  I thought it would be
> nice if the kernel provided a consistent interface through procfs to
> begin with.

Maybe you should consider why, if true, the kernel internals
are not consistent with the API. Perhaps this isn't a performance
advantage. I also wonder why RT tasks have a separate priority
in the task struct when they leave the regular one unused and
regular tasks leave the RT one unused. If these could be the same
data type, then there isn't even any need for a union.

For compatibility with the rest of the world, procps needs to
display the scheduling policy ("RR", "TS", etc.) and remap RT
priority values in several different ways. Having the kernel
remap values just obfuscates what the data really means, making
more work for every app developer and wasting kernel CPU time.
