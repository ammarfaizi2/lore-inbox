Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262534AbSI0Pj2>; Fri, 27 Sep 2002 11:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262536AbSI0Pj2>; Fri, 27 Sep 2002 11:39:28 -0400
Received: from nameservices.net ([208.234.25.16]:17845 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S262534AbSI0Pj0>;
	Fri, 27 Sep 2002 11:39:26 -0400
Message-ID: <3D947DC3.EEC6C0A6@opersys.com>
Date: Fri, 27 Sep 2002 11:48:19 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Yumiko Sugita <sugita@sdl.hitachi.co.jp>
CC: robert@schwebel.de, lkst-develop@lists.sourceforge.jp,
       linux-kernel@vger.kernel.org
Subject: Re: [Lkst-develop] Re: Release of LKST 1.3
References: <5.0.2.6.2.20020918210036.05287a40@sdl99c>
	 <5.0.2.6.2.20020918210036.05287a40@sdl99c> <5.0.2.6.2.20020926182552.0506a898@sdl99c>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just a couple of general observations here.

Yumiko Sugita wrote:
>    Consequently, LKST, which is oriented to enterprise systems,
> has the following features different from those of LTT.
> # These LKST features are also being enhanced at this time.
> 
> (1) Little overhead and good scalability when tracing on a large-scale
>     SMP system
>    * To make lock mechanism overhead as little as possible, we
>       designed that the buffers are not shared among CPUs.

I was wondering whether you followed the recent discussion about LTT on the
LKML? Clearly this is not a problem for LTT since we don't use any form
of locking whatsoever anymore. IBM's work on the lockless scheme has
solved this problem and their current work on the per-CPU buffering solves
the rest of the issue.

> (2) Easy to extend/expand the function (User-based extendibility)
>    * Without recompiling kernel, user can change/add/modify the kind
>      of events and information to be recorded at anytime.

Ditto with LTT.

>       For example, LKST usually traces very few events for the purpose
>     of good performance.  Once the kernel get into the particular status
>     that user specified, LKST will trace and record more detail information.

This implies callbacks, which do exist in LTT and which Ingo Molnar explicitly
asked us to remove.

> (3) Preservation of trace information
>    * Recovery of trace information collected at the time of a system crash
>      in connection with LKCD.

Connection with LKCD is really not a problem, but this points to the main
purpose of the tool, which in the case of LKCD is kernel debugging. LTT isn't
aimed as a kernel debugger, so although LKCD is on our to-do list, it's
certainly not our priority.

As for handling multiple output streams (which LKCD can be one of them), we
already have very detailed plans on how LTT is going to integrate this (as I've
mentioned a number of times before on this list). However, before we go down
this road we need to make sure that the core tracing functionality is
lightweight and fits the general requirements set for kernel code. Once this
core lighweight functionality is there, we can build a rich and solid feature
set around it.

>    * Saving of specific event information during tracing.
>       For example, switching to another buffer after the occurrence of
>      a specific event enables the information on that event to be left
>      in the previous buffer.

Again, callbacks and triggers. A while back, I had written a state machine
engine for LTT. Basically, you could provide it with an event-driven state
machine and it would callback your functions depending on the sequence of
events. All of this obviously implies callbacks, which, as I said earlier,
we've been explicitly asked to remove.

> (4) Collection of even more kernel event information
>    * Information on more than 50 kernel events can be collected for
>      kernel debugging.

Well, I think this is where LTT and LKST cannot be compared. If LKST is
a kernel debugging tool, as it has always been advertised, then any comparison
of LKST should be made with the other tracing tools which are used for
kernel debugging, such as the ones mentioned by Ingo and Andi earlier on
this list.

LTT was built from the ground up to help users understand the dynamic
behavior of the system. As such, it cannot be compared to any kernel
debugging tool since it isn't one.

>   The demand for RAS functions in Linux should grow in the years to come.
> It is our hope that LKST becomes one means of implementing such functions.

There was a RAS BoF at the OLS this year where tracing was intensively discussed.
All the attendees agreed to unify their efforts around LTT. At this meeting,
Richard Moore of IBM presented a tracing to-do list
(http://opersys.com/LTT/ltt-to-do-list.txt) which we are using a basic
check list for our ongoing work. Instead of implementing yet another tracing
system, I think that the LKST team would benefit much from contributing to
LTT, which has already a proven track record and has been adopted by the
community as much as the industry.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
