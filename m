Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbTFJRxw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 13:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263765AbTFJRxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 13:53:52 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:13068 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP id S263761AbTFJRxs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 13:53:48 -0400
Date: Tue, 10 Jun 2003 12:07:00 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Stephan von Krawczynski <skraw@ithnet.com>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: linux-kernel@vger.kernel.org, willy@w.ods.org, marcelo@conectiva.com.br,
       green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-ID: <144290000.1055268419@caspian.scsiguy.com>
In-Reply-To: <20030610191131.6c25762e.skraw@ithnet.com>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>	<2804790000.1052441142@aslan.scsiguy.com>	<20030509120648.1e0af0c8.skraw@ithnet.com>	<20030509120659.GA15754@alpha.home.local>	<20030509150207.3ff9cd64.skraw@ithnet.com>	<23050000.1055259511@caspian.scsiguy.com> <20030610191131.6c25762e.skraw@ithnet.com>
X-Mailer: Mulberry/3.0.3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I never said that it wasn't serios, I just haven't seen any indication
>> that this problem is caused by my driver.  There is a big difference.
>> If your complaint is that I typically help people to solve their problems
>> *off-list*, then I'm sorry if that offends your sensibilities.
>
> It does not offend my sensibilities, it is simply damaging the available
> information about typical problems and their solving. If you don't do it open,
> there is no way for others to follow your thoughts and debugging and therefore
> you are confronted hundred times with the same questions. People have no
> choice but asking you, because your debugging cases are hidden.

99% of the problems have to do with broken interrupt routing.  There is
plenty of information about this issue on the mailing lists, but people
still ask me.  It seems that SCSI is suitably complex for the common
user that even when the driver explictly tells you "your drive is dying",
I get email asking how I can fix my driver so that their drive doesn't
die.  The same is true if you look at the large body of dump card state
information that people have posted from the aic7xxx and aic79xx drivers
to this list.  Anyone who gets this type of output seems to think that
their problem must be the same as any other person that gets a dump
card state.  I don't think that any amount of posting information about
how I decifer what the registers are telling me will cut down on this
confusion.

>> I'm just sick of being blamed for anything that goes wrong on any system
>> that happens to have an aic7xxx controller in it.  99% or the time its
>> not my fault, but I suppose since I debug and resolve these issues off
>> list for people that contact me, the general assumption is that these
>> issues are the aic7xxx driver's fault.
>
> No, you produce your own problem. You cannot help every single who has a
> problem around his box/aic. This is impossible. So you have to create a
> valuable information basis others can read and think about. This is most
> simply done by debugging problems _openly_.

I just don't believe that this is true.  Most of the questions that people
email me directly are questions that are easily answered by a google search.
In otherwords, the information is already readily available.  It is just
easier to send email than to actually investigate a potential solution
to the problem.  So, people send email and ask the same questions, and
get the same answers.

>> >> a buffer layer bug, or a filesystem bug.
>> >
>> > /dev/tape with a filesystem? Have you read what we are talking about?
>>
>> Where did you get the data to place on the tape?  /dev/zero?
>
> Don't be silly. If reading a file from some hd would be a problem in itself,
> then we could all go home and have a beer. You are talking about the minimum
> requirement for an os.

You're the one being silly.  You are oversimplifying what it takes to
do I/O and the components that are involved in doing that I/O.  If you
don't understand that the load on several components in the kernel changes,
often in subtle but important ways, when you change the target of your
I/O, then I don't know what to say to you.

>> >>  When testing our drivers against RHAS2.1 we found that the stock
>> >> kernel had data corruption issues very similar to what your are talking
>> >> about when run on very fast, hyperthreading, SMP machines.  The data
>> >> corruption occurred with any SCSI controller we tried, regardless of
>> > vendor.
>> >
>> > My question is: is it solved?
>>
>> My understanding is that it was fixed in 2.4.18 level kernels, but since
>> I don't know the root cause of the corruption, it could have just been
>> made more difficult to reproduce.
>
> Can you point to some URL where information about this is available?

