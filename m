Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263121AbTIAQwU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 12:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263140AbTIAQwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 12:52:20 -0400
Received: from 224.Red-217-125-129.pooles.rima-tde.net ([217.125.129.224]:9707
	"HELO cocodriloo.com") by vger.kernel.org with SMTP id S263121AbTIAQwI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 12:52:08 -0400
Date: Mon, 1 Sep 2003 16:21:28 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: Ian Kumlien <pomac@vapor.com>
Cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org,
       geert@linux-m68k.org
Subject: Re: [SHED] Questions.
Message-ID: <20030901142128.GB2359@wind.cocodriloo.com>
References: <1062324435.9959.56.camel@big.pomac.com> <1062355996.1313.4.camel@boobies.awol.org> <1062358285.5171.101.camel@big.pomac.com> <1062359478.1313.9.camel@boobies.awol.org> <1062369684.9959.166.camel@big.pomac.com> <1062373274.1313.28.camel@boobies.awol.org> <1062374409.5171.194.camel@big.pomac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062374409.5171.194.camel@big.pomac.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 02:00:09AM +0200, Ian Kumlien wrote:
> On Mon, 2003-09-01 at 01:41, Robert Love wrote:
> > On Sun, 2003-08-31 at 18:41, Ian Kumlien wrote:
> > 
> > > hummm, I assume that a high pri process can preempt a low pri process...
> > > The rest sounds sane to me =), Please tell me what i'm missing.. =)
> > 
> > No no.  The rule is "the highest priority process with timeslice
> > remaining runs" not just "the highest priority process runs."
> 
> Then i'm beginning to agree with the time unit... Large timeslice but in
> units for high pri tasks... So that high pri can run (if needed) 2 or 3
> times / timeslice.
> 
> More like MAX_QUANT_ON_QUEUE/MIN_QUANT or so... 
> 
> > Otherwise, timeslice wouldn't matter much!
> 
> Just sounds odd to me.
> 
> > When a process exhausts its timeslice, it is moved to the "expired"
> > list.  When all currently running tasks expire their timeslice, the
> > scheduler begins servicing from the "expired" list (which then becomes
> > the "active" list, and the old active list becomes the expired).
> 
> Ok, good solution
> 
> > This implies that a high priority, which has exhausted its timeslice,
> > will not be allowed to run again until _all_ other runnable tasks
> > exhaust their timeslice (this ignores the reinsertion into the active
> > array of interactive tasks, but that is an optimization that just
> > complicates this discussion).
> 
> So it's penalised by being in the corner for one go? or just pri
> penalised (sounds like it could get a corner from what you wrote... Or
> is it time for bed).
> 
> > If timeslices did not play a role, then high priority tasks would always
> > monopolize the system.

This happened on Amiga.
 
> > This is a classic priority-based round-robin scheduler.
> 
> > > > Once a task exhausts its timeslice, it cannot run until all other tasks
> > > > exhaust their timeslice.  If this were not the case, high priority tasks
> > > > could monopolize the system.
> > > 
> > > All other? including sleeping?... How many tasks can be assumed to run
> > > on the cpu at a time?....
> > 
> > I wasn't clear: all other _runnable_ tasks.
> 
> Yes, but how many runable tasks would you have on a system in one go,
> while maintaining interactivity...
> (Ie, what amount would the scheduler actually have to deal with..)
> 
> > Once a task "expires" (exhausts its timeslice), it will not run again
> > until all other tasks, even those of a lower priority, exhaust their
> > timeslice.
> 
> Yeah, it seems like my idea would need several run queues with diff
> timeslices to make up.
> 
> > This is a major difference between normal tasks and real-time tasks.
> > 
> > > Should preempt send the new quantum value to all "low pri, high quantum"
> > > processes?
> > 
> > I don't follow this?
> 
> Never mind, bad idea, sucky thing... =P
> 
> > > Damn thats a tough cookie, i still think that the priority inversion is
> > > bad. Don't know enough about this to actually provide a solution... 
> > > Any one else that has a view point?
> > 
> > Priority inversion is bad, but the priority inversion in this case is
> > intended.  Higher priority tasks cannot starve lower ones.  It is a
> > classic Unix philosophy that 'all tasks make some forward progress'
> 
> Yes, like the feedback scheduler... 
> 
> > If you need to guarantee that a task always runs when runnable, you want
> > real-time.
> 
> ... yes... =)
> 
> > If you just want to give a scheduling boost, to ensure greater
> > runnability, lower latency, and larger timeslices... nice values
> > suffice.
> 
> nicevalues/pri is always the best way imho.
> 
> > > Hummm, the skips in xmms tells me that something is bad.. 
> > > (esp since it works perfectly on the previus scheduler)
> > 
> > A lot of this is just the interactivity estimator making the wrong
> > estimate.
> 
> Yes, But... When you come from AmigaOS, and have used Executive...
> things like this is dis concerning. Executive is a scheduler addition
> for amigaos that has many schedulers to choose from. One of which is the
> original feedback scheduler. While a feedback scheduler consumes some
> cpu it still allows you to play mp3's while surfing the net on a 50 mhz
> 68060. Hearing about 500mhz machines that skip is somewhat.. odd.

