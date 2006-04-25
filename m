Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWDYNp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWDYNp7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 09:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWDYNp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 09:45:59 -0400
Received: from pne-smtpout4-sn2.hy.skanova.net ([81.228.8.154]:44707 "EHLO
	pne-smtpout4-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932221AbWDYNp6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 09:45:58 -0400
From: Jani-Matti =?iso-8859-1?q?H=E4tinen?= <jani-matti.hatinen@iki.fi>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: Lock-up with modprobe sdhci after suspending to ram
Date: Tue, 25 Apr 2006 16:45:57 +0300
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <515ed10f0604240033i71781bfdp421ed244477fd200@mail.gmail.com> <200604251108.52515.jani-matti.hatinen@iki.fi> <444DE0E6.8090801@drzeus.cx>
In-Reply-To: <444DE0E6.8090801@drzeus.cx>
X-Face: #cyYMAd}qudd3k4*S6mac8z1vRgtwXAC'7r{jv<~p5y80oOWqj0)0~/;,QeB(P>fhDJ"=?iso-8859-1?q?lF=0A=09=7D-ls=26?="0:\(7!/S)a_ew$J?hey[-+u`<VOlVBz48@)SW{u#N=v1P~`\Cd9^zw[>=?iso-8859-1?q?Z=607l=26XK=24=0A=09Deyz7Uf=5Dx?=@r"kOgh|l?F~QrgBEd<$x`a)[]1C"NqvG<T3Gk"@_,cH7Q;HTlZgb*F>VR(=?iso-8859-1?q?3j=0A=09=5ByC?=>>hR;jXQ!K/Q]*HjPibvm_33AQC_N2Z$VnZ<=?iso-8859-1?q?gy*4-QB2q=3A=5BoZ=2E-8YNsF+WK=27ya6u/!J=0A=09-4g=3B?=
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200604251645.58421.jani-matti.hatinen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman kirjoitti viestissään (lähetysaika tiistai, 25. huhtikuuta 2006 
11:42):
> Jani-Matti Hätinen wrote:
> > Looks like some kind of routing problem. Even pings don't seem to get
> > through to mmc.drzeus.cx, or list.drzeus.cx. With http I get a timeout
> > from mmc.drzeus.cx. This is from IP 80.221.18.58
>
> Most of the domain is down right now (changing ISP). But the mail server
> is up at hermes.drzeus.cx:

Ok. That explains it.

> > Unfortunately even text mode is completely speechless about it. The
> > modprobe goes through cleanly and I get the regular prompt (with a
> > blinking cursor even), but the machine's completely locked up.
>
> Have you tried pinging it? For some reason the keyboard tends to bail
> out when there are outstanding MMC requests. I've only seen this with a
> card in the slot though.

Yes, but the thing is deader than the cat I'm sitting on. Even SysRq is dead.

> You could increase the log level sent to console and enable MMC_DEBUG.
> If you can find more closely where it hangs I have a better chance of
> finding it.

Ok, this is what I get on Loglevel 9.
  If I try to suspend with the module loaded and with a card in the reader I 
get:
Stopping tasks: ================================|
ipw2200: Failed to send CARD_DISABLE: Command timed out
ACPI: PCI interrupt for device 0000:01:05.0 disabled
sdhci [sdhci_suspend()]: Suspending...
MMC: starting cmd 07 arg 00000000 flags 00000000
sdhci [sdhci_send_command()]: Sending cmd (7)

And if I modprobe sdhci after suspend&resume I get the following:
  First from the modprobe (not all of it is visible):
sdhci: Sys addr: 0xffffffff | Version:  0x0000ffff
sdhci: Blk size: 0x0000ffff | Blk cnt:  0x0000ffff
sdhci: Argument: 0xffffffff | Trn mode: 0x0000ffff
sdhci: Present:  0xffffffff | Host ctl: 0x000000ff
sdhci: Power:    0x000000ff | Blk gap:  0x000000ff
sdhci: Wake-up:  0x000000ff | Clock:    0x0000ffff
sdhci: Timeout:  0x000000ff | Int stat: 0xffffffff
sdhci: Int enab: 0xffffffff | Sig enab: 0xffffffff
sdhci: AC12 err: 0x0000ffff | Slot int: 0x0000ffff
sdhci: Caps:     0xffffffff | Max curr: 0xffffffff
sdhci: ===========================================
kobject mmc0: registering. parent: mmc_host, set: class_obj
kobject_uevent
fill_kobj_path: path = '/class/mmc_host/mmc0'
fill_kobj_path: path = '/devices/pci0000:00/0000:00:1e.0/0000:01:03.2'
sdhci [sdhci_set_ios()]: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0
mmc0: SDHCI at 0xfe8fe000 irq 18 PIO
sdhci [sdhci_set_ios()]: clock 0Hz busmode 1 powermode 1 cs 0 Vdd 21 width 0

  Plus a prompt and:
sdhci [sdhci_set_ios()]: clock 246093Hz busmode 1 powermode 2 cs 0 Vdd 21 
width 0
sdhci [sdhci_set_ios()]: clock 246093Hz busmode 1 powermode 2 cs 1 Vdd 21 
width 0
MMC: starting cmd 00 arg 00000000 flags 00000040
sdhci [sdhci_send_command()]: Sending cmd (0)

  Whereas, if I modprobe sdhci in a fresh boot I get:
kobject sdhci: registering. parent: <NULL>, set: module
kobject_uevent
fill_kobj_path: path = '/module/sdhci'
sdhci: Secure Digital Host Controller Interface driver, 0.11
sdhci: Copyright(c) Pierre Ossman
kobject sdhci: registering. parent: <NULL>, set: drivers
kobject_uevent
fill_kobj_path: path = '/bus/pci/drivers/sdhci'
sdhci [sdhci_probe()]: found at 0000:01:03.2
sdhci [sdhci_probe()]: found 1 slot(s)
ACPI: PCI Interrupt 0000:01:03.2[C] -> GSI 20 (level, low) -> IRQ 18
sdhci [sdhci_probe_slot()]: slot 0 at 0xfe8fe000, irq 18
sdhci: ============== REGISTER DUMP ==============
sdhci: Sys addr: 0x00000000 | Version:  0x00000200
sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
sdhci: Present:  0x01f20000 | Host ctl: 0x00000000
sdhci: Power:    0x00000000 | Blk gap:  0x00000000
sdhci: Wake-up:  0x00000000 | Clock:    0x00000000
sdhci: Timeout:  0x0000000e | Int stat: 0x00000000
sdhci: Int enab: 0xe1ff00cf | Sig enab: 0xe1ff00cf
sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
sdhci: Caps:     0x018021a1 | Max curr: 0x00000040
kobject mmc0: registering. parent: mmc_host, set: class_obj
kobject_uevent
fill_kobj_path: path = '/class/mmc_host/mmc0'
fill_kobj_path: path = '/devices/pci0000:00/0000:00:1e.0/0000:01:03.2'
sdhci [sdhci_set_ios()]: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0
mmc0: SDHCI at 0xfe8fe000 irq 18 PIO
sdhci [sdhci_set_ios()]: clock 0Hz busmode 1 powermode 1 cs 0 Vdd 21 width 0
sdhci [sdhci_set_ios()]: clock 128906Hz busmode 1 powermode 2 cs 0 Vdd 21 
width 0
sdhci [sdhci_set_ios()]: clock 128906Hz busmode 1 powermode 2 cs 1 Vdd 21 
width 0

 Plus a prompt and:
MMC: starting cmd 00 arg 00000000 flags 00000040
sdhci [sdhci_tasklet_finish()]: Ending request, cmd (0)
MMC: req done (00): 1: 00000000 00000000 00000000 00000000
sdhci [sdhci_set_ios()]: clock 128906Hz busmode 1 powermode 2 cs 0 Vdd 21 
width 0
MMC: starting cmd 37 arg 00000000 flags 00000015
sdhci [sdhci_tasklet_finish()]: Ending request, cmd (37)
MMC: req done (37): 1: 00000000 00000000 00000000 00000000
MMC: starting cmd 37 arg 00000000 flags 00000015
sdhci [sdhci_tasklet_finish()]: Ending request, cmd (37)
MMC: req done (37): 1: 00000000 00000000 00000000 00000000
MMC: starting cmd 37 arg 00000000 flags 00000015
sdhci [sdhci_tasklet_finish()]: Ending request, cmd (37)
MMC: req done (37): 1: 00000000 00000000 00000000 00000000
MMC: starting cmd 37 arg 00000000 flags 00000015
sdhci [sdhci_tasklet_finish()]: Ending request, cmd (37)
MMC: req done (37): 1: 00000000 00000000 00000000 00000000
MMC: starting cmd 01 arg 00000000 flags 00000061
sdhci [sdhci_tasklet_finish()]: Ending request, cmd (1)
MMC: req done (01): 1: 00000000 00000000 00000000 00000000
sdhci [sdhci_set_ios()]: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0

So for some reason suspend&resume seems to screw up the registers and double 
the clock speed.
  Also I just noticed that if the machine has been through at least one 
suspend&resume cycle, rebooting no longer works. All processes exit cleanly, 
but the system just hangs when it should shut down.
  So it seems quite likely that suspend&resume doesn't really work the way it 
should in this machine (Asus S5A notebook) and sdhci triggers the problem.

-- 
Jani-Matti Hätinen
