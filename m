Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264961AbTFYTQa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 15:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264965AbTFYTQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 15:16:30 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:15764 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264961AbTFYTQV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 15:16:21 -0400
Date: Wed, 25 Jun 2003 21:30:02 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: SOLVED - Testing IDE-TCQ and Taskfile - doesn't work nicely:)
In-Reply-To: <20030625190515.GJ29233@lug-owl.de>
Message-ID: <Pine.SOL.4.30.0306252117240.25993-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 25 Jun 2003, Jan-Benedict Glaw wrote:

> On Wed, 2003-06-25 20:44:19 +0200, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
> wrote in message <Pine.SOL.4.30.0306252040570.11992-100000@mion.elka.pw.edu.pl>:
> > On Wed, 25 Jun 2003, Jan-Benedict Glaw wrote:
> > > On Wed, 2003-06-25 01:08:13 +0200, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
> > > wrote in message <Pine.SOL.4.30.0306250107180.17106-100000@mion.elka.pw.edu.pl>:
> > > > On Wed, 25 Jun 2003, Jan-Benedict Glaw wrote:
> > > > > On Tue, 2003-06-24 15:44:36 +0200, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
> > > > > wrote in message <Pine.SOL.4.30.0306241543050.23584-100000@mion.elka.pw.edu.pl>:
>
> > > However, allow me to ask why this occured never bevore (for other
> > > people)? Do they all have only one drive? Does nobody use TCQ? Nobody
> > > with old hardware (though, your patch hasn't touched the core PIIX
> > > parts...)?
> >
> > nobody is stupid^H^Hbrave enough to use TCQ ;-)
>
> Well... I knew that it was, erm, brave to use it at some time (this box
> isn't really important - if I kill its filesystems, I'll simply
> re-install and recover my mirror scripts:) ,  but new, where 2.5.x
> starts to be really useable, I'd suggest to face users with upcoming
> problems:

I think 2.5.x is really useable.

> CONFIG_IDE_TASKFILE_IO
> 	It is safe to say Y to this question, in most cases.
>
> 	(By the way, exactly which cases are ment?)

Ehh... 3 weird bugreports (all are oopses):
- on x86_64 with 32 bit userspace when reading /proc/ide/hdx/identify
- in task_mulout_intr() on access to freed rq->bio
- "bad: scheduling while atomic"

I don't have any ideas how to find&fix these bugs...

> CONFIG_BLK_DEV_IDE_TCQ
> 	If you have such a drive, say Y here.

TCQ is marked (EXPERIMENTAL) but there should be warning
about potential risk... :-)

> CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
> 	Generally say Y here.
>
>
> CONFIG_BLK_DEV_IDE_TCQ_DEPTH
> 	You probably just want the default of 32 here.
>
> 	(Default queue depth is 8, not 32...)

Jens did some testing ages ago and 8 was optimal...

> Right now, I'm building 2.5.73-bk3 + your 2nd patch. Let's face it:)

Okay. :-)
--
Bartlomiej

> MfG, JBG
>
> --
>    Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
>    "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
>     fuer einen Freien Staat voll Freier Bürger" | im Internet! |   im Irak!
>       ret = do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

