Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315406AbSEYVQ3>; Sat, 25 May 2002 17:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315411AbSEYVQ2>; Sat, 25 May 2002 17:16:28 -0400
Received: from relay04.valueweb.net ([216.219.253.238]:7431 "EHLO
	relay04.valueweb.net") by vger.kernel.org with ESMTP
	id <S315406AbSEYVQS>; Sat, 25 May 2002 17:16:18 -0400
Message-ID: <3CEFFEA9.7CBD5801@opersys.com>
Date: Sat, 25 May 2002 17:14:17 -0400
From: Karim Yaghmour <karim@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: Wolfgang Denk <wd@denx.de>, linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
In-Reply-To: <20020525110208.A15969@work.bitmover.com> <20020525182617.D627E11972@denx.denx.de> <20020525114426.B15969@work.bitmover.com> <3CEFEB73.5BB2C14C@opersys.com> <20020525133637.B17573@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Larry McVoy wrote:
> A couple of points.  If you are going to rewrite, then you should rewrite.
> I'm told, and I've seen, that there substantial parts of RT/Linux in the
> RTAI source base.  Isn't it true that RTAI used to be called "my-rtai"
> and the guy who did that work freely admitted that it was a fork of the
> RT/Linux source base?

Well, this is standard Victor FUD. He's been repeating this to everyone with
an ear to listen. He has yet to show us a single line of code which is
supposidely taken from RTLinux. But just to satisfy the curiosity of those
who may beleive this sort of stuff, I'm including below an email I had
sent to Victor (+ CC the rtl-advocacy mailing list) about _explicit_ copyright
violations within RTLinux. It should be an interesting read.

Note that the attached email was never answered.

Again, if anyone cares to show the RTAI team actual lines of code that
match between RTLinux and RTAI, we'll be glad to investigate. Until then,
this whole issue remains a classic case of FUD againt RTAI.

> Second, that's what patents are all about, it's about protecting your
> investment.  I think you should get used to dual use licensing of patents,
> I expect to see a lot more of this as people start to realize that giving
> away the software and hoping that people will magically give you money
> just doesn't work.  There are a lot of people who value free software,
> want to support it, and will do so if it is really free.  On the other
> hand, as soon as money enters the equation, the rules will change and
> you're just going to have to deal with that.

You're just trying to justify the continued existence of the software
industry. My belief is that the existence of large enterprises that sell
software (whether they sell copyright licenses for it or patent licenses
for, it's the same business model) is very much questionnable at this point.

Here's for the email I mentionned:
<mail entitled: More from the history department ...>
Just for those who may have believed Victor's claim on the rtl-advocacy
list that I wasn't honest and those of you on the RTAI mailing list who
want to know how come the RTAI folks don't really like what Victor is doing,
I've added some interesting historic tidbits from the RTLinux mailing
list.

This stuff dates back to 1997 and at the time the RTLinux mailing
list was still on NMT's server, management of RTLinux's code was still
in Michael's hand (but this just on the point of changing), VJY associates
(which later became FSMLabs) wasn't in the picture, RTLinux was still
a big kernel patch instead of a modularized package (it later became
modularized after ...), Victor was still a professor at NMT, and lots
of contributions were being sent from left and right both privately
and publicly.

So here's for history's sake:

Here's a reply by Michael Barbanov to Paolo's message regarding the
periodic mode of the 8254 (date: Fri 18 Apr 1997):
--------------------------------------------------------------------------
In message <199704180908.DAA03790@charon.cs.nmt.edu>, Prof. Paolo Mantegazza wrote:
>Rt-linux is really nice in that it allows to gain an easy access to the 
>hardware while keeping the services of linux. However the timer shooting 
>technique adopted, while being extremely flexible, requires to much i/o time 
>to program the 8254. Is it correct that each i/o blocks the bus for 1 to 1.5 
>microseconds?. In fact I did not get anything better than the performance 
>cited in rt-linux accompaning paper even by using a 200Mhz PentiumPro 
>against a 120 Mhz Pentium. This seems to be confermed by R. Wilhelm recent 
>mail. In control and data acquisition problems where there is always a high 
>frequency master periodic task at high frequency and precise timings the 
>usual mode 2 programming requires just the EOI output of the timer isr and 
>should lead to improve performances. In this view I have modified rt_time.c 
>and rt_prio_sched.c and it seems that the performances can increase 
>substantially. In fact the rect_wawe test can be run with a 10 us ticking to 
>give a 50Khz neat squarewave, 1 ns uncertainty, while operating the X 
>environment with somewhat sluggish but acceptable, it can depend on your 
>idea of acceptable, performances. So if one can accept a fixed time 
>resolution that can be an alternative approach. Comments are welcomed. Warm 
>thanks again to rt-linux fellows for their work. I think that the 
>possibility of adding a user layer within the kernel made possible by the 
>way thay have handled the interrupts will be usefull for many other 
>applications. 
>Greeting, Paolo.

Yes, it's true that the programming of the 8254 timer takes a lot of time (I
think each outb takes even more than 1.5us). The use of mode 2 (periodic
interrupts) can be reasonable for some applications.  
--------------------------------------------------------------------------
Notice that peridic mode wasn't in RTLinux, but it was explained by Paolo
and implemented by Paolo first.



But wait, here's more:

This message was sent by Paolo in response to a question by Michael on
how to simulate Linux timer interrupts (date: Tue 22 Apr 1997):
--------------------------------------------------------------------------
>How do you simulate Linux timer interrupts, BTW?
Dear Michael, 
below you'll find the code of my scheduling and timer handler functions. (I 
know that are not in good C code). Yuo can notice that I make delayed task 
ready only in the timer handler which also does the usual scheduling, 
rt_schedule switches only among ready tests. I have added a kind of 
signalling in that every time a task is rescheduled it calls a signal 
function that can enable interrupts. So the Linux timer is fired from your 
basic timer isr routine if it returns with SFIF enabled after the time 
interrupt or by simply using sti() in the signa_linux_timer function when 
Linux is rescheduled. This seems to work or at least it works with your 
testings and in my opinion it should be correct. If you have any comment or 
find the approach faulty for more general applications please advice me so 
that I'll avoid loosing time. In fact, as you'll notice from the code, I'm 
designing semaphore, messages and rpc within rt-kernel, and I want to avoid 
building on a sand foundation. Also notice that the code of my modifications 
is available, anybody interested, with a good heart and willingness to take 
the risk should let me know and I'll provide it as it is. I have no web or 
ftp service available. A lot of testing is still needed for a full 
implementation. 
Paolo.

