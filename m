Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313060AbSIACyz>; Sat, 31 Aug 2002 22:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313070AbSIACyz>; Sat, 31 Aug 2002 22:54:55 -0400
Received: from grace.speakeasy.org ([216.254.0.2]:35597 "HELO
	grace.speakeasy.org") by vger.kernel.org with SMTP
	id <S313060AbSIACyy>; Sat, 31 Aug 2002 22:54:54 -0400
Date: Sat, 31 Aug 2002 21:59:22 -0500 (CDT)
From: Mike Isely <isely@pobox.com>
X-X-Sender: isely@grace.speakeasy.net
Reply-To: Mike Isely <isely@pobox.com>
To: Andre Hedrick <andre@linux-ide.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-pre4-ac1 trashed my system
In-Reply-To: <Pine.LNX.4.10.10208302236560.1033-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.44.0208312142400.6399-100000@grace.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2002, Andre Hedrick wrote:

> 
> 
> This is not going to be fun.
> 
> grep "hwif->addressing" pdc202xx.c
> 
> Stub out the three lines.
> 
> Recompile and reboot, it will be fixed
> 

What version of the driver source are you using?  In 2.4.20-pre4-ac1 and 
2.4.20-pre5-ac1,

grep "hwif->addressing" pdc202xx.c

finds only 1 line.

There are however two other places in pdc202xx.c where one can find
"drive->addressing", each used as a condition in an if-statement (which
looks a lot like this might be the LBA48 fix you and Alan have been
telling me about).  What exactly do you want me to do?  Knock out the
if-conditions (and matching close-braces)?  Knock out the entire block
(and assumedly the LBA48 fix along with it) in each case?

I've been trying different combinations but so far either the result has
been no effect or fatally broken DMA (timeouts / failures at boot and
then the driver falls back to PIO).  I can post more details later, but
I wonder if I'm missing something blindingly obvious here...

Side note: In /proc/ide/ide2/hde/settings in 2.4.19-ac4, the "address" 
field reports a value of 1.  However in 2.4.20-pre4-ac1, I instead find 
the value 0.  Is this related to the addressing field in ide_hwif_t?

Oh, and while futzing with things I tried another experiment with the
hardware.  This may be a totally unrelated problem.  I attached a
Plextor CD burner to the second cable of the Promise controller.  It
should show up as hdg.  Under 2.4.19-ac4 it shows up.  Under
2.4.20-pre4-ac1 it isn't anywhere to be found - no errors, no hints
anywhere in the system that it might exist.  Yes, the IDE CDROM driver
is compiled into the kernel.

  -Mike


                        |         Mike Isely          |     PGP fingerprint
    POSITIVELY NO       |                             | 03 54 43 4D 75 E5 CC 92
 UNSOLICITED JUNK MAIL! |   isely @ pobox (dot) com   | 71 16 01 E2 B5 F5 C1 E8
                        |   (spam-foiling  address)   |

