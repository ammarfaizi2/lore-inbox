Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264444AbTEaToE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 15:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264442AbTEaToD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 15:44:03 -0400
Received: from [207.48.83.9] ([207.48.83.9]:17672 "EHLO winds.org")
	by vger.kernel.org with ESMTP id S264445AbTEaTn5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 15:43:57 -0400
Date: Sat, 31 May 2003 15:57:11 -0400 (EDT)
From: Byron Stanoszek <gandalf@winds.org>
To: Alexandre Pereira Nunes <alex@PolesApart.wox.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rc6 ide-scsi bug?
In-Reply-To: <3ED8CA77.9030809@PolesApart.wox.org>
Message-ID: <Pine.LNX.4.44.0305311552460.5395-100000@winds.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 May 2003, Alexandre Pereira Nunes wrote:

> Hi,
> 
> My system (athlon on an asus mb with via kt133 chipset) is currently 
> running 2.4.21-rc6 (but I had similar behaviour with 2.4.21-rc2-ac2), 
> and I map my ide cdrom to ide-scsi by passing option ide-cd ignore in 
> modules.conf (devfs is enabled, so that the modules load at /dev/cdrom 
> request).
> 
> Sometimes my cd drive (actually a mdma2 enabled combo dvd reader/cdrw 
> writer lg 4120B) seems to 'sleep' after a long time of inactivity and 
> waking it up (i.e. by trying to mount the unit) takes a time, so 
> eventually the system has to do a "soft" bus reset so that it comes to 
> life again (maybe it actually does that because the drive takes too long 
> to wake up by itself, but I don't know). If I use ide-cd instead of 
> ide-scsi, it happens as described and the system works ok (the kernel 
> prints dma disabled but if I enable it back it works fine), but with 
> ide-scsi, after the kernel prints that atapi reset and dma disabled 
> stuff, the system hangs. nothing else is printed, and my caps lock and 
> scroll lock keys starts blinking, so it seems to be a serious kernel 
> panic, but nothing about that is printed on the screen even when I'm at 
> console.
> 
> Older kernels i've tried (2.4.20 and 2.4.21-pre7) seems to behave ok.
> 
> I work around by using ide-cd until I need ide-scsi for something (like 
> tunning the rpc2 features on the drive to change region settings for dvd 
> playing), and replacing the driver by hand after making sure the drive 
> is ok, but that actually sucks :-)

I've just had this problem twice today when trying to cat /dev/scd0 past the
end of the DVD. It would stop after sector 716744 (1024-byte sectors) and hang
completely. After 1 minute, the device would do a soft reset and instantly I
get an oops, and the caps/scroll lock keys would start blinking. Couldn't save
the oops because of the panic in the interrupt handler.

This happened because I had written a 700MB file raw to the cd prior (716800
sectors total) and I wanted to read the whole thing back to make sure it was
stored successfully.  Now I'm out in the mkisofs code trying to figure out what
kind of padding I need at the end of the 700MB so it'll read the rest of it.

Note that a non ide-scsi device will just report I/O Error after reading the
end of the CD, however with an ide-scsi device, it will either hang or crash.

I'm currently using 2.4.20-pre5-ac1 with Andre Hedrick's IDE Patch applied. So,
I assume this has been around for some time. Thanks for sending your email--now
I know not to upgrade just yet.

I hope this is of help to someone. :)

 -Byron

-- 
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: byron@comtime.com

