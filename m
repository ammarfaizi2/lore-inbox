Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272287AbTHNKtN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 06:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272289AbTHNKtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 06:49:13 -0400
Received: from out001pub.verizon.net ([206.46.170.140]:48326 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S272287AbTHNKtB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 06:49:01 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: Andrew McGregor <andrew@indranet.co.nz>
Subject: Re: [PATCH] O13int for interactivity
Date: Thu, 14 Aug 2003 06:48:59 -0400
User-Agent: KMail/1.5.1
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200308050207.18096.kernel@kolivas.org> <200308130833.43362.gene.heskett@verizon.net> <1800000.1060837436@ijir>
In-Reply-To: <1800000.1060837436@ijir>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200308140648.59547.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [151.205.63.243] at Thu, 14 Aug 2003 05:49:00 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 August 2003 01:03, Andrew McGregor wrote:
>Ah.  I see you have framebuffer console on, whereas I have plain VGA
>console only.  Try turning framebuffer off; two drivers for the same
>hardware may well fight over it.  My X isn't patched, it just has
> their driver modules and the libraries installed.
>
>Andrew

Currently I booted to test3-mm2 with the bugoff patch, and using the x 
nv drivers and everything in the video dept is cool.  I see by dmesg 
that the vesafb isn't being used so I'll take that out in addition 
the next time I switch to the nvidia drivers.

I might add that test3-mm2 appeared to handle this mornings amanda run 
more like it would have run under 2.4, a pretty nice improvement over 
the bare test3, which appeared to shove amanda to the back of the 
queue most of the time.

>From dmesg, snippets:

Kernel command line: ro root=/dev/hda3 hdc=ide-scsi noapic vga=791
ide_setup: hdc=ide-scsi
Found and enabled local APIC!
current: c03c59c0
current->thread_info: c0454000
[...]
Initializing RT netlink socket
spurious 8259A interrupt: IRQ7.
PCI: PCI BIOS revision 2.10 entry at 0xfb4e0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router default [1106/3099] at 0000:00:00.0
rivafb: nVidia device/chipset 10DE0111
rivafb: Detected CRTC controller 0 being used
rivafb: RIVA MTRR set to ON
rivafb: PCI nVidia NV10 framebuffer ver 0.9.5b (nVidiaGeForce2-M, 32MB 
@ 0xE0000000)
Console: switching to colour frame buffer device 80x30
[...]
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 54610H6, ATA DISK drive
hda: IRQ probe failed (0xffffffba)
hdb: IRQ probe failed (0xffffffba)
hdb: IRQ probe failed (0xffffffba)

those last 3 lines are new to 2.6.

Comments?

>--On Wednesday, August 13, 2003 08:33:43 AM -0400 Gene Heskett
>
><gene.heskett@verizon.net> wrote:
>> On Wednesday 13 August 2003 01:43, Andrew McGregor wrote:
>>> --On Wednesday, August 13, 2003 01:24:31 AM -0400 Gene Heskett
>>>
>>> <gene.heskett@verizon.net> wrote:
>>>> Unrelated question:  I've applied the 2.6 patches someone
>>>> pointed me at to the nvidia-linux-4496-pkg2 after figuring out
>>>> how to get it to unpack and leave itself behind, so x can be run
>>>> on 2.6 now. But its a 100% total crash to exit x by any method
>>>> when using it that way.
>>>>
>>>> Has the patch been updated in the last couple of weeks to
>>>> prevent that now?  It takes nearly half an hour to e2fsck a
>>>> hundred gigs worth of drives, and its going to bite me if I
>>>> don't let the system settle before I crash it to reboot,
>>>> finishing the reboot with the hardware reset button.
>>>>
>>>> Better yet, a fresh pointer to that site.
>>>
>>> http://www.minion.de/
>>>
>>> Works fine for me, as of 2.6.0-test1 (which is when I downloaded
>>> the patch).  I don't get the crash on either of my systems
>>> (GeForce2Go P3 laptop and GeForce4 Athlon desktop).
>>>
>>> Andrew
>>
>> I see some notes about patching X, which I haven't done.  That
>> might be it.  I also doublechecked that I'm running the correct
>> makefile, and get this:
>>
>> [root@coyote NVIDIA-Linux-x86-1.0-4496-pkg2]# ls -lR * |grep
>> Makefile -rw-r--r--    1 root     root         3623 Jul 16 22:56
>> Makefile -rw-r--r--    1 root     root         7629 Aug  5 22:24
>> Makefile -rw-r--r--    1 root     root         7629 Aug  5 21:46
>> Makefile.kbuild -rw-r--r--    1 root     root         4865 Aug  5
>> 21:46 Makefile.nvidia [root@coyote
>> NVIDIA-Linux-x86-1.0-4496-pkg2]# cd
>> ../NVIDIA-Linux-x86-1.0-4496-pkg2-4-2.4/ [root@coyote
>> NVIDIA-Linux-x86-1.0-4496-pkg2-4-2.4]# ls -lR * |grep Makefile
>> -rw-r--r-- 1 root     root         3623 Jul 16 22:56 Makefile
>> -rw-r--r--    1 root     root         5665 Jul 16 22:56 Makefile
>> [root@coyote NVIDIA-Linux-x86-1.0-4496-pkg2-4-2.4]#
>>
>> My video card, from an lspci:
>> 01:00.0 VGA compatible controller: nVidia Corporation NV11
>> [GeForce2 MX DDR] (rev b2)
>>
>> And the XFree86 version is:
>> 3.2.1-21
>>
>> Interesting to note that the 'nv' driver that comes with X
>> does not do this.  But it also has no openGL and such.
>> We are instructed to remove agp support from the kernel, and
>> use that which is in the nvidia kit, and I just checked the
>> .config, and its off, so thats theoreticly correct.  A grep
>> for FB stuff returns this:
>>
>> CONFIG_FB=y
>># CONFIG_FB_CIRRUS is not set
>># CONFIG_FB_PM2 is not set
>># CONFIG_FB_CYBER2000 is not set
>># CONFIG_FB_IMSTT is not set
>># CONFIG_FB_VGA16 is not set
>> CONFIG_FB_VESA=y
>># CONFIG_FB_HGA is not set
>> CONFIG_FB_RIVA=y
>># CONFIG_FB_MATROX is not set
>># CONFIG_FB_RADEON is not set
>># CONFIG_FB_ATY128 is not set
>># CONFIG_FB_ATY is not set
>># CONFIG_FB_SIS is not set
>># CONFIG_FB_NEOMAGIC is not set
>># CONFIG_FB_3DFX is not set
>># CONFIG_FB_VOODOO1 is not set
>># CONFIG_FB_TRIDENT is not set
>># CONFIG_FB_PM3 is not set
>># CONFIG_FB_VIRTUAL is not set
>>
>> I'd assume the 'RIVA' fb is the correct one, its working in
>> 2.4, although I can induce a crash there by switching from X
>> to a virtual console, and then attempting to switch back to X.
>> That will generally bring the machine down.  It is perfectly ok
>> to do that, repeatedly, when running the nv driver from X.
>>
>> --
>> Cheers, Gene
>> AMD K6-III@500mhz 320M
>> Athlon1600XP@1400mhz  512M
>> 99.27% setiathome rank, not too shabby for a WV hillbilly
>> Yahoo.com attornies please note, additions to this message
>> by Gene Heskett are:
>> Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

