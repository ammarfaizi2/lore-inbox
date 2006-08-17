Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbWHQLfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWHQLfj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 07:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbWHQLfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 07:35:39 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:57058 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S964812AbWHQLfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 07:35:38 -0400
Date: Thu, 17 Aug 2006 05:35:37 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Random scsi disk disappearing
Message-ID: <20060817113537.GK4340@parisc-linux.org>
References: <44E44B3E.10708@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E44B3E.10708@tls.msk.ru>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 02:55:58PM +0400, Michael Tokarev wrote:
> From time to time, an scsi disk just disappears from
> the bus, without any [error] messages whatsoever.
> The only relevant stuff in dmesg is logging from md
> (softraid) layer, about "error updating superblock"
> and later "giving up and removing the disk from the
> array" - not even error number.
> 
> When I try to access such a disk (/dev/sdX device),
> I got "No such device or address" error back.
> 
> It's still listed in /sys/block and /proc/scsi/scsi,
> but any access to the device gives this error.
> 
> But the disk is here, I know it is.  Deleting it from
> kernel:
> 
>   echo y > /sys/block/sdX/device/delete
> 
> and adding it back:
> 
>   echo scsi add-single-device x y z > /proc/scsi/scsi
> 
> works just fine, linux finds "new" scsi device and it
> happily works again.
> 
> This happens on alot of different machines, with different
> disk drives (ok, most of them are from Seagate, but not
> all).  I can't say for sure that it happens on different
> scsi controllers - at least majority of them are adaptecs,
> using aic7xxx or aix79xx driver.
> 
> I suspected the disks are too hot - nope, according to
> smartctrl, the themp is far from bad (typically about
> 25..35 Celsius, and the themperature is not changing much).
> Bad cables, bad power supply, bad anything else?  Not sure
> either, at least I can't guess more: the machines are
> really different, some has good, under-loaded power supplies
> (and server chassis/motherboards/allthestuff) some has less
> good ones - makes no difference.  And the thing is - having
> in mind really sporadic disappearing, not depending on current
> load, time of day (eg, during nights, there's no one on site
> so no one to touch cables etc), ...  Well, I just can't think
> of any reason, at all.
> 
> But one thing bothers me most: there's NO LOGGING from scsi
> layer.  None, zero, not at all.
> 
> Has anyone else seen something similar?  Any pointers on how
> to debug the issue?

I'd recommend turning on scsi logging; it might give you a clue about
which bit of scanning is failing to work properly.

Try booting with scsi_mod.scsi_logging_level = 448 (I think I have that
number right; 7 shifted left by 6) and then you can compare failing and
non-failing runs and see if there's any difference.
