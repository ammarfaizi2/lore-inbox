Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316994AbSGIQ62>; Tue, 9 Jul 2002 12:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316836AbSGIQ5p>; Tue, 9 Jul 2002 12:57:45 -0400
Received: from port154.cvx2-mal.ppp.netlink.se ([62.66.13.155]:21998 "EHLO
	tix.pir.eli") by vger.kernel.org with ESMTP id <S316679AbSGIQ5k>;
	Tue, 9 Jul 2002 12:57:40 -0400
Date: Tue, 9 Jul 2002 19:07:37 +0200
From: Daniel Mose <imcol@unicyclist.com>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: simple handling of module removals Re: [OKS] Module removal
Message-ID: <20020709190737.A27421@unicyclist.com>
Mail-Followup-To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20020705134816.GA112@elf.ucw.cz> <9171.1026053813@ocs3.intra.ocs.com.au> <20020708030532.A8799@unicyclist.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <20020708030532.A8799@unicyclist.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Mose wrote:
> Keith Owens wrote:
> > On Fri, 5 Jul 2002 15:48:17 +0200, 
> > Pavel Machek <pavel@ucw.cz> wrote:
> > >Keith Owens wrote
> > >> Modules can run their own kernel threads.  When the module shuts down
> > >> it terminates the threads but we must wait until the process entries
> > >> for the threads have been reaped.  If you are not careful, the zombie
> > >> clean up code can refer to the module that no longer exists.  You must
> > >> not freeze any threads that belong to the module.
> 
> I am just out to share a possible angle. -all though not really a programmer.
> 
> Can one module replace another -running- twin-module without having to hand-
> shake with the kernel? -and without freezing ? (transparently)
> 
> If obvious no - no need to read further.
. . .

As some conversations have implied rently in the thread, that it would be 
possible to disconnect,and re-connect the original module - This might also be.

But I will not pretend that I know anything. Just trying to use a bit of wits
It is only an angle. And I'm not exactly boored with Ansi-drawing.

HWclock.
>-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=->-=-=-=-=-=-=-=-=-
1.    				2.			    3.
  derivate.o==== |L            derivate.o====#|L  100kB    derivate.o====|L=#	
    | G'day!     |i @            A           |i  @   in       |Bye!      |i @
    V		 |n #  1MB       | Up2date?  |n      use      V          |n 
realmodule.o=====|u=#@  in   realmodule.o====#|u=#       realmodule.o=== |u
                  x     use                       x                          x
HWclock.
>-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=->-=-=-=-=-=-=-=-=-
4.    	 Users=0?              5.    Users=0?		 6.    Users=0?
/dev/0<<-derivate.o=<<=|L# /dev/0xx derivate.o xx|Lx /dev/0<<derivate.o====|L#
              \_EOT=>>=|i#@           Me uglu!>>#|i#@      >> Me brken!=>>=|i#@
                       |n                        |n                        |n
    ( re lm dule.o )== |u         r  lm d l .o   |u                d l .   |u
                        x                         x                         x		
HWclock
>-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=->-=-=-=-=-=-=-=-=-
7.                                            8.             
                  n         n         n                        |L
derivate.o x|x    i u	>   u i   >   i u             - \ -    |i
I am 0+!         L   x     x   L      L x                      |n
                                                               |u
                                                                x

No this is not really what happened or?.

Actually what can happen is <of course anything>, but hopefully that the "real"
module is removed safely and replaced by a dummy permanently, or until another 
module (maybe the original "real" module) is loaded back into the kernel.
Perhaps the kernel doesn't get to free all of the memory pages that were 
allocated to the "real" module, But the original module is gone, which is what 
was desired, no?  The dummy should probably be designed to be able to answer 
kernel processes in a sort of lame way (rest easy), as well as to listen for
user processes, to deny them acess, if it is not able to unload completely.

I think of this as both a workaround And a design issue. Dummy modules is
not something new. It has been (and is) used to trick kernel processes before.
(and now)

With dummy modules you will probably not have to risk either the functionality 
of the kernel it self, while running, by severe re-programming, opening up new 
possible bug holes, nor the Real, original modules brilliant functionality that
we might want to unload just to momentarily NOT achieve this purpose.

There is just one BIG issue here as far as I'm concerned. 

I Don't know if theese are relevant thoughts or not, since I lack SeVereLy in 
Experience of Linux processing shapes, and communication features. 
So I'm fumbelling more than just a bit here.

(But at Least I'm not having High school summer classes in Fundamental C 
programming rules on Linux-kernel Mailing list. ;-). 
No one named or forgotten.)

I use rmmod  as a security feature at home. What the kernel don't know about, 
it can't reveal to possible intruders -right? So I use a ping script, and 
mailto, to unload eth0 from one of my lan boxes, while dialing on line, so 
I really DO load and UN-load modules all the time. ( 2.2.12 )

---

Image:

- makes sure u make sense.
