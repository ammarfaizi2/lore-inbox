Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRA2Rix>; Mon, 29 Jan 2001 12:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129101AbRA2Rin>; Mon, 29 Jan 2001 12:38:43 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:34316 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S129051AbRA2Rie>;
	Mon, 29 Jan 2001 12:38:34 -0500
Date: Mon, 29 Jan 2001 10:38:10 -0700
From: yodaiken@fsmlabs.com
To: Joe deBlaquiere <jadb@redhat.com>
Cc: yodaiken@fsmlabs.com, Andrew Morton <andrewm@uow.edu.au>,
        Nigel Gamble <nigel@nrg.org>, linux-kernel@vger.kernel.org,
        linux-audio-dev@ginette.musique.umontreal.ca
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0
Message-ID: <20010129103810.D3037@hq.fsmlabs.com>
In-Reply-To: <200101220150.UAA29623@renoir.op.net> <Pine.LNX.4.05.10101211754550.741-100000@cosmic.nrg.org>, <Pine.LNX.4.05.10101211754550.741-100000@cosmic.nrg.org>; <20010128061428.A21416@hq.fsmlabs.com> <3A742A79.6AF39EEE@uow.edu.au> <3A74462A.80804@redhat.com> <20010129084410.B32652@hq.fsmlabs.com> <3A75A70C.4050205@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <3A75A70C.4050205@redhat.com>; from Joe deBlaquiere on Mon, Jan 29, 2001 at 11:23:24AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2001 at 11:23:24AM -0600, Joe deBlaquiere wrote:
> It doesn't matter how you do it, the cooperative model eventually starts 
> to feel like Windoze3.1 in the extreme case, but even so, it was much 
> more multithreaded than DOS. Of course, the Right Thing (TM) is to do 
> away with the cooperative model. But even in a preemptive model, there's 
> no reason to have code like

So we assume: if you have no RT threads running, Linux does the right
thing. If you have RT threads running, you want them to run no matter
what Linux does. This may be over-simple, but it's robust. 
Otherwise you end up with either (A) an impossible to verify mess
of many code components each hoping that the aggregate of the others
will behave correctly or (B) a semi-functioning high overhead centralized
priority system that slows everything down and probably does not
work anyway.

> 
> while (!done)
> {
> 	done = check_done();
> }
> 
> when you can have:
> 
> while (!done)
> {
> 	yield();
> 	done = check_done();
> }

But there is a reason for the first: time. 

while(!read_pci_condition); // usually finishes in 10us

versus

while(!read_pci_condition)yield(); // usually finishes in 1millisecond

can have a nasty impact on system performance. 

      
> 
> being preemptive and being cooperative aren't mutually exclusive.
> 
> Borrowing your sports car / delivery van metaphor, I'm thinking we could 
> come up with something along the lines of a BMW 750iL... room for six 
> and still plenty of uumph.

Not a cheap vehicle.  Linux is pretty snappy on an AMD SC420  or
a M860 and 5 meg of memory. And it scales to a quad xeon well. Don't
try that with IRIX.  
So to push my tired metaphor even further beyond
the bounds, a delivery van that needs jet fuel and uses two lanes, 
won't do well in the delivery business no matter how well it 
accelerates.



-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
