Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131498AbQKPU7y>; Thu, 16 Nov 2000 15:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131514AbQKPU7f>; Thu, 16 Nov 2000 15:59:35 -0500
Received: from dfmail.f-secure.com ([194.252.6.39]:2061 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S131498AbQKPU7X>; Thu, 16 Nov 2000 15:59:23 -0500
Date: Thu, 16 Nov 2000 22:33:12 +0100 (MET)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: <pavel-velo@bug.ucw.cz>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Linus Torvalds <torvalds@transmeta.com>,
        Ingo Molnar <mingo@elte.hu>
Subject: RE: KPATCH] Reserve VM for root (was: Re: Looking for better VM)
In-Reply-To: <Pine.LNX.4.21.0011161313310.13085-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.30.0011162154130.20626-100000@fs129-190.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 16 Nov 2000, Rik van Riel wrote:
> On Thu, 16 Nov 2000, Szabolcs Szakacsits wrote:
> 	[snip exploit that really shouldn't take Linux down]

I don't really consider it as an exploit. It's a kind of workload
that's optimized for fast testing simulating many busy user daemons
(e.g. dynamically generating web pages). Everybody knows Slashdot
effect. A system was designed for a workload according to a budget and
other factors. But immediately the load gets *much* higher as it was
ever expected, the system starts to trash and nobody can login or
start new processes. You can pull off the cable but if it's a remote
box then you are really in a bad situation. Or if a local [e.g.
computing] batch job run away you also must hit the reset button.
Happens too many times that it should be really taken seriously now,
who don't believe should just search for typical OOM crash patterns of
user reports on different mailling lists/newsgroups.

> > This or something similar didn't kill the box [I've tried all local
> > DoS from Packetstorm that I could find]. Please send a working
> > example. Of course probably it's possible to trigger root owned
> > processes to eat memory eagerly by user apps but that's a problem in
> > the process design running as root and not a kernel issue.
> Not necessarily, but your patch will probably make a difference
> for quite a number of people...

Could you please explain what you mean? ;) I saw only ONE difference.
The system remains usable for root but not anybody else. Everything
else is the same as before. Of course I think there are still problems
with the patch but to be honest I don't know what they are ... except
those I wrote before -- e.g. the latest, not yet released version
definitely doesn't work with your OOM killer [system just trashes].
Can you explain why you put process killing in do_try_to_free_pages()
instead of the original place, do_page_fault()? I guess putting it in
do_page_fault() [if possible] would fix my current problem.

> > If you think fork() kills the box then ulimit the maximum number
> > of user processes (ulimit -u). This is a different issue and a
> > bad design in the scheduler (see e.g. Tru64 for a better one).
> My fair scheduler catches this one just fine. It hasn't
> been integrated in the kernel yet, but both VA Linux and
> Conectiva use it in their kernel RPM.

I know about two fair schedulers for Linux, one of them is yours but
I couldn't try them out yet. Anyway definitely a must ;)

> While this is not one of the sexy new kernel
> features, this will help quite a few system
> administrators and is destined to a long and
> healthy life inside kernel RPMs, maybe even
> in the main kernel tree (when 2.5 splits?).

Thanks for the feedback,

	Szaka

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
