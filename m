Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262297AbREUSDA>; Mon, 21 May 2001 14:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262295AbREUSCv>; Mon, 21 May 2001 14:02:51 -0400
Received: from waste.org ([209.173.204.2]:35616 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S262265AbREUSCo>;
	Mon, 21 May 2001 14:02:44 -0400
Date: Mon, 21 May 2001 13:04:05 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: David Lang <david.lang@digitalinsight.com>
cc: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD 
 w/info-PATCH]device arguments from lookup)
In-Reply-To: <Pine.LNX.4.33.0105210925390.26948-100000@dlang.diginsite.com>
Message-ID: <Pine.LNX.4.30.0105211259180.17263-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 May 2001, David Lang wrote:

> what makes you think it's safe to say there's only one floppy drive?

Read as: it doesn't make sense to have per-fd state on a single floppy
device given that there's only one actual hardware instance associated
with it and multiple openers don't make sense. Opening a floppy at
different densities with magic filenames was an example Linus used earlier
in the thread. Surely there can be more than one drive and more than one
serial port.

> On Mon, 21 May 2001, Oliver Xymoron wrote:
>
> > On Sat, 19 May 2001, Alexander Viro wrote:
> >
> > > Let's distinguish between per-fd effects (that's what name in
> > > open(name, flags) is for - you are asking for descriptor and telling
> > > what behaviour do you want for IO on it) and system-wide side effects.
> > >
> > > IMO encoding the former into name is perfectly fine, and no write on
> > > another file can be sanely used for that purpose. For the latter, though,
> > > we need to write commands into files and here your miscdevices (or procfs
> > > files, or /dev/foo/ctl - whatever) is needed.
> >
> > I'm a little skeptical about the necessity of these per-fd effects in the
> > first place - after all, Plan 9 does without them.  There's only one
> > floppy drive, yes? No concurrent users of serial ports? The counter that
> > comes to mind is sound devices supporting multiple opens, but I think
> > esound and friends are a better solution to that problem.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

