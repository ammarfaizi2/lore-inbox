Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266071AbUGENI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266071AbUGENI1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 09:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266073AbUGENI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 09:08:26 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:32149 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266071AbUGENIV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 09:08:21 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Szakacsits Szabolcs <szaka@sienet.hu>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>
Subject: Re: Restoring HDIO_GETGEO semantics for 2.6 (was: Re: [RFC] Restoring HDIO_GETGEO semantics)
Date: Mon, 5 Jul 2004 15:13:48 +0200
User-Agent: KMail/1.5.3
Cc: "Patrick J. LoPresti" <patl@users.sourceforge.net>, bug-parted@gnu.org,
       Steffen Winterfeldt <snwint@suse.de>, Thomas Fehr <fehr@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Clausen <clausen@gnu.org>,
       buytenh@gnu.org, msw@redhat.com
References: <Pine.LNX.4.21.0407041920480.11076-100000@mlf.linux.rulez.org>
In-Reply-To: <Pine.LNX.4.21.0407041920480.11076-100000@mlf.linux.rulez.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407051513.48334.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 of July 2004 14:14, Szakacsits Szabolcs wrote:

>     - the old HDIO_GETGEO code still exists, just the values are thrown
>       away, as Andries wrote recently

No, the code (ide-geometry.c) is gone.

>     - nobody could point out any _technical_ benefit why the new
> HDIO_GETGEO code is better than the old one (the _way_ Andries wanted to

Andries pointed it many times but you seem to completely ignore it
(see comments in ide-geometry.c):

 * I did this, but it doesn't work - there is no reasonable way to find the
 * correspondence between the BIOS numbering of the disks and the Linux
 * numbering. -aeb
 *
 * The code below is bad. One of the problems is that drives 1 and 2
 * may be SCSI disks (even when IDE disks are present), so that
 * the geometry we read here from BIOS is attributed to the wrong disks.
 * Consequently, also the former "drive->present = 1" below was a mistake.
 *
 * Eventually the entire routine below should be removed.

I also pointed out that IDE driver _doesn't_ need BIOS geometry et all.

> push the code to user space was quite "unlucky")

Yep.

>     - nobody complained if anything would break if HDIO_GETGEO were
> restored
>
>     - returning 0 values have an unpredictable impact. Hence perhaps the
>       change shouldn't be done in the 2.6 kernels to avoid yet another
>       brown paper bag.

Yes, it won't help.

We need new ioctl for a get_start_sect() (first sector of a partition).

> Considering all the above points, it seems logical from practical point
> of view, that the restoration of the old HDIO_GETGEO functionality (or
> something that's very close to its behaviour) _temporarily_ for 2.6
> kernels makes sense.

We can restore ide-geometry.c or try to return values obtained from
EDD code through IDE driver.  Alternatively we can add new ioctl for
start of partition and remove HDIO_GETGEO from IDE driver completely
but probably it is too late for this for 2.6 (we should do it early
in 2.7 then).  Andries?

Bartlomiej

