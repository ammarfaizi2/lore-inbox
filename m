Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291508AbSBADbB>; Thu, 31 Jan 2002 22:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291509AbSBADam>; Thu, 31 Jan 2002 22:30:42 -0500
Received: from tomts12.bellnexxia.net ([209.226.175.56]:13816 "EHLO
	tomts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S291508AbSBADab>; Thu, 31 Jan 2002 22:30:31 -0500
Subject: usb-storage (was: Re: Oops in 2.5.1)
From: Tim Coleman <tim@timcoleman.com>
To: Jeff Garzik <garzik@havoc.gtf.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020130221605.C22862@havoc.gtf.org>
In-Reply-To: <1012445595.7956.4.camel@tux.epenguin.org> 
	<20020130221605.C22862@havoc.gtf.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 31 Jan 2002 22:30:24 -0500
Message-Id: <1012534229.1148.7.camel@tux.epenguin.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-01-30 at 22:16, Jeff Garzik wrote:
> On Wed, Jan 30, 2002 at 09:53:13PM -0500, Tim Coleman wrote:
> > I got an oops when loading usb with hotplug in kernel 2.5.1
> > I realize that this isn't the current version but I thought
> > I would send it in anyway, because I haven't got 2.5.3 yet.
> > 
> > The device is not accessible at all with this kernel, and I notice
> > that the trace mentions the 8139_too ethernet driver.
> 
> Can you rebuild with 8139too and USB inside the kernel, instead of
> modules, and attempt to reproduce?
> 
> 8139 has a bunch of assert() calls in that area, which make me doubt the
> veracity of the ksymoops output :/
> 
> Also make sure you are sending the oops through the proper system.map...
> 

I can't really compile the 8139too into the kernel because I have two of
them. :)

I just tried 2.5.3, and I didn't get an oops, but the device wasn't
loaded correctly either.  It works fine in the last 2.4.x kernel I used
(2.4.14).

Jan 31 22:19:09 tux kernel: hub.c: new USB device on bus 1 path /2,
assigned address 2
Jan 31 22:19:09 tux kernel: usb.c: USB device 2 (vend/prod 0x54c/0x2e)
is not claimed by any active driver.
Jan 31 22:19:09 tux /etc/hotplug/usb.agent: Setup usb-storage for USB
product 54c/2e/300
Jan 31 22:19:09 tux kernel: Initializing USB Mass Storage driver...
Jan 31 22:19:09 tux kernel: usb.c: registered new driver usb-storage
Jan 31 22:19:09 tux kernel: scsi0 : SCSI emulation for USB Mass Storage
devices
Jan 31 22:19:09 tux kernel:   Vendor: Sony      Model: Sony DSC         
Rev: 3.00
Jan 31 22:19:09 tux kernel:   Type:   Direct-Access                     
ANSI SCSI revision: 02
Jan 31 22:19:09 tux kernel: Attached scsi removable disk sda at scsi0,
channel 0, id 0, lun 0
Jan 31 22:19:09 tux kernel: SCSI device sda: 7904 512-byte hdwr sectors
(4 MB)
Jan 31 22:19:09 tux kernel: sda: Write Protect is off
Jan 31 22:19:09 tux kernel: 
/dev/scsi/host0/bus0/target0/lun0:<4>usb-uhci.c: interrupt, status 28,
frame# 1841
Jan 31 22:19:09 tux kernel: usb-uhci.c: Host controller halted, trying
to restart.
Jan 31 22:19:09 tux last message repeated 31 times
Jan 31 22:19:39 tux kernel: usb-uhci.c: interrupt, status 28, frame#
1128
Jan 31 22:19:39 tux kernel: usb-uhci.c: Host controller halted, trying
to restart.
Jan 31 22:19:39 tux last message repeated 31 times
Jan 31 22:20:09 tux kernel: usb-uhci.c: interrupt, status 3, frame# 396
Jan 31 22:20:09 tux kernel: usb.c: USB disconnect on device 2
Jan 31 22:20:10 tux kernel: hub.c: new USB device on bus 1 path /2,
assigned address 3
Jan 31 22:20:14 tux kernel: usb-storage: host_reset() requested but not
implemented
Jan 31 22:20:24 tux kernel: scsi: device set offline - command error
recover failed: host 0 channel 0 id 0 lun 0
Jan 31 22:20:24 tux kernel: SCSI disk error : host 0 channel 0 id 0 lun
0 return code = 6050000
Jan 31 22vim :20:24 tux kernel: end_request: I/O error, dev 08:00,
sector 0
Jan 31 22:20:24 tux kernel: end_request: I/O error, dev 08:00, sector 2
Jan 31 22:20:24 tux kernel: end_request: I/O error, dev 08:00, sector 0
Jan 31 22:20:24 tux kernel:  unable to read partition table
Jan 31 22:20:24 tux kernel: WARNING: USB Mass Storage data integrity not
assured
Jan 31 22:20:24 tux kernel: USB Mass Storage device found at 2
Jan 31 22:20:24 tux kernel: USB Mass Storage support registered.
Jan 31 22:20:25 tux /etc/hotplug/usb.agent: missing kernel or user mode
driver usb-storage
Jan 31 22:20:25 tux kernel: scsi1 : SCSI emulation for USB Mass Storage
devices
Jan 31 22:20:25 tux kernel: WARNING: USB Mass Storage data integrity not
assured
Jan 31 22:20:25 tux kernel: USB Mass Storage device found at 3
Jan 31 22:20:25 tux /etc/hotplug/usb.agent: Setup usb-storage for USB
product 54c/2e/300
Jan 31 22:20:25 tux /etc/hotplug/usb.agent: missing kernel or user mode
driver usb-storage


lsmod shows that the driver is loaded


tux:/etc# lsmod
Module                  Size  Used by    Not tainted
vfat                    9596   0  (autoclean)
fat                    30648   0  (autoclean) [vfat]
usb-storage            20476   0  (unused)
ipt_MASQUERADE          1376   1  (autoclean)
iptable_nat            14644   1  (autoclean) [ipt_MASQUERADE]
ipt_state                768   2  (autoclean)
ip_conntrack           14284   2  (autoclean) [ipt_MASQUERADE
iptable_nat ipt_state]
iptable_filter          1920   1  (autoclean)
ip_tables              10816   6  [ipt_MASQUERADE iptable_nat ipt_state
iptable_filter]
parport_pc             12612   1  (autoclean)
lp                      6112   0  (autoclean)
parport                14368   1  (autoclean) [parport_pc lp]
8139too                12864   2  (autoclean)
crc32                    872   1  (autoclean) [8139too]
sd_mod                  9400   0  (autoclean)
scsi_mod               66808   3  (autoclean) [usb-storage sd_mod]
usb-uhci               21604   0  (unused)
usbcore                55756   1  [usb-storage usb-uhci]
es1371                 27232   1 
ac97_codec              9728   0  [es1371]
gameport                1628   0  [es1371]

-- 
Tim Coleman <tim@timcoleman.com>                       [43.28 N 80.31 W]
BMath, Honours Combinatorics and Optimization, University of Waterloo
 "They that can give up essential liberty to obtain a little temporary
  safety deserve neither liberty nor safety." -- Benjamin Franklin

