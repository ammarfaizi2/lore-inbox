Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316871AbSEVG2e>; Wed, 22 May 2002 02:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316872AbSEVG2d>; Wed, 22 May 2002 02:28:33 -0400
Received: from web14204.mail.yahoo.com ([216.136.172.146]:23439 "HELO
	web14204.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S316871AbSEVG2c>; Wed, 22 May 2002 02:28:32 -0400
Message-ID: <20020522062832.34936.qmail@web14204.mail.yahoo.com>
Date: Tue, 21 May 2002 23:28:32 -0700 (PDT)
From: Erik McKee <camhanaich99@yahoo.com>
Subject: Re: Kernel BUG 2.4.19-pre8-ac1 + preempt
To: linux-kernel@vger.kernel.org
In-Reply-To: <1022027112.967.86.camel@sinai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well here are the results of trying 2.4.19-pre8-ac5 with no preempt.  I have to
throw a lot of processes in kde at it to to get it to become unresponsive. 
Preformance becomes more sluggish as the number of processes and htus the load
is ramped up.  Eventially, I get down to 8k swap free, at which point system
becomes unresponsive.  Sendmail doesn't send, becuase of load avg near 40
something.  Clock on konsole doesn't move anywhere and the oom killer tries
again to kill stuff.  However, as far as i can see, no oops.  The first one was
only in dmesg and not log, so this one might have not made it through to syslog
(if it happened).  changing to vc is a no go at this point.  alt-sysrq-s seems
to work.  Tried alt-sysrq-k with no obvious effect.  At one point it seemed as
if i was really out of x and at a vc, however the x display stayed on he screen
and subsequent alt-sysrq-k's only caused the screen to move around, which could
be fixed by alt-ctrl-f2 to recenter the screen.  At this point the hd light had
finally gone out, perhaps as the result of previous alt-sysrq-k's, althouhg no
mention of them is found in the logs.  After a reboot and a resync of the raid
array, life seems bak to normal again...  Well, pretty much....  I did find
some corruption on the partition which is my boot partition.... a file missing,
e2fsck replayed the ext3 journal and foudn some errors, and tried copying the
file over, cp i/o error can't stat the file....  Alas, can't unmount the
partition, otherwise would reformat it, and reinstall lilo and my kernel images
on it.  SO off to try this via floppy rebooting ;)

JUst to dispell bad harddrive ?'s on this one, rformatting it definately worked
;)

--- Robert Love <rml@tech9.net> wrote:
> I don't think this has anything to do with preempt.  The current task
> was not preemptible (hence the error notice on exit - is that why you
> blame preempt?).  There is also no preempt_schedule call in your back
> trace.
> 
> Looks to me like you died coming off an IDE interrupt and a resulting
> read - you ran out of free pages and bit the dust there.  Dunno why,
> though.  I don't have an mm_inline.h:78 in my tree, but I do have a
> DEBUG_LRU near it ...
> 
> 	Robert Love
> 


__________________________________________________
Do You Yahoo!?
LAUNCH - Your Yahoo! Music Experience
http://launch.yahoo.com
