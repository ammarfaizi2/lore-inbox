Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261314AbTCTQoO>; Thu, 20 Mar 2003 11:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261338AbTCTQoO>; Thu, 20 Mar 2003 11:44:14 -0500
Received: from portal.beam.ltd.uk ([62.49.82.227]:26529 "EHLO beam.beamnet")
	by vger.kernel.org with ESMTP id <S261314AbTCTQoL>;
	Thu, 20 Mar 2003 11:44:11 -0500
Message-ID: <3E79F267.2030708@beam.ltd.uk>
Date: Thu, 20 Mar 2003 16:55:03 +0000
From: Terry Barnaby <terry@beam.ltd.uk>
Organization: Beam Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030314
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: "Cress, Andrew R" <andrew.r.cress@intel.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Reproducible SCSI Error with Adaptec 7902 & ST336607LW
References: <A5974D8E5F98D511BB910002A50A66470580D6EF@hdsmsx103.hd.intel.com>
In-Reply-To: <A5974D8E5F98D511BB910002A50A66470580D6EF@hdsmsx103.hd.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

No I haven't, so I will try this.
I have downloaded the scsirastools and get the following mode page dump:

Device [3] is ready for modepage
Starting modepage process for 1 disk.
Getting mode sense pages from disk 3

Block Descriptor & Mode Pages:
04 45 dc cc 00 00 02 00    :Block Descriptor
01 0a c0 0b ff 00 00 00 05 00 ff ff
02 0e 80 80 00 0a 00 00 00 00 00 00 00 00 00 00
03 16 11 aa 00 00 00 08 00 00 02 d0 02 00 00 01 00 66 00 66 40 00 00 00
04 16 00 c2 bf 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 27 31 00 00
07 0a 00 0b ff 00 00 00 00 00 ff ff
08 12 14 00 ff ff 00 00 ff ff ff ff 00 20 00 00 00 00 00 00
0a 0a 02 00 00 00 00 00 00 00 03 00
19 06 01 00 ff ff 00 00
1a 0a 00 03 00 00 00 01 00 00 00 04
1c 0a 10 00 00 00 00 00 00 00 00 01
00 06 00 00 0f 00 00 00

I'm not up on SCSI mode pages, do I just have to change the "line"
1c 0a 10 00 00 00 00 00 00 00 00 01

to

1c 0a 88 00 00 00 00 00 00 00 00 01

??

Cheers

Terry

Cress, Andrew R wrote:
> Terry,
> 
> Did you try changing the mode pages on the Seagate ST336607LW to turn off
> SMART?
> The symptoms indicate to me that SMART might be an issue.
> 
> Andy
> 
> -----Original Message-----
> From: Terry Barnaby [mailto:terry@beam.ltd.uk] 
> Sent: Thursday, March 20, 2003 5:07 AM
> To: linux-kernel@vger.kernel.org
> Cc: Justin T. Gibbs; mmadore@aslab.com
> Subject: Re: Reproducible SCSI Error with Adaptec 7902
> 
> 
> Hi,
> 
> We have continued to try and get to the bottom of the problem we have
> with the Seagate ST336607LW drive with an Adaptec 7902 SCSI controller
> under Linux on an SMP machine. We have recently tried the latest
> Adaptec Linux driver (1.3.4) from Justin Gibbs who is one of the Adaptec
> SCSI driver developers. This has stopped the drive locking up but now
> lists SCSI errors in the log files. I enclose a portion of this log
> file. I have run the error logs past Justin and he has stated:
> 
> "The drive has unexpectedly dropped off the bus during a connection.
> Without a SCSI bus trace it is impossible to know why the drive might
> have done this or if perhaps a glitch on the BSY line is causing the
> controller to detect a spurious busfree."
> 
> My current conclusions are:
> 
> 1. The Seagate ST336607LW drive has a bug where in certain circumstances
> 	the drive can lock up, with LED on. In this state it will not
> 	respond to a hardware reset and a power off/on cycle is needed to
> 	reset the drive. There is a difference between the way the Linux
> 	Adaptec AIC79XX 1.1.0 driver and the 1.3.4 driver handles a SCSI
> 	error condition that triggers this behaviour.
> 
> 2. There is a problem with one of the following: The Seagate ST336607LW
> drive,
> 	the Adaptec 7902 SCSI controller on the SuperMicro X5DA8 Motherboard
> or
> 	the Linux AIC79XX driver that causes a SCSI bus fault.
> 
> I am now giving up with Seagate ST336607LW drive and intend to try a
> Maxtor Atlas 10K IV drive instead.
> I include this information to hopefully assist others who may encounter this
> problem and to list the bugs so that those who are in a position to fix them
> know about it.
> 
> Terry
> 
> [...snip...]
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Dr Terry Barnaby                     BEAM Ltd
Phone: +44 1454 324512               Northavon Business Center, Dean Rd
Fax:   +44 1454 313172               Yate, Bristol, BS37 5NH, UK
Email: terry@beam.ltd.uk             Web: www.beam.ltd.uk
BEAM for: Visually Impaired X-Terminals, Parallel Processing, Software
                       "Tandems are twice the fun !"