Ian, I came from Amiga to Linux many moons ago, and their target are
very different... on Amiga, the mouse pointer is drawn as a hardware
sprite (same as an C64 or an arcade machine), and the mouse
movement counters are handled in hardware too, so your mouse pointer
can't _EVER_ get laggy.

The sound system is very different, on Amiga you ask the system to
callback to you when audio needs replenishing, and anyways you could
boost the player priority so that multichanel or mp3 playing gets more
priority than other tasks. I can recall playing mp3 on a 68030/50
and having to boost the player's priority so that it would get no
skipping. As you probably know 68060 machines, even if at the same mhz,
have about 8x raw calculation power.

So, I also feel very bad about linux when my audio skips on my 900mhz
machine and I see reports that it does the same on 2400mhz ones, but I
can understand that the general design and target is not the same...
Amiga was _designed_, both software and hardware wise, for realtime
while Unix and thus Linux is designed for multiuser timesharing.

All that said, having a mp3 decoder as a kernel module reading from 
mlocked ram would a great way to have Amiga-like music replaying ;)

Geert, perhaps you could tell us how linux music playing feels
for a desktop m68k machine? 

[ I'm CCing you since you are the only one from the m68k port    
  which I can see posting on a regular basis.]

> And afair it has no real interactivity estimator. 
> 
> (If you are interested you can always search for Executive on aminet..
> It has several scheduler policies including those that work great on
> small machines (25mhz or so))

For those with no Amiga background, the original Amiga task scheduler
can be assumed to work like linux' RR_REALTIME scheduler with 80ms
timeslices. Important system tasks such as filesystems, disks and input
device handlers ran each on it's own task (shared memory microkernel
design) with adjusted priorities, and then all user-initiated tasks,
window manager included, ran with default priority zero.

[for more info, there are great discussions about Amiga-internals on
very early posts to linux-kernel / linux-activists from about 1991/1992
timeframe]

If the user or a program decided so, it could _always_ change a task
priority to upper or lower levels, which is what I did to my mp3 player
to avoid skips on my under powered machine (mp3 playing used 85%cpu) ;).

"Executive" was an application which patched the Amiga scheduler and
hooked up a priority manager. By altering task' priorities, it managed
to get the standard round-robin scheduler to behave like a feedback one.
(Executive was _G_R_E_A_T_ :)))

Executive was configured to never touch tasks with elevated priorities,
so in fact all user tasks would get the feedback scheduler but system
drivers such as keyboard input system would continue running as realtime
round-robin.
 
> > > Since it's rescheduled after a short runtime or, might be.
> > > From someones mail i saw (afair), there was much more context switches
> > > in 2.6 than in 2.4. And each schedule consumes time and cycles.
> > 
> > Context switches (as in process to process changes) should be about the
> > same?
> 
> Apparently they are not... I should have saved the link...
> 
> > Interrupt frequency has gone up in x86 (1000 vs 100).  Maybe that is
> > what they are seeing.
> 
> I dunno, i didn't pay that much attention and i can't find it now =P
> 
> > > Oh yes, but otoh, if you are really keen on the latency then you'll do
> > > realtime =)
> > 
> > Agreed.  But at the same time, not every "interactive" task should be
> > real-time.  In fact, nearly all should not.  I do not want my text
> > editor or mailer to be RT, for example.
> 
> Well, there is latency and there is latency. To take the AmigaOS
> example. Voyager, a webbrowser for AmigaOS uses MUI (a fully dynamic gui
> with weighted(prioritized) sections) and renders images. It's responsive
> even on a 40mhz 68040 using Executive with the feedback scheduler.
> 500 mhz is a lot of horsepower when it comes to playing mp3's and
> scheduling.. It feels like something is wrong when i see all these
> discussions but i most certainly don't know enough to even begin to
> understand it. I only tried to show the thing i thought was really wrong
> but you do have a point with the runqueues and timeslices =P
> 
> > They just need a scheduling boost.
> 
> imho, that shouldn't really be needed... =P
> (although executive apparently had a pri boost for active window... I
> doubt that i ran with it though... Been a while =))

Yes, it added +1 to the task which owner the active window
(this is also used in Windows if I recall correctly). But even without
this "hack", both executive-enabled and standard systems ran great.
 
Greets, Antonio.
