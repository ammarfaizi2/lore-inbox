Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbUDJDaq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 23:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbUDJDaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 23:30:46 -0400
Received: from smtp1.fuse.net ([216.68.8.171]:62881 "EHLO smtp1.fuse.net")
	by vger.kernel.org with ESMTP id S261925AbUDJDah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 23:30:37 -0400
From: "Ivica Ico Bukvic" <ico@fuse.net>
To: <daniel.ritz@gmx.ch>
Cc: "'A list for linux audio users'" 
	<linux-audio-user@music.columbia.edu>,
       "'Russell King'" <rmk+lkml@arm.linux.org.uk>,
       <alsa-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
       <linux-pcmcia@lists.infradead.org>,
       "'Thomas Charbonnel'" <thomas@undata.org>, <ccheney@debian.org>,
       "'Tim Blechmann'" <TimBlechmann@gmx.net>
Subject: RE: [linux-audio-user] snd-hdsp+cardbus+M6807 notebook=distortion -- First good news
Date: Fri, 9 Apr 2004 23:30:31 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-reply-to: <200404100347.56786.daniel.ritz@gmx.ch>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcQenk5EWFx7Mwm6Sy+oi1rNTsa7dgADQe+w
Message-Id: <20040410033032.XOVD8029.smtp1.fuse.net@64BitBadass>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much for an exhaustive breakdown of this issue! Your
assistance has been truly helpful!

I am aware that this burst stuff should be enabled on the 2.6 kernel,
however I am still getting bad results.

The 06 to 04 may be the critical element as even when I have everything
properly running in Win32, when I alter this number the distortion returns
(it is almost like an azimuth on old analogue tape decks that one would
adjust using screwdriver in order to successfully load a program into a
Commodore64 or the legendary Sinclair ZX Spectrum :-).

If I do figure out the problem in Linux and find out that a particular
register is the issue, how can I make my linux box adjust this register at
boot-time (a simple hack-like script in a form of a service comes to mind
but I was hoping to perhaps see a more universal solution if possible)?

Best wishes,

Ivica Ico Bukvic, composer & multimedia sculptor
http://meowing.ccm.uc.edu/~ico/
 
> -----Original Message-----
> From: Daniel Ritz [mailto:daniel.ritz@gmx.ch]
> Sent: Friday, April 09, 2004 9:48 PM
> To: Ivica Ico Bukvic
> Cc: linux-kernel
> Subject: RE: [linux-audio-user] snd-hdsp+cardbus+M6807 notebook=distortion
> -- First good news
> 
> you can get the same output with
> 	hexdump -v /proc/bus/pci/BUS/DEVICE
> where BUS/DEVICE is the CB controller. eg. 00/09.0
> 
> about the bits:
> - at 81h, from D0 to 90: this is part of the system control register. the
> bit
>   that changed is "Memory read burst enable upstream"
> - at c9h, from 04 to 06: this is an undocumented test register. TI just
> says
>   reserved, EnE says test register, for the bit that changed it adds the
>   comment TLTEnable (default to 1). no idea what it is. it _could_ have
>   something to do with the cardbus latency timer...you can try to play a
> bit
>   with the latency setting after resume when this bit is set. try writing
> to
>   offset 1Bh, put in at least 40h
> 
> to change the bits under linux, use setpci (also good for reading)
> 
> about the memory read burst upstream: 2.6 kernels enable it for most of
> the TI chips and since 2.6.5 also for some TI clones from EnE (incl.
> EnE1410).
> 
> rgds
> -daniel



