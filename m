Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135737AbRDYPfw>; Wed, 25 Apr 2001 11:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135511AbRDYPfm>; Wed, 25 Apr 2001 11:35:42 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:57475 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S135737AbRDYPf1>;
	Wed, 25 Apr 2001 11:35:27 -0400
Message-ID: <3AE6EEBF.D8A434D1@mandrakesoft.com>
Date: Wed, 25 Apr 2001 11:35:27 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andres Salomon <dilinger@mp3revolution.net>
Cc: Marcus Meissner <Marcus.Meissner@caldera.de>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: trident , pci_enable_device moved
In-Reply-To: <20010425090438.A12672@caldera.de> <20010425130624.A3216@caldera.de> <20010425104949.A31649@mp3revolution.net> <3AE6E797.A31803BE@mandrakesoft.com> <20010425112402.A31842@mp3revolution.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andres Salomon wrote:
> This is what I was told (it was only needed for secondary video
> devices).  From that, I would expect that all video devices would
> need it, just in case they happened to be the second card.  Am I
> missing some subtlety in some of the video driers/chipsets that
> wouldn't allow them to be used as a second video device (therefore
> not requiring pci_enable_device)?

They do need pci_enable_device, both primary and secondary displays. 
For the primary display its safe to call pci_enable_device.  For
secondary displays, you have to first disable I/O decoding for all VGA
devices before you can enable a secondary display.  You don't want more
than one device decoding the legacy VGA region at any one time.

Some cards have the capability to relocate the VGA region, which is
nice.  The bigger problem is initializing secondary displays; every
video card has a proprietary video BIOS initialization sequence that is
run by main BIOS on startup.  You can either duplicate this sequence
with C code, which is sometimes difficult due to lack of docs or variety
of boards, or you can execute the video BIOS with an x86 emulator.

-- 
Jeff Garzik      | The difference between America and England is that
Building 1024    | the English think 100 miles is a long distance and
MandrakeSoft     | the Americans think 100 years is a long time.
                 |      (random fortune)
