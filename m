Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263485AbTKQMsD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 07:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263486AbTKQMsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 07:48:03 -0500
Received: from VIA-PPPD24017.vianetworks.es ([213.236.24.17]:48878 "EHLO
	servidor.eurogaran.com") by vger.kernel.org with ESMTP
	id S263485AbTKQMr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 07:47:59 -0500
Date: Mon, 17 Nov 2003 13:47:23 +0100
From: Juanjo =?iso-8859-1?Q?Garc=EDa_Carr=E9?= <juanjo@eurogaran.com>
To: Erik Andersen <andersen@codepoet.org>
Cc: sten_wang@davicom.com.tw, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Hangup with Radeon9200 accel. Does not happen when not using agpgart or disabling CPU internal cache.
Message-ID: <20031117124723.GA11274@eurogaran.com>
References: <20031020100123.GA22114@eurogaran.com> <20031020101147.GA4904@codepoet.org> <20031022115355.GB9151@eurogaran.com> <20031022121538.GA14480@codepoet.org> <20031022140114.GA17407@eurogaran.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031022140114.GA17407@eurogaran.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

I finally managed to find the cause of the problem:

- It was not software.
Sorry for the unnecessary annoyance, people from the kernel and XFree lists! 
I will try to compensate by telling you what happened, just in case
you would face anything similar.

- It was neither the hardware.

- It was BIOS, but...
	- It was not a problem with BIOS settings.
	- It was not a problem of BIOS version.
	- The BIOS in fact can work perfectly.

Intrigued ?
Be prepared for one of the strangest stories of computer malfunction:

I bought a recent graphics card (Radeon 9200) for a not so recent
computer (Pentium2 with Intel440BX chipset).

I found Linux freezed completely whenever I tried to use acceleration,
which did not happen when using Windows with the same machine, nor the
same card on another -dissimilar- machine.
So I begun to search for flaws in the IntelAGP kernel module and/or the
Direct Rendering Interface, something that proved unsuccesful.
(I deeply thank everyone who tried to help me with this).

Frustrated, I decided to flash the BIOS with the latest version from the
manufacturer and... It worked !!!

But... Wait!... Isn't this the same BIOS version that was already installed?

Didn't I tried to load default and fail-safe settings with no positive result?

Mmmmm.... Let's see... Let's try changing some parameters....
It stops working again !!!

Let's return those parameters to their previous values... NO SUCCESS.

This is the bizarre part:

IT COULD NOT BE MADE TO WORK AGAIN, REGARDLESS OF THE PARAMETERS SETTINGS,
unless CMOS was cleared using the motherboard jumper.

I checked the fenomenon a dozen times. Moreover, after enough fiddling with
the bios parameter settings, even Windows begins to freeze
(always regardless of the concrete values introduced)
until CMOS is hard-reset again.

Possible explanations:
1- The system does not truly restart after changing values.
This possibility was easy to discard by powering off, waiting 2 minutes
and then powering on.
2- Values saved and shown later by the BIOS do not correspond in fact
to real ones.
3- The BIOS gets somehow corrupted when changing its parameters.
4- The BIOS is slowly getting corrupted by aging:
We all know today's hardware decomposes with time. I have seen
circuit boards that became pastous, sticky, degraded in only a couple of
years. (Learn the lesson. Don't throw away your old hardware!)
If this is so, in the future I will see how not even the jumper
erasing method will work.

For those interested, the "magic BIOS" corresponds to:

BasePlate:    Tyan    Mod. S1846 Tsunami ATX   2.00.04 031320011030
BIOS:         Ami     686 AMIBIOS (c)1999 AE12 4885
BIOS chip:    WinBond W29C020-90


