Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbRCFNDy>; Tue, 6 Mar 2001 08:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129106AbRCFNDo>; Tue, 6 Mar 2001 08:03:44 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:19205 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S129091AbRCFNDd>; Tue, 6 Mar 2001 08:03:33 -0500
Date: Tue, 6 Mar 2001 05:03:32 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Jonathan Morton <chromi@cyberspace.org>
cc: Andre Hedrick <andre@linux-ide.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Douglas Gilbert <dougg@torque.net>,
        Jeremy Hansen <jeremy@xxedgexx.com>, <linux-kernel@vger.kernel.org>
Subject: Re: scsi vs ide performance on fsync's
In-Reply-To: <l03130308b6ca353ffb51@[192.168.239.101]>
Message-ID: <Pine.LNX.4.33.0103060449230.15874-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Mar 2001, Jonathan Morton wrote:

> Pathological shutdown pattern:  assuming scatter-gather is not allowed
> (for IDE), and a 20ms full-stroke seek, write sectors at alternately
> opposite ends of the disk, working inwards until the buffer is full.
> 512-byte sectors, 2MB of them, is 4000 writes * 20ms = around 80
> seconds

i don't understand why the disk couldn't elevator in this case and be done
in 20ms + rotational.

> >Of course, whether you should even trust the harddisk is another question.
>
> I think this result in itself would lead me *not* to trust the hard disk,
> especially an IDE one.  Has anybody tried running this test with a recent
> IBM DeskStar - one of the ones that is the same mech as the equivalent
> UltraStar but with IDE controller?

i assume you meant to time the xlog.c program?  (or did i miss another
program on the thread?)

i've an IBM-DJSA-210 (travelstar 10GB, 5411rpm) which appears to do
*something* with the write cache flag -- it gets 0.10s elapsed real time
in default config; and gets 2.91s if i do "hdparm -W 0".

ditto for an IBM-DTLA-307015 (deskstar 15GB 7200rpm) -- varies from .15s
with write-cache to 1.8s without.

and an IBM-DTLA-307075 (deskstar 75GB 7200rpm) varies from .03s to 1.67s.

of course 1.8s is nowhere near enough time for 200 writes to complete.

so who knows what that flag is doing.

-dean

