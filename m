Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbTILXc5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 19:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbTILXc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 19:32:56 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:3755 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261951AbTILXcl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 19:32:41 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andries.Brouwer@cwi.nl
Subject: Re: [PATCH] Re: [PATCH][IDE] update qd65xx driver
Date: Sat, 13 Sep 2003 01:34:41 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <UTC200309122309.h8CN9wn08090.aeb@smtp.cwi.nl>
In-Reply-To: <UTC200309122309.h8CN9wn08090.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309130134.41702.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 13 of September 2003 01:09, Andries.Brouwer@cwi.nl wrote:
> From B.Zolnierkiewicz@elka.pw.edu.pl  Fri Sep 12 00:44:48 2003
>
> 	> That reminds me, did I ever send you this?
> 	>
> 	> Andries
>
> 	No, only similar patch for hpt366.c.
>
> 	I think the (almost) correct scheme is following ...
>
> Yes, larger changes are possible - and in fact I have a directory
> full of IDE stuff, polishing, cleanup, non-urgent.

Great!  Please push'em.

> I sent this mainly because the hpt366.c analog was needed to
> prevent filesystem corruption (on my own system). Similarly,
> I imagine this patch is needed to prevent filesystem corruption -
> no need to wait until someone actually reports a corrupted filesystem.
>
> Patches that allow people to set lower PIO modes than the max
> may be nice, but are less urgent than preventing modes higher
> than the max.

Eeeh... please re-read my mail.

As stated before you got corruption with hpt366.c because it was calling
hpt3xx_tune_drive() *internally* with pio argument equal to 5 instead of 255.

qd65xx.c is not calling qd*_tune_drive() internally et all -> no possibility
of corruption unless user *manually* sets mode higher than supported.

--bartlomiej

> Andries
>
> 	> -		pio = ide_get_best_pio_mode(drive, pio, 255, &d);
> 	> +		pio = ide_get_best_pio_mode(drive, 255, pio, &d);

