Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263000AbVALCKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263000AbVALCKV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 21:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263002AbVALCKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 21:10:21 -0500
Received: from mail.joq.us ([67.65.12.105]:2471 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S263000AbVALCKM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 21:10:12 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Chris Wright <chrisw@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       paul@linuxaudiosystems.com, arjanv@redhat.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <200501071620.j07GKrIa018718@localhost.localdomain>
	<1105132348.20278.88.camel@krustophenia.net>
	<20050107134941.11cecbfc.akpm@osdl.org>
	<20050107221059.GA17392@infradead.org>
	<20050107142920.K2357@build.pdx.osdl.net>
	<87mzvkxxck.fsf@sulphur.joq.us> <20050111212139.GA22817@elte.hu>
From: "Jack O'Quin" <joq@io.com>
Date: Tue, 11 Jan 2005 20:10:26 -0600
In-Reply-To: <20050111212139.GA22817@elte.hu> (Ingo Molnar's message of
 "Tue, 11 Jan 2005 22:21:39 +0100")
Message-ID: <87pt0bxur1.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> * Jack O'Quin <joq@io.com> wrote:
>
>> Here are the corrected results...
>> 
>>                                  With -R        Without -R      Without -R
>>                                (SCHED_FIFO)     (nice -20)      (nice --20)
>> 
>> XRUN Count  . . . . . . . . . :     2             2837               43
>> Delay Maximum . . . . . . . . :  3130 usecs    5038044 usecs   501374 usecs
>> Cycle Maximum . . . . . . . . :   960 usecs      18802 usecs     1036 usecs
>
> what kind of non-audio workload was there during this test? 43 xruns
> arent nice but arent that bad either.

Nothing heavy, but I was reading mail, and switching GNOME workspaces.
Workspace switching often caused trouble in the past, but I had
already hacked my X server not to run nice -10 (which is the Debian
default).

> plus, is it 100% sure that all audio threads inherited the nice --20
> priority - including the client threads? Nornally jackd does a
> setscheduler for the client threads so that they get boosted to
> SCHED_FIFO, but there is no parallel to that in the nice --20 case, did
> you do that manually (or did you start the clients up from the nice --20
> shell too?))

Having totally screwed up the test once already, I hesitate to claim
100% surety about anything.  :-)

The script starts all the clients.  I ran it with nice --20.  I just
started it again so I could check the nice values with GNOME system
monitor.  They all have -20, AFAICS.  There are a bunch of them at
-20, and I don't see any process that looks relevant without -20.

> If the nice --20 priority setup is perfect and there are still xruns
> then could you try the following hack, change this line in
> kernel/sched.c:
>
>  #define STARVATION_LIMIT        (MAX_SLEEP_AVG)
>
> to:
>
>  #define STARVATION_LIMIT        0
>
> this will turn off starvation checking, for testing purposes. (to see
> whether there's anything else but anti-starvation causing xruns.)

No problem (it might be Thursday before I have time to try it).
-- 
  joq
