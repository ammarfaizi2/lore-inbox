Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315628AbSFOW3M>; Sat, 15 Jun 2002 18:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315629AbSFOW3L>; Sat, 15 Jun 2002 18:29:11 -0400
Received: from ns3.maptuit.com ([204.138.244.3]:36100 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S315628AbSFOW3I>;
	Sat, 15 Jun 2002 18:29:08 -0400
Message-ID: <3D0BBF4B.42E355A6@torque.net>
Date: Sat, 15 Jun 2002 18:27:23 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.21 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: garloff@suse.de, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        sancho@dauskardt.de, linux-usb-devel@lists.sourceforge.net,
        linux1394-devel@lists.sourceforge.net
Subject: Re: /proc/scsi/map
In-Reply-To: <UTC200206152154.g5FLsCI23053.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> 
>     >Life would be easier if the scsi subsystem would just report which SCSI
>     >device (uniquely identified by the controller,bus,target,unit tuple) belongs
>     >to which high-level device. The information is available in the kernel.
>     >
>     >Attached patch does this:
>     >garloff@pckurt:/raid5/Kernel/src $ cat /proc/scsi/map
>     ># C,B,T,U       Type    onl     sg_nm   sg_dev  nm      dev(hex)
>     >0,0,00,00       0x05    1       sg0     c:15:00 sr0     b:0b:00
>     [...]
> 
>     Great, this was really missing badly.
> 
>     But how about adding another column: GUID.
>     Most usb-storage and (all?) FireWire devices have such a unique identitiy.
>     In contrast to native SCSI devices, these emulated SCSI devices on
>     hot-plugging busses will change their LUNs/IDs. Therefor the GUID is
>     really a must to be able to create stable names (laptop suspend, etc.).
> 
>     Both usb-storage and iee1394-sbp2 know the GUID. It only needs to be
>     communicated..
> 
> The usb-storage GUID is just one random item of information.
> One might wish for much more.
> 
> And: this information is already somewhere:
> 
> % cat /proc/scsi/sg/host_strs
> SCSI host adapter emulation for IDE ATAPI devices
> Iomega VPI2 (imm) interface
> SCSI emulation for USB Mass Storage devices
> SCSI emulation for USB Mass Storage devices
> %
> 
> This tells me that host 0 will be in ide-scsi, host 1 in imm,
> host 2 in usb-storage-0, host 3 in usb-storage-1.
> And
> 
> % cat /proc/scsi/ide-scsi/0
> SCSI host adapter emulation for IDE ATAPI devices
> % cat /proc/scsi/imm/1
> Version : 2.05 (for Linux 2.4.0)
> Parport : parport0
> Mode    : SPP
> % cat /proc/scsi/usb-storage-0/2
>    Host scsi2: usb-storage
>        Vendor: DataFab Systems Inc.
>       Product: USB CF+SM
> Serial Number: 5DC69477C6
>      Protocol: Transparent SCSI
>     Transport: Datafab Bulk-Only
>          GUID: 07c4a1090000005dc69477c6
>      Attached: Yes
> % cat /proc/scsi/usb-storage-1/3
>    Host scsi3: usb-storage
>        Vendor: SCM Microsystems Inc.
>       Product: eUSB SmartMedia / CompactFlash
> Serial Number: None
>      Protocol: Transparent SCSI
>     Transport: Control/Bulk-EUSB/SDDR09
>          GUID: 04e600050000000000000000
>      Attached: Yes
> %
> 
> A small utility that looks around in /proc is able to
> find the GUID. Of course it would be better when fewer
> heuristics were required.
> 
> Finally, the GUIDs you see here do not determine the LUN.
> So, there is no well-defined line in /proc/scsi/map
> where they would belong.

In lk 2.5 we are hoping that driverfs will give us an
"information bridge" between scsi pseudo devices
and other driver subsystems such as ide, usb and iee1394.
Mike Sullivan's persistent naming patch (that I mentioned
in my previous post on this thread) adds driverfs capability
into the scsi subsystem. Driverfs capability is already
in the ide and usb subsystems.

procfs, driverfs and devfs ...

Doug Gilbert
