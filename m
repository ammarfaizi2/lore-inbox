Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262956AbTDBRKG>; Wed, 2 Apr 2003 12:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263065AbTDBRKG>; Wed, 2 Apr 2003 12:10:06 -0500
Received: from gallium.deepthought.org ([64.253.103.121]:40368 "HELO
	gallium.deepthought.org") by vger.kernel.org with SMTP
	id <S262956AbTDBRKF>; Wed, 2 Apr 2003 12:10:05 -0500
Date: Wed, 2 Apr 2003 12:21:08 -0500 (EST)
From: Martin Murray <mmurray@deepthought.org>
To: Jon Burgess <jburgess@uklinux.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: accessing ROM on Rage 128 chips in aty128fb
In-Reply-To: <3E88862C.10205@uklinux.net>
Message-ID: <Pine.LNX.4.53.0304021215090.24044@gallium.deepthought.org>
References: <3E88862C.10205@uklinux.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jon, Thank you for your reply.

>  > Why does the linux PCI code not set up a mapping for the ROM
>  > automatically?
>
> It expects the BIOS to do it. You can force it to try with the option
> "pci=rom"

This worked and I was able to access the BIOS. Is there a method to ask
the pci code to do this from a driver, if pci=rom was not used?

> Assuming this is the active grahpics card, then you should be able to
> access the rom via the legacy VGA address range 0xc0000...0xc7fff which
> should be shown in /proc/iomem.

This worked, I realized that I was chasing the wrong bug - the code to
find the BIOS was looking for a "R128" signature, where my mobile Rage 128
has an "M3" signature. I patched the driver to search for "M3" as well as
"Rage 128" and it properly found the BIOS and loaded the pll information.
(The mobile version of the Rage 128 is called the Rage M3 Mobility, but it
is still a Rage 128.) Who do I submit this change to?

Unfortunately, the display is still garbage even after loading the correct
information from the BIOS. I have not been able to contact the aty128fb
author, does anyone have any suggestions? My next step is to compare how
the aty128fb driver initializes the display to the way the X4.3.0 server
does, however, this seems very tedious.

Thank you, Martin Murray
