Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261696AbREYTMF>; Fri, 25 May 2001 15:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261715AbREYTLz>; Fri, 25 May 2001 15:11:55 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:25311 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261696AbREYTLw>; Fri, 25 May 2001 15:11:52 -0400
Message-ID: <3B0EAEF8.BEB5055@redhat.com>
Date: Fri, 25 May 2001 15:14:00 -0400
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: aaronl@vitelus.com, acahalan@cs.uml.edu, linux-kernel@vger.kernel.org
Subject: Re: Fwd: Copyright infringement in linux/drivers/usb/serial/keyspan*fw.h
In-Reply-To: <200105251702.KAA23819@adam.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" wrote:
> 
> Doug Ledford wrote:
> >"Adam J. Richter" wrote:
> 
> >>         On the question of whether this is nothing more than
> >> aggregation,
> 
> >Yes, on that very question, I would argue it is a mere aggregation.
> 
> >> the firmware works intimately with the device driver to
> >> produce a unitary result.
> 
> >Irrelevant.
> 
>         The 1991 Abridged 6th Edition of _Black's Law Dictionary_
> defines "aggregation" thusly (unfortunately, talking in terms of
> patent law, but it is the most authoratitive definition I have found
> so far):
> 
>         Aggregation: The combination of two or more elements in patent claims,

So the first thing the attorney would have to do is convince the judge that
the definition of a term from patent claims means what you are claiming it
means in software licensing claims.

>         each of which is unrelated and each of which performs separately and
>         without cooperation , where combination does not define a composite
>         integrate mechanism.  Term means that the elements of a claimed
>         combination are incapabile of co-operation to produce a unitary
>         result, and in its true sense does not need prior art patents to
>         support it.
> 
>         If you want to argue that a court will use a different definition
> of aggregation, then please explain why and quote that definition.

Why is because the definition you have been pushing here is anything that
results in a "unitary" result.  That's flawed (it's actually quite insane
IMNSHO, since the major point of my last email was that *damn near everything*
in the computer world results in a "unitary" result, including the glibc ->
kernel syscall interface Larry mentions in his email, the module loading
interface that the kernel exports, etc.  The point of my last email was
largely that what you are calling a "unitary" result, is in fact what most
people call an API).  To quote Larry, it would take roughly 30 seconds to get
that definition of "unitary" result thrown out as overly broad.

>  Also,
> it's important not to forget the word "mere."  If the combination is anything
> *more* than aggregration, then it's not _merely_ aggregation.  So,
> if you wanted to argue from the definition on webster.com:
> 
>         1 : a group, body, or mass composed of many distinct parts
>             or individuals
>         2 a : the collecting of units or parts into a mass or whole
>           b : the condition of being so collected
> 
>         You have to argue that absolutely nothing more than this
> is being done.  For example, the code the parts are not working
> together.

Yep, that's pretty much what it is.  The firmware is what actually implements
the API on the device we are discussing.  The driver interacts via said API. 
The firmware is actually an opaque object that could be replaced with any
other firmware that implements the same API and things would work the same. 
The downloading of the firmware is just one step in the initialization of the
device and is not dependant on any given firmware version or release.  The
placing of the driver that downloads any valid firmware to the device (or
invalid for that matter) and the firmware itself in the same .o is a matter of
convenience and is merely collecting two individual parts into a mass.

> >All drivers work with some sort of firmware on their respective
> >targets to produce a unitary result, even if that firmware is implemented with
> >silicon (as a ROM BIOS that loads the proper firmware code, or as
> >microcode/state hardware built into the chip(set) itself).  As a closely
> >similar device, think about the 1542 SCSI controller.  [...]
> 
>         Yes.  It would also be illegal to distribute a GPL'ed driver
> .o that #include'd that proprietary firmware.
> 
> >>  You actually have to do some
> >> kernel development to remove the
> >> [proprietary firmware from the keyspan_usa drivers].
> 
> >That's because you are assuming that uploading garbage to the device is not an
> >option.
> 
>         No.  If I you change the driver to upload garbage, your
> userland loader that just looks for the unitialized device ID will
> not be able to get to the uninitialized device before the device
> driver claims the interface and trashes it.  So, your supposed act of
> disaggregation by zeroing out the effected bytes did not fully
> restore the old functionality.

You missed the point.  The firmware is an opaque object to the driver, not an
integral part of the driver.  Read above.

> >That is exactly the case.  The only change that must be made to remove that .h
> >file from the driver source is to tell the driver where the *new* location of
> >the correct firmware is.
> 
>         What do you mean "remove the .h file" from the .o and
> "tell the driver" (open your mouth and talk to the screen?).

The current driver knows where the firmware is by #include'ing it in itself. 
That is, in and of itself, a means of locating the firmware.  You could
replace that with a code snippet that loaded the firmware from a file on disk
or on an initrd and read it into the same data format that the .h file
presents the firmware in.  That would, in effect, tell the driver the new
location of the file (you would again have the location hard coded in the
driver).

> We are talking about a .o file.  Copying the .o file is the
> act of infringement.

And while that's an interesting topic, my original statement, and the only one
I am arguing, is whether or not the .o is a mere aggregation or is it
something more.

>         Also, if you're going to respond further, please also
> answer the following question.  Are you claiming that the FSF intended
> to allow a GPL'ed .o file that contains proprietary firmware for another
> microprocessor or are you claiming that FSF made a drafting error in
> the writing the GPL?

While I may be moderately intelligent, I am not Ms. Cleo, and me and my Tarrot
cards are having a hard time discerning an intent on the part of the FSF.  Why
don't you ask them since they are the only ones that can explain their own
intent.  Or better yet, who cares about what their intent was, what matters is
what is actually written in the license and how a court will interpret that
license.

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
