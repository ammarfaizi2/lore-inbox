Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264956AbSL1Q07>; Sat, 28 Dec 2002 11:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265098AbSL1Q07>; Sat, 28 Dec 2002 11:26:59 -0500
Received: from web13207.mail.yahoo.com ([216.136.174.192]:42112 "HELO
	web13207.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S264956AbSL1Q06>; Sat, 28 Dec 2002 11:26:58 -0500
Message-ID: <20021228163517.66372.qmail@web13207.mail.yahoo.com>
Date: Sat, 28 Dec 2002 08:35:17 -0800 (PST)
From: Anomalous Force <anomalous_force@yahoo.com>
Subject: Re: holy grail
To: Werner Almesberger <wa@almesberger.net>
Cc: ebiederm@xmission.com, linux-kernel@vger.kernel.org
In-Reply-To: <20021227083047.B1406@almesberger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Werner Almesberger <wa@almesberger.net> wrote:

> Anomalous Force wrote:
> > what if the new kernel asked the old kernel to hand over the data
> in
> > a form that was understood universally beginning at some kernel
> > version X (earliest supported kernel in other words).
> 
> Yes, and that information would ideally just be what is visible
> from user space. This gives you a well-defined abstraction, and
> limits the dependency on kernel internals.
> 
> > im thinking of something along the lines of a data packet (tcp/ip
> > comes to mind) that contains data about its data.
> 
> I guess you never looked at how much state TCP really carries
> around :-) For a rough idea, you may want to have a look at
> tcpcp (TCP Connection Passing), which does pretty much what you'd
> have to do for this kind of checkpointing:
> http://www.almesberger.net/tcpcp/

you miss my point. im not saying to model it after tcp/ip. that
was just a reference to a method of data exchange wherein the
data has metadata to describe it.

> > yes, it would be extremely difficult. but, as with all fields of
> > endevour, a holy grail is only such because it is. the question
> > remains, is this do-able? perhaps not now, or in two years, but
> > what about five? say, kernel 3.x.x or even 4.x.x?
> 
> For full direct kernel-to-kernel migration, I'm fairly confident
> the answer is "never", simply because it doesn't make sense, and

it makes full sense in an enterprise with 3000+ users that operates
24/7/365. no scheduled down-time for kernel upgrades.

> because it would be completely unmaintainable (1,2). (I expect to

this is not true. if the system were an integral part of the overall
design, then programming would include it apriori.

> see some information passing for things like IDE or SCSI bus scan
> results, though.)

there is a fine distinction between kernel migration, and hot-swap.
in a hot-swap setup, there will be signals pending from devices
that are contextually needed to continue operations that were being
performed. in a migration, the system is for all practical purposes
in a rebooted state after the switch, and thus, no context is
conveyed to the new kernel. keeping only the user-space context
would not allow hot-swap, unless all device activity was guaranteed
to be completed, as the user-space context was queued. _this_, i do
not believe is possible, as some devices will continue to need
context specific updating, and such will not be possible as the
servicing of the device would be based around context information
that would be stuck in a queue. the situation would be something
like a person stuck in mid-sentence trying to tell someone on a
telephone how to disarm a time-bomb. the clock still ticks even
though the instructor is silent.

> (2) If you dig out IFS, you'll see a nice example of why you
>     don't want to create too many dependencies on kernel
>     internals :-) http://www.almesberger.net/epfl/ifs.html

no comparison. the data transfer mechanism would be integral with
the kernel, and thus the only dependancies would be internal. it
would be an integrated api (from an external viewpoint).

> 
> - Werner
> 
> -- 

=====
Main Entry: anom·a·lous 
1 : inconsistent with or deviating from what is usual, normal, or expected: IRREGULAR, UNUSUAL
2 (a) : of uncertain nature or classification (b) : marked by incongruity or contradiction : PARADOXICAL
synonym see IRREGULAR

__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
