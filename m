Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276729AbRJBWCi>; Tue, 2 Oct 2001 18:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276728AbRJBWC3>; Tue, 2 Oct 2001 18:02:29 -0400
Received: from shell.cyberus.ca ([209.195.95.7]:59573 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S276729AbRJBWCY>;
	Tue, 2 Oct 2001 18:02:24 -0400
Date: Tue, 2 Oct 2001 18:00:05 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Ingo Molnar <mingo@elte.hu>
cc: <linux-kernel@vger.kernel.org>, <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, <netdev@oss.sgi.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.GSO.4.30.0110020724530.29541-100000@shell.cyberus.ca>
Message-ID: <Pine.GSO.4.30.0110021739160.2323-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar <mingo@elte.hu> wrote:

>> Silencing a specific target cannot be done by IRQ masking, you have to
>> ask the controller to shut up. It may be the default "shut up" handler
>> is disable_irq but that is non optimal.

>this could be done later on, but i think this is out of question for 2.4,
>as it needs extensive changes in irq handler and network driver API.

This already is done in the current NAPI patch which you should have seen
by now. NAPI is backward compatible: It would work just fine with 2.4 and
drivers can be upgraded slowly.
If theres anything that should make it into 2.4 then NAPI it should be
(with some componets from your code that still needs to be proven under
different workloads).

>> And how do you select max_rate sanely? [...]

>> Saying "hey, that's the users problem", is _not_ a solution. It needs
>> to have some automatic cut-off that finds the right sustainable rate
>> automatically, instead of hardcoding random default values and asking
>> the user to know the unknowable.

>good point. I did not ignore this problem, i was just unable to find any
>solution that felt robust, so i convinced myself that max_rate is the
>best idea :-)

if you havent taken a look at NAPI please do so instead of creating these
nightly brainstorm patches. With all due respect, if you insist on doing
that please have the courtesy of at least posting results/numbers of how
this improved things and under what workloads and conditions.
I do believe that some of the pieces of what you have would help -- in
conjunction with NAPI.
A scenario where we have an appearing ksoftirqd, then disapearing and then
a new kpolld showing up just indicates very bad engineering/juju which
seems to be based on pulling tricks out of a hat.

Lets work together instead of creating chaos.

cheers,
jamal

