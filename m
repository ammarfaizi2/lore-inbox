Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030195AbWI2XPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbWI2XPi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 19:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbWI2XPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 19:15:38 -0400
Received: from smtp.ono.com ([62.42.230.12]:7072 "EHLO resmta04.ono.com")
	by vger.kernel.org with ESMTP id S932107AbWI2XPe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 19:15:34 -0400
Date: Sat, 30 Sep 2006 01:15:10 +0200
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: Matthew Wilcox <matthew@wil.cx>,
       "Linux-Kernel, " <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, linux-scsi@vger.kernel.org
Subject: Re: 2.6.18-mm2
Message-ID: <20060930011510.5a697026@werewolf>
In-Reply-To: <20060929143949.GL5017@parisc-linux.org>
References: <20060928014623.ccc9b885.akpm@osdl.org>
	<20060929155738.7076f0c8@werewolf>
	<20060929143949.GL5017@parisc-linux.org>
X-Mailer: Sylpheed-Claws 2.5.2cvs19 (GTK+ 2.10.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 08:39:49 -0600, Matthew Wilcox <matthew@wil.cx> wrote:

> On Fri, Sep 29, 2006 at 03:57:38PM +0200, J.A. Magall??n wrote:
> > aic7xxx oopses on boot:
> > 
> > PCI: Setting latency timer of device 0000:00:0e.0 to 64
> > IRQ handler type mismatch for IRQ 0
> 
> Of course, this isn't a scsi problem, it's a peecee hardware problem.
> Or maybe a PCI subsystem problem.  But it's clearly not aic7xxx's fault.
> 
> > PCI: Cannot allocate resource region 0 of device 0000:00:0e.0
> 
> That's not good.  Might be part of the problem.
> 
> > PCI: Enabling device 0000:00:0e.0 (0000 -> 0003)
> > PCI: No IRQ known for interrupt pin A of device 0000:00:0e.0. Probably buggy MP table.
> 
> This is the direct problem.  You've got no irq.
> 

Thanks...

Now I have just realized this:

00:0d.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
00:0e.0 SCSI storage controller: Adaptec AHA-2940U2/U2W / 7890/7891 (rev 01)

leda:~# lsscsi -Hv
[0]    aic7xxx     
  dir: /sys/class/scsi_host/host0
  device dir: /sys/devices/pci0000:00/0000:00:0d.0/host0
[1]    ata_piix    
  dir: /sys/class/scsi_host/host1
  device dir: /sys/devices/pci0000:00/0000:00:07.1/host1
[2]    ata_piix    
  dir: /sys/class/scsi_host/host2
  device dir: /sys/devices/pci0000:00/0000:00:07.1/host2

leda:~# lsscsi
[0:0:0:0]    disk    IBM      IC35L018UWD210-0 S5BS  /dev/sda
[0:0:5:0]    cd/dvd  TOSHIBA  CD-ROM XM-6401TA 1015  /dev/sr0
[2:0:0:0]    disk    IOMEGA   ZIP 250          51.G  /dev/sdb

Device 00:0e.0 is the 2940, which has nothing hung.
Who's to blame ? the bios because is assigns no interupts as no devices are
connected to the bus ? Or the kernel that should understand something like
'this device is disabled' ?

I can try to change the cdrom to the 2940 and see what happens...

Thanks, I will try the patch posted, it looks something like what I said
above, disable the device.

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.0 (Cooker) for i586
Linux 2.6.18-jam02 (gcc 4.1.1 20060724 (prerelease) (4.1.1-3mdk)) #1 SMP PREEMPT
