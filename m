Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbTIKUmJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 16:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbTIKUmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 16:42:08 -0400
Received: from mail5.intermedia.net ([206.40.48.155]:54533 "EHLO
	mail5.intermedia.net") by vger.kernel.org with ESMTP
	id S261527AbTIKUk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 16:40:59 -0400
Subject: Re: [OOPS] Linux-2.6.0-test5-bk
From: Ranjeet Shetye <ranjeet.shetye2@zultys.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030911202848.GA14031@kroah.com>
References: <1063232210.4441.14.camel@ranjeet-pc2.zultys.com>
	 <20030910154608.14ad0ac8.akpm@osdl.org>
	 <1063239544.1328.22.camel@ranjeet-pc2.zultys.com>
	 <20030911002404.GA7178@kroah.com>
	 <1063240611.1327.37.camel@ranjeet-pc2.zultys.com>
	 <20030911024054.GA7566@kroah.com>
	 <1063311985.1328.101.camel@ranjeet-pc2.zultys.com>
	 <20030911202848.GA14031@kroah.com>
Content-Type: text/plain
Organization: Zultys Technologies Inc.
Message-Id: <1063313038.1807.109.camel@ranjeet-pc2.zultys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 11 Sep 2003 13:43:58 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-09-11 at 13:28, Greg KH wrote:
> On Thu, Sep 11, 2003 at 01:26:26PM -0700, Ranjeet Shetye wrote:
> > On Wed, 2003-09-10 at 19:40, Greg KH wrote:
> > > On Wed, Sep 10, 2003 at 05:36:51PM -0700, Ranjeet Shetye wrote:
> > > > On Wed, 2003-09-10 at 17:24, Greg KH wrote:
> > > > > On Wed, Sep 10, 2003 at 05:19:05PM -0700, Ranjeet Shetye wrote:
> > > > > > 
> > > > > > Your changes fixed the issue. Thanks a lot for your help. I still get
> > > > > > this call trace, but no more OOPS on bootup.
> > > > > > 
> > > > > > kobject_register failed for Ensoniq AudioPCI (-17)
> > > > > > Call Trace:
> > > > > >  [<c026f45c>] kobject_register+0x50/0x59
> > > > > >  [<c02f8003>] bus_add_driver+0x4c/0xaf
> > > > > >  [<c02f8453>] driver_register+0x31/0x35
> > > > > >  [<c027c3bf>] pci_populate_driver_dir+0x29/0x2b
> > > > > >  [<c027c491>] pci_register_driver+0x5e/0x83
> > > > > >  [<c06a145f>] alsa_card_ens137x_init+0x15/0x41
> > > > > >  [<c068475a>] do_initcalls+0x2a/0x97
> > > > > >  [<c012e920>] init_workqueues+0x12/0x2a
> > > > > >  [<c01050a3>] init+0x39/0x196
> > > > > >  [<c010506a>] init+0x0/0x196
> > > > > >  [<c0108f31>] kernel_thread_helper+0x5/0xb
> > > > > 
> > > > > Odds are that the pci driver is trying to register 2 drivers with the
> > > > > pci core with the same name.  What does /sys/bus/pci/drivers show?
> > > > 
> > > > I didn't find a /proc/sys/bus/pci/drivers, but I did find a
> > > > /proc/bus/pci/devices - which is what I am guessing you meant. If you
> > > > did in fact mean '/proc/sys/bus/pci/drivers' then I dont have any such
> > > > file. In fact I dont have a bus sub-directory under /proc/sys/
> > > 
> > > No, look at what I asked for above, "/sys/bus/pci..."  I don't care about
> > > /proc at all :)
> > > 
> > > sysfs is mounted at /sys.
> > 
> > Actually I don't know what part I am missing, but I dont have a /sys
> > directory at all. That's why I assumed you might be referring to
> > /proc/sys. I've attached my .config. Is there some option I need to turn
> > on ? I looked and couldn't find it. (The fs/Makefile has a obj-y for
> > sysfs and there is no CONFIG_ parameter in any file in fs/sysfs). I dont
> > have a top level /sys directory. Is that the problem ? How do i get my
> > sysfs running ?
> 
> mkdir /sys
> mount -t sysfs none /sys
> 
> thanks,
> 
> greg k-h

