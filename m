Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315119AbSGMPfI>; Sat, 13 Jul 2002 11:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314835AbSGMPfH>; Sat, 13 Jul 2002 11:35:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37393 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315119AbSGMPfE>;
	Sat, 13 Jul 2002 11:35:04 -0400
Message-ID: <3D304940.7020207@mandrakesoft.com>
Date: Sat, 13 Jul 2002 11:37:36 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Matt_Domsch@Dell.com, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: Removal of pci_find_* in 2.5
References: <F44891A593A6DE4B99FDCB7CC537BBBB0724D1@AUSXMPS308.aus.amer.dell.com> 	<3D2FAF94.7070100@mandrakesoft.com> <1026570939.9958.92.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Sat, 2002-07-13 at 05:41, Jeff Garzik wrote:
> 
>>ordering, is simply hard-coding something that should really be in 
>>userspace.  Depending on pci_find_device logic / link order to 
>>still-boot-the-system after adding new hardware sounds like an 
>>incredibly fragile hope, not a reliable system users can trust.
> 
> 
> For hot plugging obvious. At system boot time however the ordering and
> seeing the ordering is rather important because in many cases the
> ordering is what tells you about things like IDE controller pairing. It
> tells you what order to assign many scsi devices because the ordering is
> defined by their BIOS ROM.
> 
> One way to handle this generically would be to use pci_register_device,
> but in the register function for such wacky devices during boot up we
> merely keep track of what we have to look into. 


My point is that depending on any method of internal kernel ordering is 
fragile.

I would rather have the kernel export which drives are listed in CMOS / 
BIOS ROM, and let userspace say "my boot drive is the nth BIOS-listed 
drive."  For example, looking through the aic7xxx (or was it 
ncr53c8xxx?) drive, it gets boot drive ordering from BIOS/CMOS.  That 
piece of info can either be exported by driverfs from the low-level SCSI 
driver, or by a separate, tiny ncr53c8xxx_boot_drive driver.

Depending on pci_find_* ordering is very situation-dependent, and only 
covers N cases.  Then you have another N cases covered by the order in 
which you modprobe key drivers.  Then you have another N cases covered 
by special case code somewhere.  You'll never get all these cases right, 
in the kernel, the way the user wants.  That's why I say the 
responsibility for figuring out the boot drive should be pushed to 
initrd/initramfs.

	Jeff


