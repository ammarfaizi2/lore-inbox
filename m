Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262657AbTFCTS0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 15:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbTFCTS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 15:18:26 -0400
Received: from chaos.analogic.com ([204.178.40.224]:56206 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262657AbTFCTSU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 15:18:20 -0400
Date: Tue, 3 Jun 2003 15:34:43 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Jocelyn Mayer <jma@netgem.com>
cc: Georg Nikodym <georgn@somanetworks.com>, Ben Collins <bcollins@debian.org>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] ieee1394 sbp2 driver is broken for kernel >= 2.4.21-rc2
In-Reply-To: <1054666888.4967.114.camel@jma1.dev.netgem.com>
Message-ID: <Pine.LNX.4.53.0306031525250.26333@chaos>
References: <1054582582.4967.48.camel@jma1.dev.netgem.com> 
 <20030602163443.2bd531fb.georgn@somanetworks.com>  <1054588832.4967.77.camel@jma1.dev.netgem.com>
  <20030603113636.GX10102@phunnypharm.org>  <1054663917.4967.99.camel@jma1.dev.netgem.com>
  <20030603142712.6e7da879.georgn@somanetworks.com>
 <1054666888.4967.114.camel@jma1.dev.netgem.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jun 2003, Jocelyn Mayer wrote:

> On Tue, 2003-06-03 at 20:27, Georg Nikodym wrote:
> > On 03 Jun 2003 20:11:57 +0200
> > Jocelyn Mayer <jma@netgem.com> wrote:
> >
> > > Thanks for your help, but I think you're wrong:
> >
> > I doubt it.  Ben's one of the authorities on this stuff.
>
> Right, I can believe this.
>
> >
> > > First, I never trust hotplug or other tools like this:
> > > I do all insmod by hand, so I know all drivers have been loaded.
> > > What is hotplug supposed to do (but wasn't in previous driver
> > > version...) ?
> >
> > I compile this stuff directly into my kernel.  Doesn't make a
> > difference.
> >
> > > The second thing I see is that it used to work,
> > > before 2.4.21-rc2. The only difference is in the kernel driver,
> > > so it should work with no user-space tool, as it used to.
> > > If not, the driver is now buggy...
> >
> > Well, I've _always_ needed either rescan-scsi-bus.sh (or scsiadd -s
> > since I switched to Debian).  If there's some magic that you've been
> > doing that obviates this requirement, we're all ears.
> >
> > -g
>
> No magics.
> I must precise that I don't use any standard distribution:
> I bootstrapped my own distrib from scratch,
> using sources from the web.
> Also note that I don't have neither rescan-scsi-bus nor scsiadd
> anywhere on this machine.
>
> I just did a new test a few minutes ago.
> To be sure that there are nothing done that I can't control,
> I removed /sbin/hotplug (rm -f /sbin/hotplug).
>
> I did exactly:
>
> modprobe ieee1394
> modprobe cmp
> modprobe ohci1394
> modprobe amdtp
> modprobe sd_mod
> modprobe sbp2
>
> (I use modprobe so I don't have to write the whole path for insmod,
>  but do all step by step...)
>
> Before this I had:
> /proc/scsi/scsi:
> root:~$ cat /proc/scsi/scsi
> Attached devices:
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>   Vendor: SONY     Model: CD-RW  CRX800E   Rev: 1.3p
>   Type:   CD-ROM                           ANSI SCSI revision: 02
>
> After I inserted sbp2, I get:
>
> root:~$ cat /proc/scsi/scsi
> Attached devices:
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>   Vendor: SONY     Model: CD-RW  CRX800E   Rev: 1.3p
>   Type:   CD-ROM                           ANSI SCSI revision: 02
> Host: scsi1 Channel: 00 Id: 00 Lun: 00
>   Vendor: Maxtor 6 Model: Y080L0           Rev: YAR4
>   Type:   Direct-Access                    ANSI SCSI revision: 06
>
> The Maxtor disk is my Firewire one !
>
> I currently use 2.4.21-rc6 kernel with 2.4.21-rc1 ieee1394 stack:
>
> jocelyn:~$ cat /proc/version
> Linux version 2.4.21-rc6-compat (jocelyn@(none)) (gcc version 3.2) #3
> Sun Jun 1 21:02:23 CEST 2003
>
> jocelyn:~$ cat /proc/modules
> sbp2                   19024   0 (unused)
> sd_mod                 12332   0 (unused)
> amdtp                   8596   0 (unused)
> ohci1394               28016   0 [amdtp]
> cmp                     2532   0 [amdtp]
> ieee1394               45288   0 [sbp2 amdtp ohci1394 cmp]
> sungem                 25840   1 (autoclean)
> sungem_phy              5952   0 (autoclean) [sungem]
>
> jocelyn:~$ cat /proc/scsi/sbp2/1
> IEEE-1394 SBP-2 protocol driver (host: ohci1394)
> $Rev: 878 $ James Goodwin <jamesg@filanet.com>
> SBP-2 module load options:
> - Max speed supported: S400
> - Max sectors per I/O supported: 255
> - Max outstanding commands supported: 64
> - Max outstanding commands per lun supported: 1
> - Serialized I/O (debug): no
> - Exclusive login: yes
>
> ote that I don't have neither rescan-scsi-bus nor scsiadd
> anywhere on this machine.
>
> I just did a new test a few minutes ago.
> To be sure that there are nothing done that I can't control,
> I removed /sbin/hotplug (rm -f /sbin/hotplug).
>
> I did exactly:
>
> modprobe ieee1394
> modprobe cmp
> modprobe ohci1394
> modprobe amdtp
> modprobe sd_mod
> modprobe sbp2
>
> as root.
>
> (I use modprobe so I don't have to write the whole path for insmod,
>  but do all step by step...)
>
> Before this I had:
> /proc/scsi/scsi:
> root:~$ cat /proc/scsi/scsi
> Attached devices:
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>   Vendor: SONY     Model: CD-RW  CRX800E   Rev: 1.3p
>   Type:   CD-ROM                           ANSI SCSI revision: 02
>
> After I inserted sbp2, I get:
>
> root:~$ cat /proc/scsi/scsi
> Attached devices:
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>   Vendor: SONY     Model: CD-RW  CRX800E   Rev: 1.3p
>   Type:   CD-ROM                           ANSI SCSI revision: 02
> Host: scsi1 Channel: 00 Id: 00 Lun: 00
>   Vendor: Maxtor 6 Model: Y080L0           Rev: YAR4
>   Type:   Direct-Access                    ANSI SCSI revision: 06
>
> The Maxtor disk is my Firewire one !
>
> I currently use 2.4.21-rc6 kernel with 2.4.21-rc1 ieee1394 stack:
>
> jocelyn:~$ cat /proc/version
> Linux version 2.4.21-rc6-compat (jocelyn@(none)) (gcc version 3.2) #3
> Sun Jun 1 21:02:23 CEST 2003
>
> jocelyn:~$ cat /proc/modules
> sbp2                   19024   0 (unused)
> sd_mod                 12332   0 (unused)
> amdtp                   8596   0 (unused)
> ohci1394               28016   0 [amdtp]
> cmp                     2532   0 [amdtp]
> ieee1394               45288   0 [sbp2 amdtp ohci1394 cmp]
> sungem                 25840   1 (autoclean)
> sungem_phy              5952   0 (autoclean) [sungem]
>
> jocelyn:~$ cat /proc/scsi/sbp2/1
> IEEE-1394 SBP-2 protocol driver (host: ohci1394)
> $Rev: 878 $ James Goodwin <jamesg@filanet.com>
> SBP-2 module load options:
> - Max speed supported: S400
> - Max sectors per I/O supported: 255
> - Max outstanding commands supported: 64
> - Max outstanding commands per lun supported: 1
> - Serialized I/O (debug): no
> - Exclusive login: yes
>
> jocelyn:~$ cat /proc/bus/ieee1394/devices
> Node[00:1023]  GUID[000393fffeab0e76]:
>   Vendor ID: `Linux OHCI-1394' [0x000000]
>   Capabilities: 0x0083c0
>   Bus Options:
>     IRMC(1) CMC(1) ISC(1) BMC(0) PMC(0) GEN(8)
>     LSPD(2) MAX_REC(2048) CYC_CLK_ACC(0)
>   Host Node Status:
>     Host Driver     : ohci1394
>     Nodes connected : 2
>     Nodes active    : 2
>     SelfIDs received: 2
>     Irm ID          : [00:1023]
>     BusMgr ID       : [00:1023]
>     In Bus Reset    : no
>     Root            : no
>     Cycle Master    : no
>     IRM             : yes
>     Bus Manager     : yes
> Node[01:1023]  GUID[00d04b0ce0900195]:
>   Vendor ID: `Oxford  ' [0x00d04b]
>   Capabilities: 0x0083c0
>   Bus Options:
>     IRMC(0) CMC(0) ISC(0) BMC(0) PMC(0) GEN(0)
>     LSPD(0) MAX_REC(64) CYC_CLK_ACC(255)
>   Unit Directory 0:
>     Vendor/Model ID: Oxford   [00d04b] / 911G [000001]
>     Software Specifier ID: 00609e
>     Software Version: 010483
>     Driver: SBP2 Driver
>     Length (in quads): 8
>
>
> So, I'm quite sure that it should work with no special helper !
> Is there any other informations I should give,
> or things I should do to understand the problem ?
>
> --
> Jocelyn Mayer <jma@netgem.com>
>

Something else is fishy. If I put all the modules for my firewire
drive, in the correct order, in an initial RAM disk (initrd),
and then attempt to use the firewire drive as the root file-system,
it is not available. If I install all the modules for the firewire
drives from initrd, then mount a SCSI root file-system, the firewire
drive is still not available!!! An attempt to access the raw device
with `od` shows 'no such device or address'. If I remove all the
firewire modules, then install them again, like magic the drive
becomes available! This is not good magic. This is on 2.4.20 (RedHat 9
tools)

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

