Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130637AbRBCS2X>; Sat, 3 Feb 2001 13:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130749AbRBCS2N>; Sat, 3 Feb 2001 13:28:13 -0500
Received: from atlante.atlas-iap.es ([194.224.1.3]:20238 "EHLO
	atlante.atlas-iap.es") by vger.kernel.org with ESMTP
	id <S130637AbRBCS2C>; Sat, 3 Feb 2001 13:28:02 -0500
From: "Ricardo Galli" <gallir@uib.es>
To: "Mark Hahn" <hahn@coffee.psychology.mcmaster.ca>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.1 eats RAM  or /proc/meminfo  bug
Date: Sat, 3 Feb 2001 19:27:54 +0100
Message-ID: <LOEGIBFACGNBNCDJMJMOGENHCDAA.gallir@uib.es>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
In-Reply-To: <Pine.LNX.4.10.10102031133290.10077-100000@coffee.psychology.mcmaster.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> you should give up thinking there's any real relation between 2.2
> and 2.4.  yes, they're both Linux, but their behaviors are essentially
> unrelated.
>
> >              total       used       free     shared    buffers
>    cached
> > Mem:        255340     232444      22896          0      16988
>     93212
> > -/+ buffers/cache:     122244     133096
> > Swap:       208804          0     208804
>
> no swap in use, so there's no problem.  except that 22MB is free/wasted.


Then, who is using those 122,244 KB of RAM than cannot be otherwise used for
buffers/cache?

Perhaps I am wrong and that number is the sum of procs memory plus
buffer/caches, but then it should have more free RAM than show in
free/meminfo. And altough cache and buffers are more or less stable, the
reported "used" memory" is still increasing.

What I understand is (no accounting for swap):

cache+buffers == active+inact_dirty+inact_clean.
userland mem == total - (kernel + cache + buffers)

but my reported numbers don't match. I am doing against the maths with the
current situation, and they still worse, buffers/cache have increased in
~4MB but free memory has decreased in ~14MB (with the same workload and
processes):

[gallir@m3d gallir]$ free
             total       used       free     shared    buffers     cached
Mem:        255340     246816       8524          0       4048     110736
-/+ buffers/cache:     132032     123308
Swap:       208804          0     208804

It's preferable to use all available RAM for buffers/cache, but this isn't
the case...

Sorry if I am wrong, I couldn't find more related docs about these changes.

--ricardo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
