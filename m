Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267202AbSLRIiy>; Wed, 18 Dec 2002 03:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267204AbSLRIiy>; Wed, 18 Dec 2002 03:38:54 -0500
Received: from khms.westfalen.de ([62.153.201.243]:33249 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S267202AbSLRIiw>; Wed, 18 Dec 2002 03:38:52 -0500
Date: 18 Dec 2002 09:41:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8c6-ZPyXw-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.44.0212171132530.1095-100000@home.transmeta.com>
Subject: Re: Intel P6 vs P7 system call performance
X-Mailer: CrossPoint v3.12d.kh10 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <3DFF7951.6020309@transmeta.com> <Pine.LNX.4.44.0212171132530.1095-100000@home.transmeta.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com (Linus Torvalds)  wrote on 17.12.02 in <Pine.LNX.4.44.0212171132530.1095-100000@home.transmeta.com>:

> On Tue, 17 Dec 2002, H. Peter Anvin wrote:
> >
> > Let's see... it works fine on UP and on *most* SMP, and on the ones
> > where it doesn't work you just fill in a system call into the vsyscall
> > slot.  It just means that gettimeofday() needs a different vsyscall slot.
>
> The thing is, gettimeofday() isn't _that_ special. It's just not worth a
> vsyscall of it's own, I feel. Where do you stop? Do we do getpid() too?
> Just because we can?

It's special enough that while programming under DOS, I had my own special  
routine which just took the BIOS ticker from low memory for a lot of  
things - even to decide if calling the actual time-of-day syscall was  
useful or if I should expect to get the same value back as last time.

That was a *serious* performance improvement. (Of course, DOS syscalls are  
S-L-O-W ...)

These days, the equivalent does call gettimeofday(). It's still probably  
the most-used syscall by far. (Hmm - maybe I can get some numbers for  
that? Must see if I get time today.) And *that* is why optimizing this one  
call makes sense.

> This is especially true since the people who _really_ might care about
> gettimeofday() are exactly the people who wouldn't be able to use the fast
> user-space-only version.

Say what? Why wouldn't I be able to use it? Right now, I know of no SMP  
installation that's even in the planning ...

> How much do you think gettimeofday() really matters on a desktop? Sure, X

Why desktop? We use the same kind of thing in the server, and it's much  
more important there. Client performance is uninteresting - clients mostly  
wait anyway.

> The people who really call for gettimeofday() as a performance thing seem
> to be database people who want it as a timestamp. But those are the same

Not database, but otherwise on the nail.

> people who also want NUMA machines which don't necessarily have
> synchronized clocks.

Nope, no interest in those. SMP *might* become interesting, but I don't  
think we'd ever want to care about weird stuff like NUMA ... at least not  
for the next five years or so.

We don't shovel nearly as much data around as the database guys.

MfG Kai
