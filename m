Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264692AbUFSV1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264692AbUFSV1B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 17:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264717AbUFSV1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 17:27:01 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:26331 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S264692AbUFSV07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 17:26:59 -0400
Date: Sat, 19 Jun 2004 17:20:05 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: SATA 3112 errors on 2.6.7
In-Reply-To: <40D49FBC.7040900@pobox.com>
Message-ID: <Pine.GSO.4.33.0406191704150.25702-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jun 2004, Jeff Garzik wrote:
>I wonder if it helps to add the Seagate drive to the sata_sil blacklist?

As I said, I tried that with no success.  Btw, there is no such list in
the SI published driver (or they did it in a manner that is not immediately
obvious.)  However, this:
	Maxtor 4D060H3:DAK05GK0:MaxMode=udma-5
does show up practically without looking :-)

By way of freebsd mailling lists, it appears the dropped DMA thing is common
to the sil hardware.  However, there must be an errata/work-around as
SI's driver doesn't exhibit the same problems -- no stalls, no reported
DMA errors.

Of note is that the drive that most often stalls is of older firmware...
3.05 vs. the 3.18 of the other drives...
	Drive information:

	/dev/sga ATA      ST3160023AS      3.18 312581807 blocks
	/dev/sgb ATA      ST3160023AS      3.18 312581807 blocks
	/dev/sgc ATA      ST3160023AS      3.18 312581807 blocks
	/dev/sgd ATA      ST3160023AS      3.05 312581807 blocks

If I can/could get Seagate to give me a 3.18 firmware update for that drive,
I'll find a way to get it on there :-)

DMA'd reads don't seem to be a problem.  I'm 400G through the 10th loop
reading the entire array in 8M O_DIRECT chunks (128 16k stripes).  However,
I will note, the internal configuration of the sil chips are laughable...
reading from more than one port at a time (doesn't really matter which two)
degrades performance.  Reading from all four (hello raid) maxes out each port
to about 24MB/s.  Individually, each port (alone) can read at 48-56MB/s.
The drives are capable of streaming 85MB/s (if you believe the specs.)

--Ricky


