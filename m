Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbUGEVrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUGEVrX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 17:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUGEVrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 17:47:23 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:6909 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261375AbUGEVrU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 17:47:20 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Subject: Re: Restoring HDIO_GETGEO semantics for 2.6 (was: Re: [RFC] Restoring HDIO_GETGEO semantics)
Date: Mon, 5 Jul 2004 23:52:51 +0200
User-Agent: KMail/1.5.3
Cc: Andries Brouwer <aebr@win.tue.nl>, Szakacsits Szabolcs <szaka@sienet.hu>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>, bug-parted@gnu.org,
       Steffen Winterfeldt <snwint@suse.de>, Thomas Fehr <fehr@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Clausen <clausen@gnu.org>,
       buytenh@gnu.org, msw@redhat.com
References: <Pine.LNX.4.21.0407041920480.11076-100000@mlf.linux.rulez.org> <200407052105.05585.bzolnier@elka.pw.edu.pl> <20040705210813.GE29504@apps.cwi.nl>
In-Reply-To: <20040705210813.GE29504@apps.cwi.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407052352.51135.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 of July 2004 23:08, Andries Brouwer wrote:
> On Mon, Jul 05, 2004 at 09:05:05PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > Andries, the question was "What should we do with HDIO_GETGEO breakage?"
> > not "Why does somebody need the BIOS geometry?". :-)
> >
> > We can fix HDIO_GETGEO to behave like in 2.4 or remove it (preferable),
> > current situation is bad.
>
> I don't know precisely why.
>
> Neither of your two proposed actions appeals to me.
>
> Here is an ioctl, and it is used for legitimate purposes
> (finding the starting offset of a partition).

It is also _abused_ for less legitimate purposes.

> You cannot remove it. We can think again in 2.7.
> For now, leave the kernel interface constant.

We can at least consider adding BLKPARTSTART and deprecating
HDIO_GETGEO so people at least will know that they should upgrade.

> Is there any advantage in going back? I don't think so.
> The old situation was broken. People lost all data.

According to szaka the "the new situation" is similar. :(

> Also "the old situation" is badly defined. The returned value differs
> for 2.0, 2.2, 2.4, 2.6.

This is just sick: same ioctl - different returned values.
Please never ever do it again - we can avoid such problems in future.

> No. We must go forward.

Yep, 2.7.1 should remove HDIO_GETGEO.
We should have done this in 2.5, really.

> Now distributions can take care of themselves. They can patch the kernel
> as they like, or patch parted as they like, or do any number of other
> things. RedHat and SuSE can take their own decisions. With some luck there
> is a new parted next week or so that they could offer.

What about people running old parted and new vanilla kernels?

> So we can go slowly and quietly, investigate precisely what happens, and
> why and how such things can be fixed. I think I understand rather well what
> is (was) wrong with parted. Maybe Szaka can teach me about other tools that
> are broken. I am confident that we can fix them, maybe in hours rather than
> days.

What about people using old versions of these tools (if any).

What I'm only worried is that there might be cases when 2.4 worked
and 2.6 doesn't which with combination with bugs in the tools cause
"where is my data?" issue.

> As a side result we will have something valuable, namely standard software
> that tries to handle BIOS data. Several orders of magnitude more reliable
> than our old guesses.

Yep.

Bartlomiej

