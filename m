Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317339AbSFRGax>; Tue, 18 Jun 2002 02:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317340AbSFRGaw>; Tue, 18 Jun 2002 02:30:52 -0400
Received: from [195.63.194.11] ([195.63.194.11]:59664 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317339AbSFRGav> convert rfc822-to-8bit; Tue, 18 Jun 2002 02:30:51 -0400
Message-ID: <3D0ED3AC.6090801@evision-ventures.com>
Date: Tue, 18 Jun 2002 08:31:08 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Arnd Bergmann <arnd@bergmann-dalldorf.de>
CC: linux-kernel@vger.kernel.org, Arnd Bergmann <arndb@de.ibm.com>
Subject: Re: 2.5.22 ide disk hang on boot
References: <200206172142.XAA19452@post.webmailer.de>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Arnd Bergmann napisa³:
> Hi,
> 
> In 2.5.22, I get during the partition detection (2.5.21 was ok):
> 
> ...
> /dev/ide/host0/bus0/target0/lun0: [PTBC] (6201/240/63) p1 p2 p3 <hda: status
> error: status = 0x58 [drive ready seek complete data request]
> hda: recalibrating
> 
> After that, I have to reboot. The machine is an IBM thinkpad A30p, the
> ide controller is an ICH3 ("Intel Corp. 82801CAM IDE U100 (rev 1)") and
> the drive says it is "IC25T048ATDA05-0".
> I tried reverting the last IDE patches but got too many rejects.
> 
> After replacing the ata_error that came last with BUG(), I got the
> backtrace below (assuming I copied every address correctly from the
> screen).
> 
> 	Arnd <><
> 
> Trace; c01f9242 <ata_status_poll+92/c8>
> Trace; c01fb2d1 <start_request+c5/17c>
> Trace; c01eb38a <__elv_next_request+a/10>

I assume that the system in question isn't:

1. Isn't setting up the drive in BIOS for DMA operation?

2. Isn't showring the hda: hda1.... partition layout?

As one can see from the above the problem is caused by PIO
read getting worser. I know the problem and am working on it.
As a band plase apply patch -p1 -R < ide-clean-92.diff.
I hope I can provide the proper solution soon.

