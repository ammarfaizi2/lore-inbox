Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283830AbRK3Xfj>; Fri, 30 Nov 2001 18:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283828AbRK3Xfa>; Fri, 30 Nov 2001 18:35:30 -0500
Received: from hebe.uva.nl ([145.18.40.21]:55504 "EHLO hebe.uva.nl")
	by vger.kernel.org with ESMTP id <S281192AbRK3XfO>;
	Fri, 30 Nov 2001 18:35:14 -0500
Date: Sat, 1 Dec 2001 00:34:54 +0100 (CET)
From: Kamil Iskra <kamil@science.uva.nl>
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Problems with APM suspend and ext3
In-Reply-To: <Pine.LNX.4.10.10111291006380.20544-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.33.0111302355140.1582-100000@bubu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2001, Mark Hahn wrote:

[This is in response to a private email - I'm posting to the list because
of significant results]

> > > are your filesystems mounted with noatime/nodiratime?

No, they (or it rather, for I have just one) were mounted with default
options.

Following Mark's suggestion, I remounted my filesystem with noatime,
and... suspends suddenly started succeeding.  nodiratime didn't seem to
matter, noatime was enough.  The success rate was very good, I don't think
I've seen even a single suspend failure.

So, now I know a workaround, which for me as a user is already quite
significant, but that's not really a proper fix, right?

I looked at the apm script, in RedHat 7.2 it sits in
/etc/sysconfig/apm-scripts/apmscript and is >10K.  Its behaviour is
controlled by /etc/sysconfig/apmd.  I already had most things turned off
there, for I just don't need them all, but due to some omision I still had
"NETFS_RESTART" on (which attempts to unmount remote filesystem on suspend
and mount them on resume -- which doesn't matter for me since I don't
mount any remote filesystems).  Anyway, I commented out that
"NETFS_RESTART" and suddenly I started getting successful suspends even
with the default filesystem options, i.e. _with_ atime.  However, the
success rate was not impressive, it seemed to be higher in general for
"apm -s" than for the suspend button in the machine.  The success rate in
that case is significantly improved if one invokes sync(1) a few seconds
before attempting a suspend.  In fact, suspends seem to be quite reliable
when performed this way.

If I may, I would like to make some purely user-level speculation (I don't
know how all this stuff works internally).  I've long since known that the
suspends are not completely reliable, even with ext2, particularly if
there was some disk activity going to right before or during a suspend.  
So I knew for example that trying to suspend a laptop with xmms playing
some mp3s off the hard-disk would usually fail -- I had to pause the
playback and only then press the suspend button.  So, it is not that the
problem with ext3 is necessarily new -- it might be a manifestation of the
same problem as before, only in a more apparent form, perhaps because of a
more synchronous disk access needed for the journal. Perhaps it's not even
a bug, but just the way things work with suspend -- perhaps it simply
can't be performed reliably when there is a disk activity going on.  
Although personally, I would of course hope that it is just a bug that can
be fixed and result in rock-solid suspends succeeding every time, even in
the middle of kernel recompilation :-).

-- 
Kamil Iskra                 http://www.science.uva.nl/~kamil/
Section Computational Science, Faculty of Science, Universiteit van Amsterdam
kamil@science.uva.nl  tel. +31 20 525 75 35  fax. +31 20 525 74 90
Kruislaan 403  room F.202  1098 SJ Amsterdam  The Netherlands

