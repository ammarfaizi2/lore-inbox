Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVFYUIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVFYUIA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 16:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbVFYUIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 16:08:00 -0400
Received: from iron.pdx.net ([207.149.241.18]:33706 "EHLO iron.pdx.net")
	by vger.kernel.org with ESMTP id S261253AbVFYUHo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 16:07:44 -0400
Subject: Re: FW: PROBLEM: Devices behind PCI Express-to-PCI bridge not
	mapped
From: Sean Bruno <sean.bruno@dsl-only.net>
To: karim@opersys.com
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "Hodle, Brian" <BHodle@harcroschem.com>
In-Reply-To: <1119729766.9540.0.camel@oscar.metro1.com>
References: <D9A1161581BD7541BC59D143B4A06294021FAA68@KCDC1>
	 <42BDB338.9030800@opersys.com>  <1119729766.9540.0.camel@oscar.metro1.com>
Content-Type: text/plain
Date: Sat, 25 Jun 2005 13:05:42 -0700
Message-Id: <1119729942.9614.1.camel@oscar.metro1.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-06-25 at 13:02 -0700, Sean Bruno wrote:
> On Sat, 2005-06-25 at 15:40 -0400, Karim Yaghmour wrote:
> > I've got a K8N-DL here myself and it's got a bunch of issues, some of
> > which seem to be outside the realm of the OS. Like others have
> > mentioned, the NIC and USB are out of reach.
> > 
> > Just for reference:
> > - hda = DVD
> > - hdc = regular IDE drive
> > - sda = SATA drive
> > - video = ATI Radeon X300 (MSI-branded)
> > 
> > For quite some time, I struggled trying to get any FCx to install, but
> > they would all fail trying to mount the DVD on secondary IDE master.
> > Then I swapped a regular IDE drive I have on primary IDE master with
> > the DVD and then the install went through. Nevertheless, Linux still
> > can't deal with the secondary IDE, the HD produces DMA timeouts and
> > eventually the kernel just shuts down the DMA on hdc. It's worth
> > pointing out that winxp64 which used to boot when DVD was hdc, now
> > simply continues showing the progress bar forever (with the IDE drive
> > as hdc). It too doesn't like the secondary IDE. For now, the only way
> > to get a clean boot in either OS is to for me to disable secondary IDE
> > altogether.
> 
> > In all cases, Linux just can't deal with the main SATA drive if it's
> > connected to the ck804. It used to just freeze loading sata_nv, now
> > it just stays there when printing info about the disk during boot.
> > The machine is still responding (ctrl-alt-del does get to the kernel),
> > but it can't finish the bootup process. Eventually, I had to plug
> > the sata to the Silicon Image controller to get it to work with
> > Linux. Unfortunately, winxp64 has got no problem with booting off a
> > SATA drive connected to the same ck804 :(
> > 
> 
I got FC4 to install using the Silicon Image SATA controller and an IDE
CDROM.  I also inserted a PCI 10/100 card to get network support.  After
installing FC4(or any distro for that matter), edit your inittab before 
you reboot and set it to boot into run level 3.  Once you have rebooted,
you can run an update(via yum) to get the latest kernel and Xorg stuff.
This allowed me to boot the machine into level 5 and my video card did
function(NV 6200).
> 
> > 
> > When vendor installed winxp64, they reported having to use an nvidia
> > video card instead of the ATI one, otherwise they couldn't install
> > the drivers for the chipset (ck804) for "some obscure reason", as
> > they said. I'm guessing they were just getting the same problems I
> > was seing with Linux. This could actually be a hint of a conflict
> > between the PCIe video card and the secondary IDE. Others I've
> > spoken to who have this board don't report problems on the secondary
> > IDE, but they don't have the same card on the PCIe.
> > 
> > I'm guessing this board is in need of a BIOS upgrade, but I've got
> > the latest one from ASUS and, as others mentioned, their tech
> > support is so-so.
> > 
> > ... just thought I'd write this down for others who may be having
> > similar problems ...
> > 
> > Karim

Indeed, ASUS is kind of "sucking" in the tech support realm on this
issue.  I have been poking around with "dmidecode" and "lshw" and found
some really interesting stuff.

Handle 0x0023
        DMI type 9, 13 bytes.
        System Slot Information
                Designation: PCIEX1_1
                Type: <OUT OF SPEC><OUT OF SPEC>
                Current Usage: In Use
                Length: Other
                Characteristics:
                        5.0 V is provided
                        PME signal is supported
Handle 0x0024
        DMI type 9, 13 bytes.
        System Slot Information
                Designation: PCIEX16_1
                Type: <OUT OF SPEC><OUT OF SPEC>
                Current Usage: Available
                Length: Other
                Characteristics:
                        5.0 V is provided
                        PME signal is supported

I am assuming that this is causing some kind of weirdness that disables
the use of the NV SATA, USB, Sound and the Broadcom ethernet device.
Any ideas what the "OUT OF SPEC" warning actually means?

Sean

