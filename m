Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264127AbTFKE06 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 00:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264126AbTFKE06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 00:26:58 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:56327 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP id S264127AbTFKE0U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 00:26:20 -0400
Date: Tue, 10 Jun 2003 22:39:21 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Stephan von Krawczynski <skraw@ithnet.com>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: linux-kernel@vger.kernel.org, willy@w.ods.org, marcelo@conectiva.com.br,
       green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-ID: <41560000.1055306361@caspian.scsiguy.com>
In-Reply-To: <20030611025147.04ecb2bd.skraw@ithnet.com>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>	<2804790000.1052441142@aslan.scsiguy.com>	<20030509120648.1e0af0c8.skraw@ithnet.com>	<20030509120659.GA15754@alpha.home.local>	<20030509150207.3ff9cd64.skraw@ithnet.com>	<144290000.1055268419@caspian.scsiguy.com> <20030611025147.04ecb2bd.skraw@ithnet.com>
X-Mailer: Mulberry/3.0.3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 99% of the problems have to do with broken interrupt routing.  There is
>> plenty of information about this issue on the mailing lists, but people
>> still ask me.
>
> You should state an exact definition of "broken interrupt routing" in this
> case. The only thing I would call a broken interrupt routing is if an
> interrupt does not show up at all.

That's the only definition for it and 99% of the email I field about
the aic7xxx driver is due to interrupts *not arriving*.

>> I just don't believe that this is true.  Most of the questions that people
>> email me directly are questions that are easily answered by a google search.
>> In otherwords, the information is already readily available.  It is just
>> easier to send email than to actually investigate a potential solution
>> to the problem.  So, people send email and ask the same questions, and
>> get the same answers.
>
> Do you have a FAQ?

It's the driver readme file.

>> You're the one being silly.  You are oversimplifying what it takes to
>> do I/O and the components that are involved in doing that I/O.  If you
>> don't understand that the load on several components in the kernel changes,
>> often in subtle but important ways, when you change the target of your
>> I/O, then I don't know what to say to you.
>
> Data corruption is nothing subtle. We are not talking about performance tweaks,
> we are talking about the basics. Something like "a synchronous action (like
> reading during a verify) has to be synchronous". We are not talking about a
> hardware related problem on scsi bus. We are not talking about the box
> stumbling over a massive data flood. We are talking about reading a file/device
> to a memory buffer and doing a cmp action between two of those. If your os is
> not able to perform something like this you can do virtually nothing, not even
> booting (because your reading action corrupts the data).

And with any experience you will find that subtle races in all of these
"basic operations" can often only be triggered by certain scenarios.  Saying
that "well my machine boots" is not enough to prove that the components
involved to that point are bug free.  You may be able to operate just
fine in 99% of your test scenarios yet still have a very catastrophic
flaw in the code.

>> >> >>  When testing our drivers against RHAS2.1 we found that the stock
>> >> >> kernel had data corruption issues very similar to what your are talking
>> >> >> about when run on very fast, hyperthreading, SMP machines.  The data
>> >> >> corruption occurred with any SCSI controller we tried, regardless of
>> >> > vendor.
>> >> >
>> >> > My question is: is it solved?
>> >>
>> >> My understanding is that it was fixed in 2.4.18 level kernels, but since
>> >> I don't know the root cause of the corruption, it could have just been
>> >> made more difficult to reproduce.
>> >
>> > Can you point to some URL where information about this is available?
>>
>> https://rhn.redhat.com/errata/RHSA-2003-147.html
>
> The scenario described there is unlikely for my case because
> a) I have only 3 GB of mem
> b) no hints are available that UP can solve the problem on the same hardware

This is only the latest corruption bug that has been addressed.  You
should really read all of the kernel erratas.  The one we hit originally
was this one:

https://rhn.redhat.com/errata/RHSA-2002-227.html

I'm not saying that this is your problem or even related, but just to
point out that the type of data corruption you are talking about can
occur due to bugs in core kernel functionality.

>> To reproduce your problem, I need the same MB, memory configuration, drive
>> types, a 3ware card, and the same tape drive you have.  I have tried various
>> backup scenarios with *other hardware* and have failed to reproduce your
>> problem.
>
> I have talked to others with similar problems and none has the same mb or a
> 3ware controller.

