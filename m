Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264723AbUFSVlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264723AbUFSVlq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 17:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264726AbUFSVlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 17:41:46 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:32987 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S264723AbUFSVlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 17:41:35 -0400
Date: Sat, 19 Jun 2004 17:35:41 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: "R. J. Wysocki" <rjwysocki@sisk.pl>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: SATA 3112 errors on 2.6.7
In-Reply-To: <200406192210.05455.rjwysocki@sisk.pl>
Message-ID: <Pine.GSO.4.33.0406191720100.25702-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jun 2004, R. J. Wysocki wrote:
>Anyway, it looks like a pattern is forming which smells bad to me.

The pattern formed a long time ago... there are several web pages dedicated
to the failure that is SATA. (1.5GHz signal on an unshielded cable?  WTF
were they thinking?)

>Apparently, we have:
>1) A serious error condition that occurs on Seagate SATA drives connected to
>Silicon Image controllers.

Not all drives and not all ways Seagate.  The seagate drive that fails
most often (always?) is FW 3.05 while the other 3 are FW 3.18.

>2) As of today we can say that it only occurs on Seagate drives (Ricky, do I
>remember correctly that you see faulty behavior of such drives with a 3ware
>RAID?).

The 3ware card has 250G Maxtor drives.  The drive that fails has different
firmware than the other three.  It fails irrespective of which port it's
on.  And powermax diag fails recalibration 50% of the time.
(FW YAR51EW0 works -- 3 on the 3ware, and 2 in Dells, YAR51BW0 fails.)

>Afterwards, the drive blocks its SATA bus in a "busy" mode and cannot be
>accessed by any means (ie. hardware reset is necessary).

Actually, I think it's the controller that's borked.  There's no way to
"hardware reset" a SATA drive without powering down the system which I'm
not doing.  And the same problems do not happen in windows using si's
driver.  Accorinding to FreeBSD developers, si's hardware is, point blank,
broken.

>4) The most "reliable" way to trigger this condition is to copy a lot of data
>(eg. 2 GB) to the drive in one shot.

Any sustained burst write will eventually lock up the channel.  It can take
seconds or hours.  It is as if a packet is being dropped during the DMA
transfer or the DMA completing without an ack.

--Ricky


