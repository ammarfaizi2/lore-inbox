Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318004AbSGRENJ>; Thu, 18 Jul 2002 00:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318005AbSGRENJ>; Thu, 18 Jul 2002 00:13:09 -0400
Received: from 12-237-135-160.client.attbi.com ([12.237.135.160]:34052 "EHLO
	Midgard.attbi.com") by vger.kernel.org with ESMTP
	id <S318004AbSGRENI> convert rfc822-to-8bit; Thu, 18 Jul 2002 00:13:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kelledin <kelledin+LKML@skarpsey.dyndns.org>
Subject: Re: File Corruption in Kernel 2.4.18
Date: Wed, 17 Jul 2002 23:16:02 -0500
User-Agent: KMail/1.4.2
To: linux-kernel@vger.kernel.org
Cc: jhart@atr.co.jp
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207172316.02162.kelledin+LKML@skarpsey.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, the test:

I chose directory /home/kelledin/gnutella.  It contains
approximately 10GB of files, ranging in size from ~5MB to
~700MB.  Most are ~600-650MB.

System specs are here:
http://www.anandtech.com/mysystemrig.html?rigid=5092

Only out-of-date info on that page is the kernel--I'm running
2.4.18+XFS-1.0.2+RML-preempt, compiled with gcc-2.95.3.  Kernel
was booted with "acpi=no-idle mem=nopentium" options.

While I was compiling jdk-1.4.0, I did the following:

[ kelledin@valhalla ~ ] # mkdir gnutella2
[ kelledin@valhalla ~ ] # cp -a gnutella gnutella2
[ kelledin@valhalla ~ ] # for FNAME in gnutella/*; do cmp
"$FNAME" "gnutella2/$FNAME"; done

The "cp -a" operation took 19 minutes, during which the system
load reached approximately 4.0 and the CPU temperature held at
54 C.  Ambient case temperature held at 26 C.  Swap usage did
not change.  System was somewhat sluggish but responsive enough
to play an mp3 and allow me to open terminal windows.  j2sdk
compile is still apparently going strong.

The comparison check...well, it finished while I was away
 getting a snack.  It printed no output, which means the check
 probably completed successfully.  Maybe I'll run some md5 sums
 later, just to be sure.

System load stayed at about 3.0, and temperatures remained
approximately the same as during the copy operation.

The relevant software:

kernel...well, you know.
glibc-2.2.5+linuxthreads+LSB+blowfish+math patches
libacl-2.0.11
libattr-2.0.8
bash-2.05a (Just for you, Hell.Surfers, just for you ;)
fileutils 4.1.8 with ACL patches and a Kelledin special. 
 Tarball can be found at:

ftp://skarpsey.dyndns.org/fileutils-4.1.8acl-kelledin.tar.bz2

Things that might be causing the corruption in our friend
J.Hart's case:

Buggy chipset (damn VIA!!!)
Faulty CPU (heat damage, chipped core?)
Faulty hard drive (hey, it's a DeathStar.)
Faulty IDE controller (if using offboard IDE)
Flaky cable (80-conductor ATA cable doesn't like being folded,
stacked, crumpled, etc., not even slightly)
Buggy IDE driver in the kernel
Buggy filesystem driver
Buggy fileutils
Buggy VM

I can't really test any of the possible software problems,
because I'm all SCSI, all XFS, bleeding-edge fileutils, and
didn't have any really significant swapping going on.  There's a
production server I could possibly test it on, but...well...it's
a production machine.  Maybe I'll repeat the test a few times
later.

On Wednesday 17 July 2002 10:11 pm, Kelledin wrote:
> This could possibly be a problem with your hard drive.
> Judging from the model number, you have a 45GB IBM DeskStar
> 75GXP, one of the first IBM drives to earn the nickname
> "DeathStar" for its high failure rate.  What does IBM's Drive
> Fitness Test tell you?
>
> I'll see about performing your test tonight; I've got a hefty
> little DivX directory I can throw around as I wait for
> j2sdk-1.4.0 to finish compiling.  Such a test should be
> sufficient...
>
> This could also be a recurrence of ye olde VIA686B PCI+IDE
> issue. IIRC, some VIA686B motherboards that had that flaw were
> effectively unfixable, simply because certain motherboard
> manufacturers spotted the problem before everyone else (even
> VIA?) and tried their own partial kludge fixes for it.  Gotta
> love VIA.

--
Kelledin
"If a server crashes in a server farm and no one pings it, does
it still cost four figures to fix?"
