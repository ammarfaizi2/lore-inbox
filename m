Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbTIQTH1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 15:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262824AbTIQTH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 15:07:27 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:16256 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262633AbTIQTHY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 15:07:24 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Arve Knudsen <aknuds-1@broadpark.no>
Subject: Re: Changes in siimage driver?
Date: Wed, 17 Sep 2003 21:09:54 +0200
User-Agent: KMail/1.5
References: <oprvnjyf2oq1sf88@mail.broadpark.no> <1063816835.12648.90.camel@dhcp23.swansea.linux.org.uk> <oprvnqkoo5q1sf88@mail.broadpark.no>
In-Reply-To: <oprvnqkoo5q1sf88@mail.broadpark.no>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309172109.54450.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 of September 2003 20:49, Arve Knudsen wrote:
> On Wed, 17 Sep 2003 17:40:36 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk>
>
> wrote:
> > On Mer, 2003-09-17 at 17:26, Arve Knudsen wrote:
> >> X66 etc.) with hdparm, I get ~50MB/S. It's not an ideal solution since
> >> now
> >> and then I get a bunch of "disabling irq #18" messages after running
> >> hdparm (I think, its part of the startup scripts), and I have to
> >> restart.
> >
> > That is a bug in the 2.6.0 core still. Just hack out the code which does
> > the IRQ disable on too many apparently unidentified interrupts.
>
> Ok, thanks for identifying the source of this. I'm no kernel hacker at
> all, but I'll see what I can find.

s/IRQ_NONE/IRQ_HANDLE/ in ide-io.c or trace which one is offending one.

> >> directories. Am I the only one who's run into any sort of issues with
> >> the
> >> updated driver? From what I can see it hasn't been modified in the last
> >> revision (test5-bk4), hopefully noone is losing important data because
> >> of
> >> this (fortunately I had some recent backups). Anyway, I'd like some
> >> feedback on this from those in the know (the performance drop should be
> >> fairly easy to verify, unless hdparm is playing tricks on me).
> >
> > Don't keep important data only on 2.6-test boxes. Its 'test' - it
> > shouldnt eat anything but...
>
> Well, I understand that, but the older version of the driver (as of
> test4-mm4) doesn't have these problems (better performance according to
> hdparm, no corruption). The latest changes to the driver seems to have
> introduced problems, or is it just me?

You are the first person reporting problems after syncing siimage driver with
2.4.x ;-).  It's unlikely that corruption is caused by siimage driver update,
we should have seen similar problems with 2.4.x, but...

Performance is crippled because of workaround for buggy controllers.
We turn it on unconditionally now, we should do it only on affected
controllers.  I believe freebsd's workaround is correct and we can adopt it.
For more details please see the other thread regarding siimage.

--bartlomiej

> Thanks for the swift reply
>
> Arve Knudsen


