Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317141AbSGSWdb>; Fri, 19 Jul 2002 18:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317148AbSGSWd3>; Fri, 19 Jul 2002 18:33:29 -0400
Received: from [209.184.141.189] ([209.184.141.189]:10515 "HELO UberGeek")
	by vger.kernel.org with SMTP id <S317140AbSGSWdZ> convert rfc822-to-8bit;
	Fri, 19 Jul 2002 18:33:25 -0400
Subject: Re: Linux Kernel 2.4.18 and 2.4.19 problems
From: Austin Gonyou <austin@digitalroadkill.net>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: Thomas =?ISO-8859-1?Q?Lang=E5s?= <tlan@stud.ntnu.no>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20020719140416.A25577@eng2.beaverton.ibm.com>
References: <20020719192607.GA13880@stud.ntnu.no>
	  <20020719140416.A25577@eng2.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 19 Jul 2002 17:36:17 -0500
Message-Id: <1027118177.7800.15.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two suggestions. 

Use SGI's XFS installer and move to XFS on those boxen. You will not be
unhappy.

Second suggestion, once you've installed a RH 7.3 XFS installed box,
then go get 2.4.18-aa and recompile that and use it. 
You will need to make a change to the scsi_scan.c file to add
BLIST_LARGELUN support to which ever devices you're using. 

(or use the 2.4.19-rc1-aa2 since it might be done already, assuming your
using PV250's and up)

Do that, and you won't have any more problems on those boxen. Feel free
to email me for more details.


On Fri, 2002-07-19 at 16:04, Patrick Mansfield wrote:
> On Fri, Jul 19, 2002 at 09:26:07PM +0200, Thomas Langås wrote:
> > We've got a few Dell PowerEdge 2650 machines, and thought they would
> > become nice fileservers, and we installed RedHat Linux 7.3 on them.
> > So far, so good; after the installation, pretty much was downhill
> > from there. With RedHat's 2.4.18-3 and 2.4.18-5 kernel we detect
> > all disks connected through our QLogic FC 2200 HBA's, with 
> > vanilla 2.4.18 and 2.4.19-rc2, we detect nothing; and we've tried
> > Qlogic's 6.0beta13 and 6.1beta2 drivers, as well as the driver
> > that comes with redhat's release. We're currently running an almost
> > identical configuration, only diff. is one HBA pr server, and
> > the servers are 2550's and not 2650's. 
> > 
> > Ok, to sum up problems:
> > 
> > With redhat kernels:
> > * Disks found, _but_ after about 2-3 mins with heavy I/O on
> >   FC HBA's the machine dies, and only thing working is cold boot
> > 
> > With vanilla kernels:
> > * Disks not found, so we don't know about I/O problems.
> > 
> > 
> > Anyone have any ideas?
> > 
> > 
> > Here's dmesg and lspci -vvvxx, if anything else is needed, please
> > tell me, and I'll provide you with the info:
> > 
> > test4:~# dmesg
> 
> 
> > Processors: 4
> > Kernel command line: auto BOOT_IMAGE=linux ro root=802 BOOT_FILE=/boot/bzImage-2.4.18-3 max_scsi_luns=128
> 
> So this is the dmesg for the redhat 2.4.18-3? You said above that
> it found the disks, but, further down the qla driver inits and shows:
> 
> > qla2x00_set_info starts at address = f8836060
> > qla2x00: Found  VID=1077 DID=2200 SSVID=1077 SSDID=2
> > scsi1: Found a QLA2200  @ bus 2, device 0x4, irq 16, iobase 0xdc00
> > scsi(1): Allocated 4096 SRB(s)
> > PCI: Setting latency timer of device 02:04.0 to 64
> > scsi(1): Configure NVRAM parameters...
> > scsi(1): 64 Bit PCI Addressing Enabled
> > scsi(1): Verifying loaded RISC code...
> > scsi(1): Verifying chip...
> > scsi(1): Waiting for LIP to complete...
> > scsi(1): Cable is unplugged...
> > qla2x00: Found  VID=1077 DID=2200 SSVID=1077 SSDID=2
> > scsi2: Found a QLA2200  @ bus 2, device 0x5, irq 17, iobase 0xd800
> > scsi(2): Allocated 4096 SRB(s)
> > PCI: Setting latency timer of device 02:05.0 to 64
> > scsi(2): Configure NVRAM parameters...
> > scsi(2): 64 Bit PCI Addressing Enabled
> > scsi(2): Verifying loaded RISC code...
> > scsi(2): Verifying chip...
> > scsi(2): Waiting for LIP to complete...
> > scsi(2): Cable is unplugged...
> > scsi1 : QLogic QLA2200 PCI to Fibre Channel Host Adapter: bus 2 device 4 irq 16
> >         Firmware version:  2.02.03, Driver version 6.1b2
> > scsi2 : QLogic QLA2200 PCI to Fibre Channel Host Adapter: bus 2 device 5 irq 17
> >         Firmware version:  2.02.03, Driver version 6.1b2
> 
> It complains about "Cable is unplugged", and does not find any drives. 
> So, it looks like your redhat kernel is not finding any drives.
> 
> You might want to check the hardware and connections. I've seen the qla
> (I'm using some beta6 with 2.5.25) get confused as to the state of the
> adapter and its connection.
> 
> If you turn on scsi logging (be careful, if syslog is running you can get
> infinite logging), and insmod your driver, you might get some useful
> information, I use:
> 
> 	echo scsi log scan 5  >/proc/scsi/scsi
> 
> The above is safe to use with syslog running (since it logs the scsi
> scanning that happens when the adapter comes up, but not all IO).
> 
> Also, cat /proc/scsi/scsi and /proc/scsi/qla*/[0-9] and see what they show.
> 
> If the adapter appears to find devices, but scanning does not (likely
> lun problems), try manually scanning for a device, for example:
> 
> 	echo scsi add-single-device 1 0 0 0 >/proc/scsi/scsi
> 
> Where the numbering above is host, channel, target-id, and then lun.
> 
> -- Patrick Mansfield
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Austin Gonyou <austin@digitalroadkill.net>
