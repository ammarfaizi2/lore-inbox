Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbUCTCxT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 21:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263207AbUCTCxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 21:53:19 -0500
Received: from mail.convergence.de ([212.84.236.4]:20950 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S263205AbUCTCxR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 21:53:17 -0500
Date: Sat, 20 Mar 2004 03:53:12 +0100
From: Johannes Stezenbach <js@convergence.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] barrier patch set
Message-ID: <20040320025312.GA12710@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Matthias Andree <matthias.andree@gmx.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040319153554.GC2933@suse.de> <200403200102.39716.bzolnier@elka.pw.edu.pl> <20040320014837.GB11865@convergence.de> <200403200313.05681.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403200313.05681.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Saturday 20 of March 2004 02:48, Johannes Stezenbach wrote:
> 
> > hdparm -i and -I ultimately both interpret WIN_IDENTIFY result, and both
> > test bit 0x0020 of word 85. So it's unclear to me why they report a
> > different write cache setting. I added a hexdump to dump_identity()
> > in hdparm.c, and found that bit 0x0020 of word 85 is always set.
> 
> or WIN_PIDENTIFY to be strict but
> 
> -i returns _cached_ (read when the device was probed) identify data
> (uses HDIO_GET_IDENTIFY ioctl)
> -I reads _current_ data directly from the device
> (uses HDIO_DRIVE_CMD ioctl)

Oh, right.

But: HDIO_GET_IDENTITY returns drive->id, and surely drive->id
is used internally. So isn't it a bug that drive->id is not
updated when the write cache setting is changed?

I think the barrier code uses drive->id to determine if the
write cache is enabled.

Johannes
