Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135997AbRD0Jgh>; Fri, 27 Apr 2001 05:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135992AbRD0Jg1>; Fri, 27 Apr 2001 05:36:27 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59751 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S135997AbRD0JgN>; Fri, 27 Apr 2001 05:36:13 -0400
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Andres Salomon <dilinger@mp3revolution.net>,
        Marcus Meissner <Marcus.Meissner@caldera.de>,
        linux-kernel@vger.kernel.org
Subject: Re: PATCH: trident , pci_enable_device moved
In-Reply-To: <20010425090438.A12672@caldera.de> <20010425130624.A3216@caldera.de> <20010425104949.A31649@mp3revolution.net> <3AE6E797.A31803BE@mandrakesoft.com> <20010425112402.A31842@mp3revolution.net> <3AE6EEBF.D8A434D1@mandrakesoft.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 27 Apr 2001 03:33:41 -0600
In-Reply-To: Jeff Garzik's message of "Wed, 25 Apr 2001 11:35:27 -0400"
Message-ID: <m1pudyr8ju.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com> writes:

> Andres Salomon wrote:
> > This is what I was told (it was only needed for secondary video
> > devices).  From that, I would expect that all video devices would
> > need it, just in case they happened to be the second card.  Am I
> > missing some subtlety in some of the video driers/chipsets that
> > wouldn't allow them to be used as a second video device (therefore
> > not requiring pci_enable_device)?
> 
> They do need pci_enable_device, both primary and secondary displays. 
> For the primary display its safe to call pci_enable_device.  For
> secondary displays, you have to first disable I/O decoding for all VGA
> devices before you can enable a secondary display.  You don't want more
> than one device decoding the legacy VGA region at any one time.
> 
> Some cards have the capability to relocate the VGA region, which is
> nice.  The bigger problem is initializing secondary displays; every
> video card has a proprietary video BIOS initialization sequence that is
> run by main BIOS on startup.  You can either duplicate this sequence
> with C code, which is sometimes difficult due to lack of docs or variety
> of boards, or you can execute the video BIOS with an x86 emulator.

Note:  With linuxBIOS (and some other embedded linux setups) even a
primary display doesn't get initialized until you start linux so if
you can properly initialize your display please do it.

Eric
