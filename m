Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbTJDB5q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 21:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbTJDB5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 21:57:46 -0400
Received: from mta6.srv.hcvlny.cv.net ([167.206.5.17]:48371 "EHLO
	mta6.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S261723AbTJDB5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 21:57:44 -0400
Date: Fri, 03 Oct 2003 21:57:51 -0400
From: jimbleferret@catholic.org
Subject: Re: CMD680, kernel 2.4.21, and heartache
In-reply-to: <87brsybm41.fsf@loki.odinnet>
To: Erik Bourget <erik@midmaine.com>, linux-kernel@vger.kernel.org
Message-id: <200310032157.52146.jimbleferret@catholic.org>
Organization: Nope.
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.5.3
References: <87brsybm41.fsf@loki.odinnet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 October 2003 07:23 am, Erik Bourget wrote:
> Day 0: 8 new NFS servers go online, they are P4-2.4GHz boxes
> with two each 120GB Samsung drives attached to CMD680/SiI680
> IDE controllers.  They run Debian stable on a 2.4.21 kernel,
> with SMP enabled though they are uniproc boxes, running
> NFSv3-via-TCP and reiserfs.  CMD680/siimage support compiled
> in, obviously.  Software RAID, mirroring drives.
>
> Out of 8 boxes:
>
> *) One has crashed hard.  I'm about to drive to the datacenter
> to plug in a KVM and take a picture.
> *) Three have had DMA turned off and have given extremely
> spooky errors. Read below.

I've been having very similar problems with a box here.  Just put 
Gentoo on it, and started having weird errors almost immediately 
- libraries not being found, all the way to gcc being unable to 
make executables.  Occasionally, I'd get a full lock - network 
was dead from the outside, and locally everything was frozen.  
The logs pointed to the same things - 'hda: status error: 
status=0x58 { DriveReady SeekComplete DataRequest },'  'hda: 
timeout waiting for DMA' and then a 'reset: success,' but it 
didn't seem that way.  Turning off DMA didn't seem to have any 
effect on gcc problems or lockups.

The Maxtor utility said everything was ok, and I had been using 
FreeBSD on it for months with no problems there.  Heat isn't a 
problem.

I then took out SiS5513 support (CONFIG_BLK_DEV_SIS5513), and I 
haven't had any problems since.  DMA is back on, and I've had a 
couple of timeouts and resets, but only 3 or 4 in ~10 hours, and 
no lockups or other noticeable weirdness.

Kernel version is gentoo-sources 2.4.20-r7, but I think that has 
patches from >=2.4.21.  I haven't tried any other sources.

Drive is a Maxtor 8 Gig, 90871U2.

Board is a PCChips M571.

