Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S145191AbRA2FDG>; Mon, 29 Jan 2001 00:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S145192AbRA2FCp>; Mon, 29 Jan 2001 00:02:45 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:6924 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S145191AbRA2FCf>;
	Mon, 29 Jan 2001 00:02:35 -0500
Date: Sun, 28 Jan 2001 22:02:08 -0700
From: yodaiken@fsmlabs.com
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: yodaiken@fsmlabs.com, Nigel Gamble <nigel@nrg.org>,
        Paul Barton-Davis <pbd@Op.Net>, Andrew Morton <andrewm@uow.edu.au>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        linux-audio-dev@ginette.musique.umontreal.ca
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0
Message-ID: <20010128220208.A12032@hq.fsmlabs.com>
In-Reply-To: <200101220150.UAA29623@renoir.op.net> <Pine.LNX.4.05.10101211754550.741-100000@cosmic.nrg.org> <20010128061428.A21416@hq.fsmlabs.com> <20010128060704.A2181@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <20010128060704.A2181@gnuppy.monkey.org>; from Bill Huey on Sun, Jan 28, 2001 at 06:07:04AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 28, 2001 at 06:07:04AM -0800, Bill Huey wrote:
> 
> On Sun, Jan 28, 2001 at 06:14:28AM -0700, yodaiken@fsmlabs.com wrote:
> > > Yes, I most emphatically do disagree with Victor!  IRIX is used for
> > > mission-critical audio applications - recording as well playback - and
> > And it has bloat, it's famously buggy, it is impossible to maintain, ...
> 
> However, that doesn't fault its concepts and its original goals. This
> kind stuff is often more of an implementation and bad abstraction issue than
> about faulty design and end goals.


That's the core of the disagreement. I think SGI had some really good
engineers who have worked very hard - but that hard work and good
programming can never compensate for bad design. I think Linux works so
well because it's been designed well -- and good design often means
refusing to go down a path that is known to seemingly invariably
lead to failure. HP-UX, IRIX, Masscomp ... -- all these guys have
tried this "concept" and all have had some sucess, but at a 
very high price.
 

> 
> > > used.  I will be very happy when Linux is as good in all these areas,
> > > and I'm working hard to achieve this goal with negligible impact on the
> > > current Linux "sweet-spot" applications such as web serving.
> > As stated previously: I think this is a proven improbability and I have
> > not seen any code or designs from you to show otherwise.
> 
> Andrew Morton's patch uses < 10 rescheduling points (maybe less from memory)
> and in controlled, focused and logical places. It's certainly not a unmaintainable
> mammoth unlike previous attempts, since Riel (many thanks) has massively
> cleaned up the VM layer by using more reasonable algorithms, etc...
> 

Andrews' patch has grown, but sure, I think he is doing good work.

> > I suggest that you get your hearing checked. I'm fully in favor of sensible
> > low latency Linux. I believe however that low latency  in Linux will
> > 	A. be "soft realtime", close to deadline most of the time.
> 
> Which is very good and maintainable with Andrew's patches.
> 
> > 	B. millisecond level on present hardware
> 
> Also very good an useable for many applications short of writting dedicated
> code on specialized DSP cards.
> 
> > 	C. Best implemented by careful algorithm design instead of 
> > 	"stuff the kernel with resched points" and hope for the best.
> 
> Algorithms ? which ones ? VM layer, scheduler ?  It seems there's enough
> there in the Linux kernel to start doing interesting stuff, assuming that
> there's a large enough media crowd willing to do the userspace programming.
> 
> > > for low-latency tasks.  RTLinux is not Linux, it is a separate
> > > environment with a separate, limited set of APIs.  You can't run XMMS,
> > > or any other existing Linux audio app in RTLinux.  I want a low-latency
> > > Linux, not just another RTOS living parasitically alongside Linux.
>  
> > Nice marketing line, but it is not working code.
> 
> Mean what ? How does that response answer his criticism ?
> 

RTLinux is not intended to be another Linux - one Linux is enough
(and one IRIX is too many!). What 
RTLinux does is, essentially, add a special realtime process to
Linux and let applications in this "process" be written as threads
and signal handlers. The environment is specifically made to be
"restrictive" and programmers are encouraged to put non-realtime 
components in Linux and only put timing critical stuff in the RT
process. So complaining that the RTLinux environment is not 
the Linux environment is rather silly and akin to a complain that
you can't call shell scripts from driver code. Different environments
serve different purposes. The engineering claim behind RTLinux is that
while many attempts to integrate hard realtime into general purpose
OS's have produced large buggy, slow, and compromised OS's, the
RTLinux model provides a simple software design that offers reliable
hard realtime without screwing up the internals of the general
purpose OS. In fact, I argue that it's a mistake to integrate
hard realtime and non-realtime code in applications as well. 
So I think that the argument "we should have hard realtime in 
an integrated environment" is like arguing  "we should have fast cornering,
and instant acceleration in a moving van". If you don't like my 
sports car because it does not come with air brakes and a trailer, 
show me how it's possible to accomplish both design goals: but don't
simply "marketize" about how inferior the sports car is because it
is missing moving van features. 



> bill

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
