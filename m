Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271645AbRIGJbm>; Fri, 7 Sep 2001 05:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271647AbRIGJbd>; Fri, 7 Sep 2001 05:31:33 -0400
Received: from smtp1.vol.cz ([195.250.128.43]:57613 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S271645AbRIGJb0>;
	Fri, 7 Sep 2001 05:31:26 -0400
Date: Thu, 6 Sep 2001 11:46:54 +0200
From: Stanislav Brabec <utx@penguin.cz>
To: Tom Sightler <ttsig@tuxyturvy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI (?) problems of MSI K7T266 Pro = MS-6380 / VIA KT266 8233
Message-ID: <20010906114654.A8422@utx.vol.cz>
In-Reply-To: <20010905234544.A18413@utx.vol.cz> <003401c13660$84eab860$20040a0a@zeusinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <003401c13660$84eab860$20040a0a@zeusinc.com>
User-Agent: Mutt/1.3.18i
X-Accept-Language: cs, sk, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pùvodní zpráva (Tom Sightler, St  5. záøí 2001, 19:14:26 GMT):
> > I have Microstar mainboard MSI K7T266 Pro (MS-6380) with
> > VIA KT266 chipset (VIA 8233), Athlon 1200/266, linux-2.4.9
> >
> > Does anybody with this mainboard have some problems (or using it
> > succesfull), or should I suspect some bad setup / problematic PCI card
> > or more particular bugs?
> 
> We have a machine with this motherboard and a 1.4Ghz Athlon CPU and use it
> without significant problems.
> 

> I don't find any of these to point toward PCI problems, are there other
> reasons you would suspect PCI?
> 
Exactly, I don't suspect PCI, I suspect problems with 8233 chip setup
(or some device connected to it). Maybe it is not correct, but I don't
beleive there are four independent problems with devices connected via
VIA 8233.

There is actually one problem I'we forgotten:

About once per 50 pages printed via parport in graphic mode the page
goes out mangled. Playing around with DMA mode/IRQ mode/polling, there
only changes behavior (hanged printing / long timeouts every few pages /
mangled page after few minutes timeout / mangled page)


> > - SCSI scanner sometimes hangs scanning
> Sounds like a SCSI configuration problem, possibly termination.
> > - SCSI CD-ROM/writer sometimes fails to mount CD-ROM (read errors)
> See above.
> 
> One other thing to check though, I'm assuming your using the onboad SCSI.
No, I have version without SCSI controller, I am using DC315U:
SCSI storage controller: Tekram Technology Co.,Ltd. TRM-S1040 (rev 01)
I don't expect termination problems:
1) I have moved whole SCSI subsystem (incl. SCSI card) from my old
machine (Cyrix i686MX200). There were no problems.
2) The problems CD-ROM is only while mounting or checking for msinfo.
Never while burning or reading already mounted CD-ROM.

> > - Mangled sound output from AC97 codec
> 
> I think this is largely caused by the VIA audio driver included with
> standard linux.  I've had no end of trouble with it.  I use ALSA on my VIA
> chip and it works mostly without trouble.  I'd suggest at least giving it a
> try.

I have downloaded latest ALSA and compiled via8233 driver. I have also
communicated with ALSA developers and they say they have no problems.
Maybe there is a problem ALSA knows nothing about K7T266 Pro's AC97
codec (VIA VT1611A, identified as 0x49434943 ICI). Again, the problems
with sound is random and occurs only during chip initialize and
frequency change. The rest of time sound plays either correctly or buggy
(depending whether initialization was succesful).


> > - USB PC2PC driver sometimes looses data errors (cca once per 20MB)
> 
> This actually sounds pretty good, do you really mean one error per 20MB?
> I've never used the PC2PC driver but knowing the nature of USB with it's
> bandwidth saturation issues, etc. I think this sounds pretty good.
> 
I don't have many experiences with USB and their drivers, but these
errors cause timeouts and sometimes connection loosing. Maybe it can be
a driver bug (usbnet driver for GL620USB I was created from Genesys
Logic source codes and it was my first kernel stuff).


> > - PCI bus cannot be overclocked to more than 34.5 MHz
> Uh, what do you expect?  The spec is 33Mhz, you're not guaranteed more than
> that, that's why they have a spec.
Well I have changed everything to observe number of problems (BIOS
setups, under/overclocking). As far as machine was stable when
underclocked (900 MHz processor, 100 MHz FSB, 33 MHz PCI), the problems
were nearly the same. Then I have tried overclocking. At 35 MHz /
140 MHz FSB on PCI, the USB started to make significantly more bugs
(once per 100 kB).


> Later,
> Tom
Thanks for your info

-- 
Stanislav Brabec
