Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262694AbRFTVAY>; Wed, 20 Jun 2001 17:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263142AbRFTVAO>; Wed, 20 Jun 2001 17:00:14 -0400
Received: from dsl-64-192-150-245.telocity.com ([64.192.150.245]:27656 "EHLO
	mail.communicationsboard.net") by vger.kernel.org with ESMTP
	id <S263003AbRFTVAI>; Wed, 20 Jun 2001 17:00:08 -0400
To: Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: [RFC] Early flush (was: spindown)
Message-ID: <993070731.3b310e8b4e51e@eargle.com>
Date: Wed, 20 Jun 2001 16:58:51 -0400 (EDT)
From: Tom Sightler <ttsig@tuxyturvy.com>
Cc: Mike Galbraith <mikeg@wen-online.de>, Rik van Riel <riel@conectiva.com.br>,
        Pavel Machek <pavel@suse.cz>, John Stoffel <stoffel@casc.com>,
        Roger Larsson <roger.larsson@norran.net>, thunder7@xs4all.nl,
        Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0106171156410.318-100000@mikeg.weiden.de> <01061816220503.11745@starship> <01062003503300.00439@starship>
In-Reply-To: <01062003503300.00439@starship>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Phillips <phillips@bonn-fries.net>:

> I originally intended to implement a sliding flush delay based on disk
> load.  
> This turned out to be a lot of work for a hard-to-discern benefit.  So
> the 
> current approach has just two delays: .1 second and whatever the bdflush
> 
> delay is set to.  If there is any non-flush disk traffic the longer
> delay is 
> used.  This is crude but effective... I think.  I hope that somebody
> will run 
> this through some benchmarks to see if I lost any performance. 
> According to 
> my calculations, I did not.  I tested this mainly in UML, and also ran
> it 
> briefly on my laptop.  The interactive feel of the change is immediately
> 
> obvious, and for me at least, a big improvement.


Well, since a lot of this discussion seemed to spin off from my original posting
last week about my particular issue with disk flushing I decided to try your
patch with my simple test/problem that I experience on my laptop.

One note, I ran your patch against 2.4.6-pre3 as that is what currently performs
the best on my laptop.  It seems to apply cleanly and compiled without problems.

I used this kernel on my laptop kernel on my laptop all day for my normal
workload which consist ofa Gnome 1.4 desktop, several Mozilla instances, several
ssh sessions with remote X programs displayed, StarOffice, VMware (running
Windows 2000 Pro in 128MB).  I also preformed several compiles throughout the
day.  Overall the machine feels slightly more sluggish I think due to the
following two things:

1.  When running a compile, or anything else that produces lots of small disk
writes, you tend to get lots of little pauses for all the little writes to disk.
 These seem to be unnoticable without the patch.

2.  Loading programs when writing activity is occuring (even light activity like
during the compile) is noticable slower, actually any reading from disk is.

I also ran my simple ftp test that produced the symptom I reported earlier.  I
transferred a 750MB file via FTP, and with your patch sure enough disk writing
started almost immediately, but it still didn't seem to write enough data to
disk to keep up with the transfer so at approximately the 200MB mark the old
behavior still kicked in as it went into full flush mode, during the time
network activity halted, just like before.  The big difference with the patch
and without is that the patched kernel never seems to balance out, without the
patch once the initial burst is done you get a nice stream of data from the
network to disk with the disk staying moderately active.  With the patch the
disk varies from barely active moderate to heavy and back, during the heavy the
network transfer always pauses (although very briefly).

Just my observations, you asked for comments.

Later,
Tom

