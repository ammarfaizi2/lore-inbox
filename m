Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131244AbRDSQPv>; Thu, 19 Apr 2001 12:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131275AbRDSQPl>; Thu, 19 Apr 2001 12:15:41 -0400
Received: from tomts8.bellnexxia.net ([209.226.175.52]:17843 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S131244AbRDSQPc>; Thu, 19 Apr 2001 12:15:32 -0400
Message-ID: <3ADF0F0E.BBD78FE1@coplanar.net>
Date: Thu, 19 Apr 2001 12:15:10 -0400
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@idb.hist.no>
CC: linux-kernel@vger.kernel.org
Subject: Re: Is there a way to turn file caching off ?
In-Reply-To: <Pine.LNX.3.96.1010418134153.20558A-100000@medusa.sparta.lu.se> <3ADD99E8.FB7F8542@coplanar.net> <3ADE9FFA.3E8476C2@idb.hist.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:

> Jeremy Jackson wrote:
>
> > currently all the kernel's heuristics are feed-back control loops.
> > what you are asking for is a feed-forward system: a way for the application
> > to tell kernel "I'm only reading this once, so after I'm done, throw it out
> > straight away"
> > and "I'm only writing this data, so after I'm done, start writing it out and
> > then forget it"
> >
> This is hard to get right.  Sure - your unpack/copy program read once
> and
> writes once.  But the stuff might be used shortly thereafter by
> another process.  For example:  I unpack a kernel tarball.  tar
> knows it writes only once and might not need more than 5M to do
> this as efficient as possible with my disks.  A lot of other cache
> could be saved, fewer things swapped out.
> But then I compile it.  Todays system ensures that lots of the source
> is in memory already.  Limiting the caching to what tar needed
> however will force the source to be read from disk once during
> the compile - not what I want at all.

They why would you tell tar not to use cache?  If you know what's happening
next you need to tell the system (feed-forward), not have it try to read your
mind.  I'm assuming your modified tar would have an option switch
to cause this behaviour, not be hard coded...

>
>
> A program may know its own access pattern, but it don't usually know
> future access patterns.  Well, backing up the entire fs could benefit

Yes, so a script that does the above wouldn't enable no cache mode
for written files.  The program doesn't know, but the encompasing
script (or person at console) does.

>
> from a something like this, you probably won't need the backup again
> soon.  But this is hard to know in many other cases.

