Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130093AbRAPQvV>; Tue, 16 Jan 2001 11:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130225AbRAPQvL>; Tue, 16 Jan 2001 11:51:11 -0500
Received: from gear.torque.net ([204.138.244.1]:56326 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S129965AbRAPQvC>;
	Tue, 16 Jan 2001 11:51:02 -0500
Message-ID: <3A647A91.44FCE162@torque.net>
Date: Tue, 16 Jan 2001 11:45:05 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Venkatesh Ramamurthy <Venkateshr@ami.com>
CC: "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Linux not adhering to BIOS Drive boot order?
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E9518C@ATL_MS1>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Venkatesh Ramamurthy wrote:
> 
> Hi,
> I have one issue which requires fix from the linux kernel.
> Initially i put a SCSI controller and install the OS on the drive connected
> to it. After installing the OS (on sda), the customer puts another SCSI
> controller. The BIOS for the first controller has BIOS enabled and for the
> second controller does not have the BIOS enabled.
> 
> The linux loads the driver for the second controller first and assigns sda
> to it first , and the actual boot drive gets some sdX device node.
> >From the lilo prompt we can override it with root=/dev/sdX to boot to the
> correct drive and controller, but for a end -user using these cards, this is
> no fun.
> 
> Can the linux kernel be changed in such a way that kernel will look for the
> actual boot drive and re-order the drives so that mounting can go on in the
> right order.
> 
> we need some kind of signature being written in the drive, which the kernel
> will use for determining the boot drive and later re-order drives, if
> required.
> 
> Is someone handling this already?

Venkatesh,
It has been partially addressed in the new lk 2.4 series with
the "scsihosts" parameter. Here is a line from /etc/lilo.conf
in my system:
       append="scsihosts=imm:advansys:advansys:aha1542"

The scsi host numbers will be allocated to the HBAs in 
the order shown starting at 0. This method does not
distinguish between the two advansys controllers, luckily
swapping their positions on the PCI bus does.

In my experience, changing the SCSI BIOS settings only
affects which disk's boot track is accessed to find
the kernel image. It is the kernel's initialization that
detects and orders scsi controllers. This is were
"scsihosts" helps.

Doug Gilbert

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