he, he. thanks for that. Didn't know what I was missing. Will drop a
line to Gentoo folks to update their x86 installation guide with this
gem.

Here's the listing from "/sys/bus/pci/drivers"

OUTPUT of "/bin/ls -c1 /sys/bus/pci/drivers"


ALI 5451
AZF3328
Digigram VX222
EMU10K1_Audigy
ES1968 (ESS Maestro
ESS ES1938 (Solo-1)
FM801
ICE1712
ICE1724
Intel ICH
Intel ICH Joystick
Maestro3
NeoMagic 256
RME Digi32
RME Digi96
RME Digi9652 (Hammerfall
RME Hammerfall DSP
S3 SonicVibes
Sound Fusion CS46xx
Trident4DWaveAudio
VIA 82xx Audio
Yamaha DS-XG PCI
korg1212
ALS4000
C-Media PCI
CS4281
Ensoniq AudioPCI
ehci_hcd
uhci-hcd
PCI IDE
PIIX IDE
RZ1000 IDE
8139too
e100
e1000
agpgart-ali
agpgart-amdk7
agpgart-intel
agpgart-serverworks
agpgart-sis
agpgart-via
parport_pc
serial







OUTPUT of "find /sys/bus/pci/drivers"

/sys/bus/pci/drivers
/sys/bus/pci/drivers/Digigram VX222
/sys/bus/pci/drivers/Digigram VX222/new_id
/sys/bus/pci/drivers/ICE1724
/sys/bus/pci/drivers/ICE1724/new_id
/sys/bus/pci/drivers/ICE1712
/sys/bus/pci/drivers/ICE1712/new_id
/sys/bus/pci/drivers/Yamaha DS-XG PCI
/sys/bus/pci/drivers/Yamaha DS-XG PCI/new_id
/sys/bus/pci/drivers/Trident4DWaveAudio
/sys/bus/pci/drivers/Trident4DWaveAudio/new_id
/sys/bus/pci/drivers/RME Hammerfall DSP
/sys/bus/pci/drivers/RME Hammerfall DSP/new_id
/sys/bus/pci/drivers/RME Digi9652 (Hammerfall
/sys/bus/pci/drivers/RME Digi9652 (Hammerfall/new_id
/sys/bus/pci/drivers/NeoMagic 256
/sys/bus/pci/drivers/NeoMagic 256/new_id
/sys/bus/pci/drivers/korg1212
/sys/bus/pci/drivers/korg1212/new_id
/sys/bus/pci/drivers/EMU10K1_Audigy
/sys/bus/pci/drivers/EMU10K1_Audigy/new_id
/sys/bus/pci/drivers/Sound Fusion CS46xx
/sys/bus/pci/drivers/Sound Fusion CS46xx/new_id
/sys/bus/pci/drivers/ALI 5451
/sys/bus/pci/drivers/ALI 5451/new_id
/sys/bus/pci/drivers/AZF3328
/sys/bus/pci/drivers/AZF3328/new_id
/sys/bus/pci/drivers/VIA 82xx Audio
/sys/bus/pci/drivers/VIA 82xx Audio/new_id
/sys/bus/pci/drivers/S3 SonicVibes
/sys/bus/pci/drivers/S3 SonicVibes/new_id
/sys/bus/pci/drivers/RME Digi96
/sys/bus/pci/drivers/RME Digi96/new_id
/sys/bus/pci/drivers/RME Digi32
/sys/bus/pci/drivers/RME Digi32/new_id
/sys/bus/pci/drivers/Maestro3
/sys/bus/pci/drivers/Maestro3/new_id
/sys/bus/pci/drivers/Intel ICH Joystick
/sys/bus/pci/drivers/Intel ICH Joystick/new_id
/sys/bus/pci/drivers/Intel ICH
/sys/bus/pci/drivers/Intel ICH/new_id
/sys/bus/pci/drivers/Intel ICH/0000:00:1f.5
/sys/bus/pci/drivers/FM801
/sys/bus/pci/drivers/FM801/new_id
/sys/bus/pci/drivers/ES1968 (ESS Maestro
/sys/bus/pci/drivers/ES1968 (ESS Maestro/new_id
/sys/bus/pci/drivers/ESS ES1938 (Solo-1)
/sys/bus/pci/drivers/ESS ES1938 (Solo-1)/new_id
/sys/bus/pci/drivers/Ensoniq AudioPCI
/sys/bus/pci/drivers/Ensoniq AudioPCI/new_id
/sys/bus/pci/drivers/CS4281
/sys/bus/pci/drivers/CS4281/new_id
/sys/bus/pci/drivers/C-Media PCI
/sys/bus/pci/drivers/C-Media PCI/new_id
/sys/bus/pci/drivers/ALS4000
/sys/bus/pci/drivers/ALS4000/new_id
/sys/bus/pci/drivers/uhci-hcd
/sys/bus/pci/drivers/uhci-hcd/new_id
/sys/bus/pci/drivers/uhci-hcd/0000:00:1d.2
/sys/bus/pci/drivers/uhci-hcd/0000:00:1d.1
/sys/bus/pci/drivers/uhci-hcd/0000:00:1d.0
/sys/bus/pci/drivers/ehci_hcd
/sys/bus/pci/drivers/ehci_hcd/new_id
/sys/bus/pci/drivers/ehci_hcd/0000:00:1d.7
/sys/bus/pci/drivers/PCI IDE
/sys/bus/pci/drivers/PCI IDE/new_id
/sys/bus/pci/drivers/RZ1000 IDE
/sys/bus/pci/drivers/RZ1000 IDE/new_id
/sys/bus/pci/drivers/PIIX IDE
/sys/bus/pci/drivers/PIIX IDE/new_id
/sys/bus/pci/drivers/PIIX IDE/0000:00:1f.1
/sys/bus/pci/drivers/8139too
/sys/bus/pci/drivers/8139too/new_id
/sys/bus/pci/drivers/8139too/0000:01:08.0
/sys/bus/pci/drivers/e1000
/sys/bus/pci/drivers/e1000/new_id
/sys/bus/pci/drivers/e1000/0000:01:0c.0
/sys/bus/pci/drivers/e100
/sys/bus/pci/drivers/e100/new_id
/sys/bus/pci/drivers/parport_pc
/sys/bus/pci/drivers/parport_pc/new_id
/sys/bus/pci/drivers/serial
/sys/bus/pci/drivers/serial/new_id
/sys/bus/pci/drivers/agpgart-via
/sys/bus/pci/drivers/agpgart-via/new_id
/sys/bus/pci/drivers/agpgart-serverworks
/sys/bus/pci/drivers/agpgart-serverworks/new_id
/sys/bus/pci/drivers/agpgart-sis
/sys/bus/pci/drivers/agpgart-sis/new_id
/sys/bus/pci/drivers/agpgart-intel
/sys/bus/pci/drivers/agpgart-intel/new_id
/sys/bus/pci/drivers/agpgart-intel/0000:00:00.0
/sys/bus/pci/drivers/agpgart-amdk7
/sys/bus/pci/drivers/agpgart-amdk7/new_id
/sys/bus/pci/drivers/agpgart-ali
/sys/bus/pci/drivers/agpgart-ali/new_id

thanks,
-- 

Ranjeet Shetye
Senior Software Engineer
Zultys Technologies
Ranjeet dot Shetye2 at Zultys dot com
http://www.zultys.com/
 
The views, opinions, and judgements expressed in this message are solely
those of the author. The message contents have not been reviewed or
approved by Zultys.


