Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132298AbRCYLJA>; Sun, 25 Mar 2001 06:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132300AbRCYLIu>; Sun, 25 Mar 2001 06:08:50 -0500
Received: from front2m.grolier.fr ([195.36.216.52]:47100 "EHLO
	front2m.grolier.fr") by vger.kernel.org with ESMTP
	id <S132298AbRCYLIp> convert rfc822-to-8bit; Sun, 25 Mar 2001 06:08:45 -0500
Date: Sun, 25 Mar 2001 09:57:17 +0200 (CEST)
From: Gérard Roudier <groudier@club-internet.fr>
To: LA Walsh <law@sgi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: NCR53c8xx driver and multiple controllers...(not new prob)
In-Reply-To: <Pine.LNX.4.10.10103241647530.601-100000@linux.local>
Message-ID: <Pine.LNX.4.10.10103250925410.717-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

You sent me by private e-mail, the /proc/pci information of your system.
I donnot see anything wrong in these data. If the problem is PCI-related,
you would probably have better help by sending these infos to the l-k
list, in my opinion.

To be honest (I may be wrong here - sorry if I am), I am under the
impression that you may well be barking up the wrong tree.
Just quoted here an exerpt of your mail that let me think so:

> > When I compile it in, it only see the 1st controller
> > and the boot partition I think is on the 3rd.
                             ^^^^^
Knowing instead is required, here, IMO.

1) controllers attach SCSI devices, notably hard disks
2) hard disks contain partitions
3) partitions contain file systems.
4) the kernel needs to *know* the root file system to boot your system.

What about point 4 ?

i.e : how did you tell to the boot loader the root partition name to 
pass to the kernel at boot ?

If you are using lilo and have configured it for user to be prompted
before running the kernel, you may try to enter your root partition name
when you are prompted by lilo. For example if root fs is on /dev/sda5:

lilo: your_lilo_config_entry_name root=/dev/sda5 ro

Just replace the lilo_config_entry_name and the root partition name by the
values that match your configuration.

  Gérard.


On Sat, 24 Mar 2001, Gérard Roudier wrote:

> On Sat, 24 Mar 2001, LA Walsh wrote:
> 
> > I have a machine with 3 of these controllers (a 4 CPU server).  The
> > 3 controllers are:
> > ncr53c810a-0: rev=0x23, base=0xfa101000, io_port=0x2000, irq=58
> > ncr53c810a-0: ID 7, Fast-10, Parity Checking
> > ncr53c896-1: rev=0x01, base=0xfe004000, io_port=0x3000, irq=57
> > ncr53c896-1: ID 7, Fast-40, Parity Checking
> > ncr53c896-2: rev=0x01, base=0xfe004400, io_port=0x3400, irq=56
> > ncr53c896-2: ID 7, Fast-40, Parity Checking
> > ncr53c896-2: on-chip RAM at 0xfe002000
> > 
> > I'd like to be able to make a kernel with the driver compiled in and
> > no loadable module support.  It don't see how to do this from the
> > documentation -- it seems to require a separate module loaded for
> > each controller.  When I compile it in, it only see the 1st controller
> > and the boot partition I think is on the 3rd.  Any ideas?
> 
> The driver tries to detect all controllers it supports. Since the
> ncr53c8xx supports both the 810a and the 896, all your controllers should
> have been detected. When loaded as a module, the driver must be loaded
> once (btw, a seconf load should fail).
> 
> > This problem is present in the 2.2.x series as well as 2.4.x (x up to 2).
> 
> What hardware are you using (CPU, Core Logic and tutti quanti) ?
> Is the 896 on PCI BUS #0 or on some sort of secondary PCI BUS ?
> Does the sym53c8xx driver show same behaviour ?
> 
>   Gérard.