https://rhn.redhat.com/errata/RHSA-2003-147.html

This is just the most recent attempt to fix these issues.  You might
want to go back and read the other erratas.

>> > Justin, this is nothing quite serious, I just mentioned it for a feedback
>> > to something _simple_.
>>
>> It's the only thing you've mentioned that I have enough information to
>> look at.
>
> No, it is only the most simple one. Unfortunately scsi-driver development is
> everything but simple for the standard problem case. It requires the ability
> to set up equipment just like the discussed case for reproduction of the
> problem.  Of course only for cases the author cannot reproduce inside his
> software via brain.  All information needed to reproduce the main problem is
> available in this thread.

To reproduce your problem, I need the same MB, memory configuration, drive
types, a 3ware card, and the same tape drive you have.  I have tried various
backup scenarios with *other hardware* and have failed to reproduce your
problem.

>> I suggest you go browse the code that is exercised by such an activity
>> before you say that.
>
> What kind of a statement is this?

Its one way of saying that you need to understand all of the code involved
with turing a write syscall into a call into the aic7xxx driver.  If you
review the code path, you'll find that there are thousands of lines of
code involved that have nothing to do with SCSI or the aic7xxx driver.
To say that you have created a simple example that proves that the problem
is in the aic7xxx driver is naive at best.

> I want to solve a problem - for me _and_ for others (and this is
> why I do it openly).
> I really have not understood what you want, besides not being spoken to.
> If I were you I would try to _prove_ that it is _not_ my problem, in best by
> finding the real problem.

As I said before, I have tried to reproduce your problem, but I cannot.
I have no hope of proving that a problem I cannot replicate is not a
problem with my driver.

Some additional things that might help:

 o Charaterize the type of corruption that you are seeing in a more
   formal way.  For example, use an easy to verify pattern that will
   allow you to actually analyze the corruption.  Is the corruption
   following some pattern?

 o Can you determine if the corruption is happening when writting to
   the tape vs. reading from it?  You might do this by writing to
   the tape in an SMP mode that shows data corruption and then validate
   the driver in a safe, UP, mode and vice-versa.

 o What happens when you use different hardware/FS type/etc for the source
   and destination?

> Unfortunately I (and some others) do have the
> impression that you simply live by the idea that as long as nobody can
> _prove_ your code has a problem, there is no problem.
> This is in fact the bofh lifestyle that works for you (as long as you do not
> meet an equally skilled person), but not for the users (spell "rest of us").

In this case, the information you have so far provided points away from
the aic7xxx driver.  I don't say that in all cases that I investigate,
but I believe it to be true in this case.  If past experience is any guide,
80-90% of the problems like this that I have debugged (and that I could
actually replicate) were induced by using the aic7xxx driver, but turned
out to be bugs in other components in the system.  The aic7xxx driver
happens to be one of the more agressive SCSI drivers in the system and
that can often lead to finding bugs in other components.

> Back to the facts:
> Simple question: you say its not a problem inside the driver. Ok. Question:
> how to you prove that? Can you specify a test setup (program or something) I
> can check to see that there is no problem with the general SMP tape usage of
> the aic driver? I mean you must have seen something working, or not?

The only way to do this is to find the actual bug.  The problem feels like
a VM or FS race condition most likely caused by having the source controller and
the destination controller on separate interrupts in the apic case so that
you have real concurrency in the system.  In the non apic case, it looks
like everyone shares the same interrupt, so you cannot field interrupts
for both the 3ware and the aic7xxx driver at the same time.  I also say
this because data corruption is something that is very difficult for the
aic7xxx driver to acomplish without there being some kind of error message
from the driver.

I have lots of test setups that show the aic7xxx and aic79xx driver working
just fine in PIII and P4 dual and quad configurations with and without apic
interrupt routing and writing to tape.  There's not much more that I can
do here without having your exact system here or having more information.

--
Justin