Define similar.  You are the only person I know of that is currently
indicating they are having *data corruption* with the aic7xxx driver.
That is, in particular, what I am trying to reproduce locally.

> All have problems with streamers on aic. All solutions I
> heard so far were done by replacing aic by whatever strange controller
> they got their hands on.

I'm glad they were able to resolve their problems.

>> >> I suggest you go browse the code that is exercised by such an activity
>> >> before you say that.
>> >
>> > What kind of a statement is this?
>>
>> Its one way of saying that you need to understand all of the code involved
>> with turing a write syscall into a call into the aic7xxx driver.  If you
>> review the code path, you'll find that there are thousands of lines of
>> code involved that have nothing to do with SCSI or the aic7xxx driver.
>> To say that you have created a simple example that proves that the problem
>> is in the aic7xxx driver is naive at best.
>
> To tell me it is not is just as good.

You mean "just as naive"?  Pointing your finger at the aic7xxx driver
is not going to solve your problem.  Ruling out other system components
(of which there are many in your test case) also won't help find it.

>> In this case, the information you have so far provided points away from
>> the aic7xxx driver.  I don't say that in all cases that I investigate,
>> but I believe it to be true in this case.  If past experience is any guide,
>> 80-90% of the problems like this that I have debugged (and that I could
>> actually replicate) were induced by using the aic7xxx driver, but turned
>> out to be bugs in other components in the system.  The aic7xxx driver
>> happens to be one of the more agressive SCSI drivers in the system and
>> that can often lead to finding bugs in other components.
>
> Agressive is indeed a good term for it. And it describes exactly what I don't
> like about it.

Then don't use choose to use it.

> The primary goal of a driver (in my eyes) is to make some
> connected hardware work as expected. It is definitely not its primary goal to
> be overly brilliant and therefore detecting bugs in other subsystems.

My goal is to take full advantage of the hardware I support in my drivers.
That isn't an attempt to be "brilliant", but rather just taking advantage
of the hardware you have purchased.  The end result is that for instance
the aic79xx driver can achieve sustained random I/O throughput 40% above
it's main competetor.  That isn't an attempt to break the rest of linux,
but to get the most performance possible out of Linux.

> I have
> told you months ago that a symbios driven systems feels somehow smoother and
> faster - elegant.

Which doesn't tell me anything about the relative performance of the
two drivers.  Such subjective remarks do not provide any feedback that
can be turned into a concrete plan to improve the driver.  They don't even
really tell me what you think is wrong with it.

> And btw: you win nothing with your way, not even performance.

Another unsubstantiated claim.  Again, if you don't like the driver, or
its style, you should just use something else if it will make you happier.
It certainly sounds like that is the case.

>> I have lots of test setups that show the aic7xxx and aic79xx driver working
>> just fine in PIII and P4 dual and quad configurations with and without apic
>> interrupt routing and writing to tape.
>
> This does only mean you have not yet met something similar to my setup. It
> does not really prove a lot.

Which is exactly my point!  You act as though I should be able to magically
reproduce and fix your problem.  I've said that I can't reproduce it and
that means I can't fix it without more information.  I never claimed anything
more than that other than your current data points do not, in my opinion,
point to an aic7xxx driver problem.  That doesn't *eliminate* the aic7xxx
driver as a cause just as your test cases don't eliminate the other
components of the system.

> Well, the thing is, I try to achieve information. But since the whole issue is
> all about lots of data I try to find an intelligent way to locate the cause of
> it all. I am not very confident that analysis of the trashed data will lead
> somewhere.

If you filter all available to what you only believe will be relavent to
solving the problem, then you will likely filter out things that might
give others a clue as to the true cause of your problem.

> I think narrowing the code path that leads to the problem by
> multiple distinct test scenarios looks more/faster promising. Can you think of
> something reducing the test complexity (not using tar, not comparing to a file
> or whatever)?

I would be analyzing the current failure modes first, but if you just want
to try to narrow the cause by varying your configuration, you could do
that by using a different source filesystem or even using /dev/zero or
a program that generates the data that will be written to tape.  You might
also try to determine if the corruption happens when the tape is written
or if the data is corrupted during the read.  You could do this by
doing multiple read sessions to see if the corruption is consistent or
doing the write in what appears to be a safe kernel mode and the read
in the unsafe kernel and vice - versa. Etc.

--
Justin

