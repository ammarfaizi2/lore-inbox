Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262468AbVBXUUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbVBXUUE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 15:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262469AbVBXUUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 15:20:04 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:60516 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262468AbVBXUTw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 15:19:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=gOg6/H/18aW6gL7x7w/s/H7C9sR46vXOpuIdTeUhRDBeRa8hBum0iNF86p8RlQX/B3N5Z6biQn/JcD8ENIHxDiN+7uu79moHam8UKnh02qLc2TmOfYFTNPjb4ihZ8GJQbD/vMe/zaL4E95QVfsgwCE8qJq1B9Lf7+Z3w6Yt2t5U=
Message-ID: <87f94c3705022412192629fc13@mail.gmail.com>
Date: Thu, 24 Feb 2005 15:19:52 -0500
From: Greg Freemyer <greg.freemyer@gmail.com>
Reply-To: Greg Freemyer <greg.freemyer@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: Re: [patch ide-dev 3/9] merge LBA28 and LBA48 Host Protected Area support code
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Tejun Heo <htejun@gmail.com>
In-Reply-To: <200502241730.56015.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.GSO.4.58.0502241539100.13534@mion.elka.pw.edu.pl>
	 <87f94c370502240810583e3a4a@mail.gmail.com>
	 <200502241730.56015.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Feb 2005 17:30:55 +0100, Bartlomiej Zolnierkiewicz
<bzolnier@elka.pw.edu.pl> wrote:
> On Thursday 24 February 2005 17:10, Greg Freemyer wrote:
> > I have generic question about HPA, not the patch.
> >
> > I have noticed with a SUSE 2.6.8 vendor kernel, the HPA behavior is
> > not consistent.
> 
> Please retry with vanilla kernel.
> 
Will do.  I assume 2.6.10 is fine?

> > ie. With exactly the same computer/controller, but with different disk
> > drives (models/manufacturers) the HPA behavior varies.
> >
> > In all my testing the HPA was always properly detected, but sometimes
> > the max_address is set to the native_max_address during bootup and
> > sometimes it is not.
> 
> Please be more precise.
> 
> What do you mean by 'sometimes'?
> 
Seems to be disk drive specific.

For instance my records show that for a:
     Maxtor model 32049h2
     20 GB
     Manufactured Mar. 2001
drive I was working with last week the maximum available capacity was
set to the native max.  At power on the max. avail. was slightly
smaller than native max.

With exactly the same computer I just tested a HPA test drive of mine:
     Hitachi Deskstar
     model HDS728080PLAT20
     82.3 GB (per label)
     Manufactured Oct. 2004
and the max. avail. was not reset.  From boot.msg

<6>hdc: max request size: 1024KiB
<6>hdc: Host Protected Area detected.
<4>	current capacity is 50001 sectors (25 MB)
<4>	native  capacity is 160836480 sectors (82348 MB)
<4>hdc: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
<4>hdc: task_no_data_intr: error=0x04 { DriveStatusError }
<4>ide: failed opcode was: 0x37
<6>hdc: 50001 sectors (25 MB) w/1719KiB Cache, CHS=49/255/63, UDMA(100)
<7>hdc: cache flushes supported
<6> hdc: hdc1

Looking in /proc/ide/hdc/capacity after boot I show 50001 sectors.

Note this is still with the SUSE 2.6.8 vendor kernel and I don't know
what the Drive errors are, but they seem to be a driver issue, not a
hardware issue.  Concievably they are related to the behavior, but I
don't know.

> What are the exact differences between machines?
> 
Same machine / OS, just connecting different drives.  By chance, the
machine had been powered off between the 2 tests.  (It is a portable
machine that is normally locked away when not in use.)

> Are there any differences in software configurations
> (i.e. kernel parameters) between this machines?
> 
no

> > Is there some reason for this behavior or is one case or the other a bug?
> 
> Dunno, not enough info.
> 
> > Does this patch somehow address the inconsistency?
> 
> No.
> 
> > Am I right in assuming this behavior also exists in the vanilla
> > kernels?.  ie. I doubt that vendors are patching this behavior.
> 
> Recent vanilla kernels always set maximum available capacity.
> 
Was 2.6.8 recent enough to have this behavior?

Greg
-- 
Greg Freemyer
