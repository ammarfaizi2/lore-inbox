Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbWA2V25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWA2V25 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 16:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWA2V24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 16:28:56 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:27075 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751171AbWA2V24 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 16:28:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S95VCHsbi8fjcdMXFA/Ohi/IbqU0pNgvYShYCVyROcaPrpobUMS8MS0iG3ZV74dKKi0SKPl2LB2Ov5kvXPtQPNa9WaFfX9bFXZz25z7EOwJ9ladSoORCgXa5GIHC8RibD8j4u9fRjEzUGw2Omhpw2WbzeQqwsjdxVRpsktvl6SE=
Message-ID: <787b0d920601291328k52191977h3778a7c833d640f2@mail.gmail.com>
Date: Sun, 29 Jan 2006 16:28:53 -0500
From: Albert Cahalan <acahalan@gmail.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux try #2 [ was: Re: CD writing in future Linux (stirring up a hornets' nest) ]
Cc: matthias.andree@gmx.de, jengelh@linux01.gwdg.de, mrmacman_g4@mac.com,
       linux-kernel@vger.kernel.org, bzolnier@gmail.com
In-Reply-To: <43DD2A8A.nailGVQ115GOP@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com>
	 <43DCA097.nailGPD11GI11@burner>
	 <20060129112613.GA29356@merlin.emma.line.org>
	 <Pine.LNX.4.61.0601292139080.2596@yvahk01.tjqt.qr>
	 <43DD2A8A.nailGVQ115GOP@burner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/06, Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
>
> > >That's what I believe to be cdrecord/libscg bugs:
> > >
> > >1) libscg or cdrecord does not automatically probe all available
> > >   transports, but only SCSI:
> >
> > This one is IMO just "a missing feature", as I can get the ATA/PI list using
> >   cdrecord -dev=ATA: -scanbus
>
> It cannot be fixed unless the two first bugs from my Linux kernel
> bug report have been fixed.

Which, from an earlier email, were:

> ide-scsi does not do DMA if the DMAsize is not a
> multiple of 512 A person who knows internal Linux
> structures shoule be able to fix this (and allow
> any multiple of 4) in less than one hour.

and

> /dev/hd* artificially prevents the ioctls
> SCSI_IOCTL_GET_IDLUN SCSI_IOCTL_GET_BUS_NUMBER from
> returning useful values. As long as this bug is present,
> there is no way to see SG_IO via /dev/hd* as integral
> part of the Linux SCSI transport concept.

Let's address the second bug first. Linux provides full
bus number and LUN info for all block devices. You get it
like this:

struct stat sbuf;
stat("/dev/hdc", &sbuf);
int bus = sbuf.st_mode>>12;
int target = major(sbuf.st_rdev);
int lun = minor(sbuf.st_rdev);

That makes as much sense as anything, and it lets you quickly
find back the device by scanning /dev.

As for ide-scsi, your right, it's horribly broken. We should
just get rid of it. If there is anything that the normal driver
is unable to do well, I'm sure you'll let us know.
