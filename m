Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273833AbRIXJji>; Mon, 24 Sep 2001 05:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273834AbRIXJj3>; Mon, 24 Sep 2001 05:39:29 -0400
Received: from [195.66.192.167] ([195.66.192.167]:56071 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S273833AbRIXJjM>; Mon, 24 Sep 2001 05:39:12 -0400
Date: Mon, 24 Sep 2001 12:36:31 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <6514162334.20010924123631@port.imtp.ilyichevsk.odessa.ua>
To: Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@conectiva.com.br>,
        Alexander Viro <viro@math.psu.edu>,
        Daniel Phillips <phillips@bonn-fries.net>
CC: linux-kernel@vger.kernel.org
Subject: Linux VM design
In-Reply-To: <20010922105332Z16449-2757+1233@humbolt.nl.linux.org>
In-Reply-To: <20010916204528.6fd48f5b.skraw@ithnet.com>
 <Pine.LNX.3.96.1010920231251.26679B-100000@gatekeeper.tmr.com>
 <20010921124338.4e31a635.skraw@ithnet.com>
 <20010922105332Z16449-2757+1233@humbolt.nl.linux.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----------FECE23A4DB880F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------------FECE23A4DB880F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi VM folks,

I'd like to understand Linux VM but there's not much in
Documentation/vm/* on the subject. I understand that with current
frantic development pace it is hard to maintain such docs.

However, with only a handful of people really understading how VM
works we risk ending in a situation when nobody will know how to fix
it (does recent Andrea's VM rewrite just replaced large part of hardly
maintenable, not-quite-right VM in 2.4.10?)

When I have a stalled problem to solve, I sometimes catch
unsuspecting victim and start explainig what I am trying to do and
how I'm doing that. Often, in the middle of my explanation, I realize
myself what I did wrong. There is an old teacher's joke:
"My pupils are dumb! I explained them this theme once, then twice, I
finally myself understood it, and they still don't".
        ^^^^^^^^^^^^^^^^^^^^
Since we reached some kind of stability with 2.4, maybe
Andrea, Rik and whoever else is considering himself VM geek
would tell us not-so-clever lkml readers how VM works and put it in
vm-2.4andrea, vm-2.4rik or whatever in Doc/vm/*,
I will be unbelievably happy. Matt Dillon's post belongs there too.

I have an example how I would describe VM if I knew anything about it.
I am putting it in the zip attachment just to reduce number of
people laughing on how stupid I am :-). Most lkml readers won't open
it, I hope :-).

If VM geeks are disagreeing with each other on some VM inner workings,
they can describe their views in those separate files, giving readers
ability to compare their VM designs. Maybe these files will evolve in
VM FAQs.

Saturday, September 22, 2001, 2:01:02 PM,
Daniel Phillips <phillips@bonn-fries.net> wrote:
DP> The arguments in support of aging over LRU that I'm aware of are:

DP>   - incrementing an age is more efficient than resetting several LRU list links
DP>   - also captures some frequency-of-use information

Of what use this info can be? If one page is accessed 100 times/second
and other one once in 10 seconds, they both have to stay in RAM.
VM should take 'time since last access' into account whan deciding
which page to swap out, not how often it was referenced.

DP>   - it can be implemented in hardware (not that that matters much)
DP>   - allows more scope for tuning/balancing (and also rope to hang oneself)

DP> The big problem with aging is that unless it's entirely correctly balanced its
DP> just not going to work very well.  To balance it well requires knowing a lot
DP> about rates of list scanning and so on.  Matt Dillon perfected this art in BSD,
DP> but we never did, being preoccupied with things like just getting the mm
DP> scanners to activate when required, and sorting out our special complexities
DP> like zones and highmem buffers.  Probably another few months of working on it
DP> would let us get past the remaining structural problems and actually start
DP> tuning it, but we've already made people wait way too long for a stable 2.4.
DP> A more robust strategy makes a lot of sense right now.  We can still play with
DP> stronger magic in 2.5, and of course Rik's aging strategy will continue to be
DP> developed in Alan's tree while Andrea's is still going through the test of
DP> fire.
DP> </musings>

DP> I'll keep reading Andrea's code and maybe I'll be able to shed some more light
DP> on the algorithms he's using, since he doesn't seem to be in a big hurry to
DP> do that himself.  (Hi Andrea ;-)

DP> --
DP> Daniel
DP> -
DP> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
DP> the body of a message to majordomo@vger.kernel.org
DP> More majordomo info at  http://vger.kernel.org/majordomo-info.html
DP> Please read the FAQ at  http://www.tux.org/lkml/




-- 
Best regards, VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua
------------FECE23A4DB880F
Content-Type: application/x-zip-compressed; name="Vm-dumb.zip"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="Vm-dumb.zip"

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
AEEAAAB/BwAAAAA=
------------FECE23A4DB880F--


