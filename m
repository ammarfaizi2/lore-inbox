Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265910AbUFVUuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265910AbUFVUuF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 16:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265900AbUFVUtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 16:49:53 -0400
Received: from havoc.gtf.org ([216.162.42.101]:42629 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S265910AbUFVUpS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 16:45:18 -0400
Date: Tue, 22 Jun 2004 16:41:06 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Ricky Beam <jfbeam@bluetronic.net>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix sata_sil quirk
Message-ID: <20040622204105.GA19693@havoc.gtf.org>
References: <40D89509.6010502@pobox.com> <Pine.GSO.4.33.0406221620300.25702-200000@sweetums.bluetronic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.33.0406221620300.25702-200000@sweetums.bluetronic.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2004 at 04:29:08PM -0400, Ricky Beam wrote:
> On Tue, 22 Jun 2004, Jeff Garzik wrote:
> >Here's my suggested fix...  good catch Ricky.
> 
> And I don't even know why I looked at max_sectors :-) (I need more Dew.)
> 
> >Yes, unfortunately performance will be dog slow.
> 
> Well, at least puppy slow...
> Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
> sda            1811.65         0.00      9629.85          0     577887
> sdb            1807.15         0.00      9629.60          0     577872
> sdc            1807.25         0.00      9629.86          0     577888
> sdd            1807.05         0.00      9629.86          0     577888
> md_d0         14444.64         0.00     48148.84          0    2889412
> md_d0p2        9629.78         0.00     38519.11          0    2311532
> (over 60sec,  8M O_DIRECT accesses, 128 stripes * 16k RAID0)
> 
> Without the MOD15 hack, the numbers are 2x higher, but they stop after
> a few minutes :-)

Stability first!


> >I've got contacts at Silicon Image, and have been meaning to bug them
> >for a "real fix" for a while.  It is rumored that there is a much better
> >fix, which allows full performance while at the same time not killing
> >your SATA drive due to odd-sized SATA frames on the wire.
> 
> Ask them what they do in their driver? (the linux one and the windows one)
> Looking at the linux driver, the mod15 quirk is there, but there doesn't
> appear to be any associated device list. (I've already post the single
> Maxtor device listed.)  FreeBSD detects the stall, resets the chip and
> hopes that clears the problem. (People are not happy about that.)

I just poked them.  I'm not satisfied with what any Linux or FreeBSD
driver does, I want to Get It Right(tm)  :)  I'm willing to bet that
their Linux driver does mod15 only because they didn't know kernel
internals that well.

	Jeff



