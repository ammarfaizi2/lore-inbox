Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbTKBU6F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 15:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbTKBU6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 15:58:05 -0500
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:49818 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261812AbTKBU6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 15:58:02 -0500
Date: Sun, 2 Nov 2003 21:57:58 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: Ville Herva <vherva@niksula.cs.hut.fi>,
       Andre Hedrick <andre@linux-ide.org>
Subject: Re: ide write cache issue? [Re: Something corrupts raid5 disks slightly during reboot]
Message-ID: <20031102205758.GA23842@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Ville Herva <vherva@niksula.cs.hut.fi>,
	Andre Hedrick <andre@linux-ide.org>
References: <20031101210223.GM4640@niksula.cs.hut.fi> <Pine.LNX.4.10.10311012201421.23682-100000@master.linux-ide.org> <20031102082827.GO4868@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031102082827.GO4868@niksula.cs.hut.fi>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 02 Nov 2003, Ville Herva wrote:

> As an^Wthe IDE expert, can you clarify a few points:
> 
>   - How long can the unwritten data linger in the drive cache if the drive
>     is otherwise idle? (Without an explicit flush and with write caching
>     enabled.)

Several seconds.  This is usually detailed in the OEM integrator manual,
at least it used to be for several IBM and Fujitsu drives when I looked
two years ago.  Drives usually start flushing cached data before they go
idle, and some drives guarantee maximum times before data hits the disk.
IIRC, Fujitsu MAH drives (SCSI though, not ATA) for instance guarantee
not to cache data for longer than 3 s, even if that means interrupting
reordering writes and hits write performance adversely (because it might
involve seeks). I seem to recall some IBM ATA drive claimed 15 s, but
don't quote me on that, I don't even recall if that was 2.5" or 3.5".

I don't recall the exact wording, so it may mean that the drive will not
VOLUNTARILY DELAY the write for more than 3 s. It's quite hard to write
4,096 scattered blocks on individual cylinders in 3 s even on 10,025/min
drives and requires knowing the block offset from the current rotational
angle of the platter... I wonder if drive firmware makes such scheduling
efforts.

>     I had unmounted the fs an raidstopped the md minutes before the boot.

Ugly if it still corrupts. :-(

>   - Can this corruption happen on warmboot or only on poweroff?

On ATA drives, the cache contents must persist across soft or hard reset
(warmboot).

>   - What kind of corruption can one see the if boot takes place "too fast"
>     and drive hasn't got enough time to flush its cache?

None with intact drives and bug-free firmware (I doubt such a thing
exists). Anyways, on powering down or with firmware bugs, anything is
possible.

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