static void rt_schedule(void)
{
        RT_TASK *task;
--------------------------------------------------------------------------
In this case, Paolo sent a big chunck of code. Wonder what became of this
code Paolo sent to Michael ... ???


Here's Paolo's first mention of what would later be know as RTAI
(date: Mon 9 Jun 1997):
--------------------------------------------------------------------------
Is there anyone interested in a different rt_sched module implementing the 
following functions?
extern int rt_task_init(RT_TASK *task, void (*rt_thread)(int), int data,
                                int stack_size, int priority, int uses_fpu,
                                void(*signal)(void));
extern int rt_task_delete(RT_TASK *task);
extern void rt_save_init_fpu(void);
extern void rt_restore_fpu(void);
--------------------------------------------------------------------------
The mail goes on to provide an extensive list of functions.



Here's an e-mail discussing the FPU problems I mentionned RTLinux had
and how Paolo was the first to implement the solution and to provide
code (date: Tue 18 Nov 1997):
--------------------------------------------------------------------------
Till Christian Sering Replied to the idea of setting linux as an FPU rtlinux 
task as follows:
>Hi,
>
>did I get it right. Your solution would be to assume linux is using the
>FPU by default and thus the linux task must be marked as using the FPU.
>Sounds like a very good solution to me - but is it right,that FPU
>exceptions generated in rtlinux still need to be handled in rtlinux?
>
>Greetings,
>
>    Till!

This is the solution I implemented in my variant of rtlinux, that can be 
easily adapted to the official release as well. I do not care to serve the 
FPU execeptions. In fact my idea is to program the FPU to discard them in 
the user module which must contain all the tests needed to avoid FPU 
exceptions in advance during the debug phase, stripping the redundant ones 
off when every thing works o.k. Clearly it is not a very brilliant solution 
but has solved my problems so far. I think that FPU exceptions in real time 
applications, e.g. control, should not happen as they are an indication that 
something has gone out of control. In any case my opinion is that real time 
FPU exception services should be slimlined and in the rtkernel. 
Ciao,
Paolo.
--------------------------------------------------------------------------
Again, Paolo was the first to implement and RTLinux followed ...


And Victor, Please explain the following:

The RTLinux fifo code used to have the following copyright header:
  /*
   * RT-FIFO devices
   *
   * 1997, Michael Barabanov
   *
   * A lot of this code is stolen from fs/pipe.c
   *
   */

Notice the last phrase ... :

Now, checkout the new license:
/*
 * (C) Finite State Machine Labs Inc. 1995-2000 <business@fsmlabs.com>
 *
 * Released under the terms of GPL 2.
 * Open RTLinux makes use of a patented process described in
 * US Patent 5,995,745. Use of this process is governed
 * by the Open RTLinux Patent License which can be obtained from
 * www.fsmlabs.com/PATENT or by sending email to
 * licensequestions@fsmlabs.com
 */
/*
 * Includes a tiny bit of code from Linux fs/pipe.c copyright (C) Linus Torvalds.
 *
 */           

Somehow, the "A lot of this code is __stolen__ from fs/pipe.c" got
changed to "Includes a tiny bit of code from Linux fs/pipe.c".

Amazing what a little change of words will do ...

Tell me now Victor, are you selling the the fifo code in closed-source?
Because if you are you now owe Linus Torvalds and all the other contributors
to the file royalties on every closed-source copy you sold. That is,
if they agree to their code being sold.

And what about all the code Paolo submitted? You owe him royalties too
don't you?

As I said, there is plenty of this stuff in RTLinux. So please Victor,
next time you accuse others of lacking honesty I suggest you follow
Michael's advice and look at your own eye first.
</mail entitled: More from the history department ...>

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
