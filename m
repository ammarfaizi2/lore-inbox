Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276601AbRJPSTl>; Tue, 16 Oct 2001 14:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276612AbRJPSTb>; Tue, 16 Oct 2001 14:19:31 -0400
Received: from astcc-281.astound.net ([24.219.123.215]:65030 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S276601AbRJPSTU>; Tue, 16 Oct 2001 14:19:20 -0400
Date: Tue, 16 Oct 2001 11:17:35 -0700 (PDT)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Tim Hockin <thockin@sun.com>
cc: alan@redhat.com, torvalds@transmeta.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IDE initialization fix
In-Reply-To: <3BCC708E.3ADD3E2A@sun.com>
Message-ID: <Pine.LNX.4.10.10110161109450.807-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tim,

Why are we calling for interrupts assignments early?
Since all legacy hosts can reserve BAR's 0-3 to be 0x0000, and there are
two differenct pci interrupts assigned, I am puzzled by the changes?

Obviously there are addon cards that do not fill in the interrupt line,
also if one is doing SMP the value may be shifted.

The real issue is that the initialization of the card/host has a problem,
so that belongs in the pci_fix_up region in the arch/<>/kernel/pc-irq.c
stuff, imho.  In general one should not be changing the interrupt lines at
this stage of the INIT process.

Lastly, if you have a multi-host card and it does not register IO bases
because there are no devices attached, then you have a problem of
nonexistant resources, this is what I truly suspect is the problem w/ the
Cobalt box.

Comments?

Cheers,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

On Tue, 16 Oct 2001, Tim Hockin wrote:

> Andre, Alan, Linus
> 
> We thought this bug was fixed for a long time, but apparently it is back! 
> This patch makes sure we call the init for ALL chipsets that support it. 
> Please apply this for the next 2.4.x, or let me know of problems.
> 
> thanks (more patches to come!)
> 
> Tim
> -- 
> Tim Hockin
> Systems Software Engineer
> Sun Microsystems, Cobalt Server Appliances
> thockin@sun.com

