Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132268AbRCVXvU>; Thu, 22 Mar 2001 18:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132272AbRCVXsx>; Thu, 22 Mar 2001 18:48:53 -0500
Received: from owns.warpcore.org ([216.81.249.18]:130 "EHLO owns.warpcore.org")
	by vger.kernel.org with ESMTP id <S132265AbRCVXrE>;
	Thu, 22 Mar 2001 18:47:04 -0500
Date: Thu, 22 Mar 2001 17:43:40 -0600
From: Stephen Clouse <stephenc@theiqgroup.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Guest section DW <dwguest@win.tue.nl>,
        Rik van Riel <riel@conectiva.com.br>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
Message-ID: <20010322174340.A1406@owns.warpcore.org>
In-Reply-To: <20010322142831.A929@owns.warpcore.org> <E14gCYn-0003K3-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Disposition: inline; filename="msg.pgp"
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14gCYn-0003K3-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Mar 22, 2001 at 09:23:54PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thu, Mar 22, 2001 at 09:23:54PM +0000, Alan Cox wrote:
> How do you return an out of memory error to a C program that is out of memory
> due to a stack growth fault. There is actually not a language construct for it

Hmmm...the old "Error 3 while attempting to report Error 3" dialog from MS
Excel.  

> Eventually you have to kill something or the machine deadlocks. The oom killing
> doesnt kick in until that point. So its up to you how you like your errors.

It's interesting that I never recall oom being a problem (like this) with 2.0 or 
2.2.  And the machines I was working with at the time were far crappier than
these current boxen -- they'd ride the oom line almost constantly.  Back then a
new process would either a) scream "Out of memory!" or b) segfault.  You could
argue that b is not desirable, but I'd prefer that to the current behavior, 
really.  In fact this type of behavior still happens under 2.4 when we hit OOM
on the development boxen, although not consistently (only about half the time);
oom_kill annihilates something we don't want it to, then the mallocing process
that triggered it decides it has become bored with life and procceds to
abort/segfault anyway.  I wish I could reproduce it consistently.

In any case, the behavior of oom_kill (whether you consider it correct or
not) is really the symptom and not the cause.  We've alleviated most of it via
creative use of ulimit.  Still, the seemingly draconian behavior needs a bit
finer-grained control.

> One of the things that we badly need to resurrect for 2.5 is the beancounter
> work which would let you reasonably do things like guaranteed Oracle a certain
> amount of the machine, or restrict all the untrusted users to a total of 200Mb
> hard limit between them etc

Let me know when you branch :)  Sounds like a fun project.

- -- 
Stephen Clouse <stephenc@theiqgroup.com>
Senior Programmer, IQ Coordinator Project Lead
The IQ Group, Inc. <http://www.theiqgroup.com/>

-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.8

iQA/AwUBOrqOLAOGqGs0PadnEQKWFACfaqzjtUQD4uGaLFnxn6M9Xc4N6QIAoJO3
nJTISp0ekbXEUiAY9PJVf2vr
=B3u4
-----END PGP SIGNATURE-----
