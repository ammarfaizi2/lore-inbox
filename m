Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261312AbSL1O3T>; Sat, 28 Dec 2002 09:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261545AbSL1O3T>; Sat, 28 Dec 2002 09:29:19 -0500
Received: from m3.azalea.se ([217.75.96.207]:51405 "HELO m3.azalea.se")
	by vger.kernel.org with SMTP id <S261312AbSL1O3R>;
	Sat, 28 Dec 2002 09:29:17 -0500
Subject: Re: Alot of DMA errors in 2.4.18, 2.4.20 and 2.5.52
From: Mikael Olenfalk <mikael@netgineers.se>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jw schultz <jw@pegasys.ws>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1041036339.1128.32.camel@dhcp22.swansea.linux.org.uk>
References: <1040815160.533.6.camel@devcon-x>
	 <20021225115820.GB7348@louise.pinerecords.com>
	 <20021226123710.GA2442@iapetus.localdomain>
	 <1040994876.518.13.camel@devcon-x>  <20021227071353.A4614@pegasys.ws>
	 <1041028693.1620.4.camel@devcon-x>
	 <1041036339.1128.32.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain
Organization: Netgineers
Message-Id: <1041085912.523.20.camel@devcon-x>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 28 Dec 2002 15:31:52 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-12-28 at 01:45, Alan Cox wrote:
> Master/Slave is ok with 80pin cables on UDMA66 so that should not be the
> problem area. Some combinations with old hardware can be problematic but
> this is a pair of new same vendor drives.
> 
> Odd indeed
> 

I've been trying to do an array with three drives (two RAID5 drives, one
spare), with each one on a channel, the results was (hmm, I feel like
I'm already been telling this, hmm) almost the same, funnily though the
were some speed diffs:

1) kernel version 2.4.20 -- 4+1 config, the four drives on two channels,
the spare drive on an channel of its own:

- 12-15 MB/sec, with UDMA2

- 20-22 MB/sec, when forcing UDMA5 through kernel boot param
ide{2,3}=ata66

always at 36.1% (of the initial parity sync) the speed begins dropping
from maximum speed to 40-60KB/sec at 37%

2) kernel version 2.4.20 -- 2+1 config, each on a channel of its own

- 20-22MB/sec, when forcing UDMA5 through kernel boot param

at 36.1% the speed drops again

3) kernel version 2.4.20 -- 4+1/2+1 config occasionally the system gives
me DMA errors, this has almost only happened when forcing UDMA5

4) kernel version 2.5.52 -- 4+1 config

- runs at a beautiful speed of 33-36MB/sec filling my heart with joy,
gives me though DMA errors or kernel Ooopses at almost 36-39%

5) kernel version 2.5.53 -- 2+1 config

- again wonderful speedliftings to max 36MB/sec, same errors as with 4)



The only thing that I see in common between all configs is that they
almost always bail out somewhere at 36-37%.

I don't know the internals of the MD driver but could it be that the
initial parity sync is done linearly through the disks, meaning that
parity information on the first disk is done first, when the parity
information on the first disk is completely computed, the parity
information on the second disk is being computed and so on, and so on.

Given the fact that the sync always fails at somewhat the same position,
it sound to me like just one bad little disk is bailing out.

I'll try the 2+1 configs today again, just with the two other disks,
I'll come back and report the success story to you on Monday or Sunday
evening (I got to inspect some UMTS-antennas tomorrow -- measure cable
quality and stuff, so no Linux-joy for me 8) )


I really appreciate your help and advice,

Regards Mikael

-- 
Mikael Olenfalk <mikael@netgineers.se>
Netgineers

