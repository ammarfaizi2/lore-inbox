Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265292AbTL0B0t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 20:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265294AbTL0B0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 20:26:49 -0500
Received: from public1-brig1-3-cust85.lond.broadband.ntl.com ([80.0.159.85]:48518
	"EHLO ppgpenguin.kenmoffat.uklinux.net") by vger.kernel.org with ESMTP
	id S265292AbTL0B0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 20:26:48 -0500
Date: Sat, 27 Dec 2003 01:26:46 +0000 (GMT)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: xander vanwiggen <xander@alexandria.cc>
Cc: linux-kernel@vger.kernel.org
Subject: Re: atapi cd reported twice in dmesg??
In-Reply-To: <20031226232652.40543.qmail@gawab.com>
Message-ID: <Pine.LNX.4.58.0312270117410.31762@ppg_penguin>
References: <20031226232652.40543.qmail@gawab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Dec 2003, xander vanwiggen wrote:

>
> Hello,
> I'm migrating to 2.6 after having used 2.0,2.2,2.4 for quite
> some years now.
> At a first glance, I read ide-scsi is dropped. Okay, no SCSI
> support at all for me then. I have one CD writer, and now it
> gets reported twice, which I don't understand. I have
> CONFIG_IDE,CONFIG_BLK_DEV_IDE,CONFIG_BLK_DEV_IDEDSK,CONFIG_IDEDISK_MULTIMODE,CONFIG_BLK_DEV_IDECD
> set. dmesg reports: "hdc: PCRW804, ATAPI CD/DVD-ROM drive" first
> (ok), then "hdc: ATAPI 32X CDROM CD-R/RW drive, 2048kB Cache,
> DMA". Prior to the second report, an error is generated:
> "end_request: I/O error, dev hdc, sector 0". Reading works fine,
> haven't tested writing yet (nor installed X, hence the omission
> of blank lines in this mail). Is this a RTFM problem...? Kindest
> regards, Xander.
>

 I'm still running 2.4 on this box, with a combi drive as the primary
slave.  That shows twice too, as

hdb: HL-DT-ST RW/DVD GCC-4320B, ATAPI CD/DVD-ROM drive

and then _many_ lines later is the second part

hdb: attached ide-scsi driver.
scsi1: SCSI host adapter emulation for IDE ATAPI devices
  Vendor: HL-DT-ST  Model: RW/DVD GCC-4320B  Rev: 1.01
  Type:   CD-ROM                             ANSI SCSI revision: 02

 So I guess all that's happening is that the two parts come together
when we give up ide-scsi.  The error messages look as if the kernel is
trying to find any partitions, which isn't going to happen without media
- you should see how many error messages I get from an ATPAI ZIP drive
in 2.4 when I boot without media, but they're nothing to worry about.

HTH

Ken
-- 
I'm as free as a bird now, and this bird you cannot chain.
