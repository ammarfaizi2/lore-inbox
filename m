Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131028AbRCFREb>; Tue, 6 Mar 2001 12:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131027AbRCFRDs>; Tue, 6 Mar 2001 12:03:48 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:28827 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S131021AbRCFRB4>; Tue, 6 Mar 2001 12:01:56 -0500
Message-Id: <l0313030eb6cac517c110@[192.168.239.101]>
In-Reply-To: <Pine.LNX.4.33L2.0103061056410.5957-100000@srv2.ecropolis.com>
In-Reply-To: <02f901c0a644$61dca150$e1de11cc@csihq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 6 Mar 2001 16:57:50 +0000
To: Jeremy Hansen <jeremy@xxedgexx.com>, Mike Black <mblack@csihq.com>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: scsi vs ide performance on fsync's
Cc: Andre Hedrick <andre@linux-ide.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Douglas Gilbert <dougg@torque.net>, <linux-kernel@vger.kernel.org>,
        David Balazic <david.balazic@uni-mb.si>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue, 6 Mar 2001, Mike Black wrote:
>
>> Write caching is the culprit for the performance diff:

Indeed, and my during-the-boring-lecture benchmark on my 18Gb IBM
TravelStar bears this out.  I was confused earlier by the fact that one of
my Seagate drives blatently ignores the no-write-caching request I sent it.
:P


At 4:02 pm +0000 6/3/2001, Jeremy Hansen wrote:

>Ahh, now we're getting somewhere.

>so now this corresponds to the performance we're seeing on SCSI.
>
>So I guess what I'm wondering now is can or should anything be done about
>this on the SCSI side?

Maybe, it depends on your perspective.  In my personal opinion, the IDE
behaviour is incorrect and some way of dealing with it (while still
retaining the benefits of write-caching for normal applications) would be
highly desirable.  However, some applications may like or partially rely on
that behaviour, to gain better on-disk data consistency while not suffering
too much in performance (eg. the transaction database mentioned by at least
one poster).

The way to make all parties happy is to fix the IDE driver (or drives!) and
make sure an *alternative* syscall is available which flushes the buffers
asynchronously, as per the current IDE behaviour.  It shouldn't be too hard
to make the SCSI driver use that behaviour in the alternative syscall
(which may already exist, I don't know Linux well enough to say).

May this be a warning to all hardware manufacturers who "tweak" their
hardware to gain better benchmark results without actually increasing
performance - you *will* be found out!

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r- y+
-----END GEEK CODE BLOCK-----


