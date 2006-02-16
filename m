Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbWBPP1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbWBPP1i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 10:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWBPP1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 10:27:38 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:62309 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S932301AbWBPP1i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 10:27:38 -0500
Message-ID: <43F499A8.4080204@cfl.rr.com>
Date: Thu, 16 Feb 2006 10:26:32 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Seewer Philippe <philippe.seewer@bfh.ch>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: disk geometry via sysfs
References: <43EC8FBA.1080307@bfh.ch> <43F0B484.3060603@cfl.rr.com> <43F0D7AD.8050909@bfh.ch> <43F0DF32.8060709@cfl.rr.com> <43F206E7.70601@bfh.ch> <43F21F21.1010509@cfl.rr.com> <43F2E8BA.90001@bfh.ch> <58cb370e0602150051w2f276banb7662394bef2c369@mail.gmail.com> <11 <Pine.LNX.4.61.0602160728100.20319@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0602160728100.20319@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Feb 2006 15:28:31.0105 (UTC) FILETIME=[A451BF10:01C6330D]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14271.000
X-TM-AS-Result: No--11.490000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
>> I'm talking about the geometry of the disk.  If the disk has 16 sectors
>> and 8 heads, then the maximum value allowed for any valid address is 16
>> in the sector field and 7 in the heads field.  This influences the
>> translation to/from LBA.  A sector with LBA of 1234 would have a CHS
>> address using this geometry of 9/5/3.  If the disk reports a geometry of
>> x/8/16 but the bios is using a geometry of x/255/63, then when you pass
>> 9/5/3 to int 13 it will fetch LBA 144902 which is clearly not going to
>> give you what you wanted.
>>
> 
> Wrong! The disk gets an OFFSET!  It doesn't care how that OFFSET
> is obtained. That OFFSET is the sum of some variables. Some start
> at 0 and some start at 1. The BIOS takes these PHONY things, without
> checking to see if they "fit" in some pre-conceived notion of
> "geometery" and sums them all up to make an OFFSET. The C/H/S
> stuff started and ENDED with the ST-506 interface.  PERIOD.
> 

Please reread my explanation above.  The bios has to compute the 
absolute offset based on the geometry and the values you pass it.  It 
does so by multiplying the track number you pass by the number of 
sectors per track, multiplies the cylinder number by the number of 
sectors per track and the number of tracks, and adds those two values to 
the sector number you pass to arrive at the LBA to read.  If it performs 
the CHS->LBA translation using a different geometry than you used to go 
from LBA->CHS, then it will get the wrong sector.


