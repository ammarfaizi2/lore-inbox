Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278768AbRKDFD5>; Sun, 4 Nov 2001 00:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278758AbRKDFDr>; Sun, 4 Nov 2001 00:03:47 -0500
Received: from mail012.mail.bellsouth.net ([205.152.58.32]:32340 "EHLO
	imf12bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S278768AbRKDFDh>; Sun, 4 Nov 2001 00:03:37 -0500
Message-ID: <3BE4CC20.5FFEC4B5@mandrakesoft.com>
Date: Sun, 04 Nov 2001 00:03:28 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Sean Middleditch <elanthis@awesomeplay.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Via Onboard Audio - Round #2
In-Reply-To: <1004849558.457.15.camel@stargrazer>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Middleditch wrote:
> 
> Hi all!
> 
> OK, I seemed to have made a realization:
> 
> When the via82cxxx_audio driver loads (this is in 2.4.12, Debian
> version, which I think is Linus tree with a couple patches), I get these
> errors (which I also think I had on the RH kernels, tho I can't exactly
> check that anymoe, since RH is gone):
> 
> IEQ routing conflict for 00:07.5, have irq 5, want irq 11
> PCI: Sharing IRQ 11 with 00:0a.0
> PCI: Sharing IRQ 11 with 00.0b.0
> via82cxxx: timeout while reading AC97 codec (0xAA0000)
> via82cxxx: timeout while reading AC97 codec (0xAA0000)
> via82cxxx: Codec rate locked at 48Khz
> via82cxxx: timeout while reading AC97 codec (0x800000)
> ac97_codec: AC97  codec, id: 0x4144:0x5361 (Unknown)
> via82cxxx: board #1 at 0x1000, IRQ 5
> 
> (note, those were hand typed, I'm writing this up on my workstation not
> the laptop, so no cut and paste, and I'm too lazy to deal with floppies
> at the moment).
> 
> In /proc/pci, the audio board is at IRQ 5, device 9 on bus 9.
> lspci says it is device 00:07.5 (as does the above notice).
> 
> pcitweak -l  reports, for the device:
> PCI: 00:07.5: chip 1106,3058 card 0e11,0097 rev 50 class 04,01,00 hdr 00
> 
> In any event, I'm thinking perhaps there is an IRQ conflict happening
> here?  I looked in the BIOS, and the BIOS gives me *no* options relating
> to IRQ's (All I see are a couple lpt options, boot order, and
> suspend/resume disabling).  I tried modprobe via82cxx_audio irq=5  but
> that gave me errors about the irq option not being valid.  How can I
> force the IEQ to 5, or 11, or whatever other IRQ I want?

You cannot, through driver options.

The IRQ routing conflict is definitely the problem.  You can try booting
with "PNP OS: No" and maybe other irq options are hidden in your BIOS
setup under an advanced menu.

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

