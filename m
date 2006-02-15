Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbWBOWwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWBOWwn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 17:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWBOWwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 17:52:43 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:26327 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1751172AbWBOWwm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 17:52:42 -0500
Message-ID: <43F3B07C.8040803@cfl.rr.com>
Date: Wed, 15 Feb 2006 17:51:40 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Michael Tokarev <mjt@tls.msk.ru>
CC: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: readahead logic and I/O errors
References: <43F39089.2050302@tls.msk.ru> <Pine.LNX.4.61.0602151549190.10849@chaos.analogic.com> <43F3A4EA.3040000@tls.msk.ru>
In-Reply-To: <43F3A4EA.3040000@tls.msk.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Feb 2006 22:54:22.0246 (UTC) FILETIME=[C2D42C60:01C63282]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14270.000
X-TM-AS-Result: No--12.700000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Tokarev wrote:
> I opened the drive after BIOS didn't detect it on reboot (after
> power-off).  There's one fired (burned? perished? how's that in

I think you mean "fried", which is what happens when something is heated 
to excess.  "fired" is what happens to you when your boss catches you 
stealing office supplies or sleeping with his daughter.  It is also what 
happens to the bullet when you pull the trigger.

> english?) chip on the plate, wich smells like fired silicone.
>  It looks like a ~5mm pit in the center of square chip, full of
> ache, and there's a crack across it.  The drive is dead.
> 
> I think it's a chip which controls one of the motors of the drive,
> most probably the one which moves the head, because the head
> motor connector is right near the chip.
> 
> When I turned off power, the drive was *hot*, and it started
> "trembling" (or chattering) when I turned power off.
> 
> It was a dvd-cd combo (read dvd, read-write cd) Teac drive, I
> don't remember the model (there's no label on the drive, and
> I can't send inquiry/identify command to it anymore, obviously).
> 
> Yest it looks like a problem in the drive *too*, as it should
> not behave like that in the first place.  But the thing is, I
> did know something's bad going on, I saw it, but I wasn't able
> to stop it from linux, only poweroff stopped things from going.
> 
> /mjt

I assume the drive was no longer under warranty?  It certainly should 
not have burned itself out like that, but yea, the kernel should not 
keep trying to readahead on error.  I ran into a similar problem where I 
mounted a filesystem on a cdrw read/write and wrote some files to it. 
When I went to unmount it all the writes failed because the media was 
not properly formatted to be writable.  The kernel kept trying to write 
each sector though, and blocked the umount process in the unkillable D 
state for a good 20 minutes and kept the drive door locked.  Needless to 
say, I was very annoyed.

