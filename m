Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932523AbWBPJpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbWBPJpJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 04:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbWBPJpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 04:45:06 -0500
Received: from ruault.com ([81.57.109.127]:59371 "EHLO ruault.com")
	by vger.kernel.org with ESMTP id S932523AbWBPJow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 04:44:52 -0500
Message-ID: <43F44978.2050809@ruault.com>
Date: Thu, 16 Feb 2006 10:44:24 +0100
From: Charles-Edouard Ruault <ce@ruault.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051018)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BUG] kernel 2.6.15.4: soft lockup detected on CPU#0!
References: <43EF8388.10202@ruault.com> <20060215185120.6c35eca2.akpm@osdl.org>
In-Reply-To: <20060215185120.6c35eca2.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Charles-Edouard Ruault <ce@ruault.com> wrote:
>  
>
>>i was trying to rip a CD when the whole machine started to freeze
>> periodicaly, i then looked at the logs and found the following :
>>
>> Feb 12 19:23:39 ruault kernel: hdc: irq timeout: status=0x80 { Busy }
>> Feb 12 19:23:39 ruault kernel: ide: failed opcode was: unknown
>> Feb 12 19:23:39 ruault kernel: hdd: status timeout: status=0x80 { Busy }
>> Feb 12 19:23:39 ruault kernel: ide: failed opcode was: unknown
>> Feb 12 19:23:39 ruault kernel: hdd: drive not ready for command
>>    
>>
>
>No idea what caused that.
>
>  
>
>> Feb 12 19:23:39 ruault kernel: BUG: soft lockup detected on CPU#0!
>>    
>>
>
>The following was merged today.  Hopefully it suppresses this false
>positive.
>  
>
>From what i understand it will fix the problem only if the drive is in
PIO mode, which is the case for  Folkert van Heusden, who reported the
same BUG output.
However it does not appear that my cdrom drives are using PIO, from the
logs i have they're supposed to use DMA :

>Feb 12 19:37:12 ruault kernel: hdc: ATAPI 40X CD-ROM CD-R/RW drive,2048kB Cache, DMA
> Feb 12 19:37:12 ruault kernel: Uniform CD-ROM driver Revision: 3.20
> Feb 12 19:37:12 ruault kernel: hdd: ATAPI 32X DVD-ROM DVD-R CD-R/RW
> drive, 2048kB Cache, UDMA(33)

sudo /sbin/hdparm -i /dev/hdc

/dev/hdc:

 Model=PLEXTOR CD-R PX-W1610A, FwRev=1.05, SerialNo=
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=on/off, tPIO={min:180,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  sdma0 sdma1 sdma2 mdma0 mdma1 *mdma2
 AdvancedPM=no

 sudo /sbin/hdparm -i /dev/hdd

/dev/hdd:

 Model=_NEC DVD_RW ND-3500AG, FwRev=2.1A, SerialNo=
 Config={ Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=yes, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2
 AdvancedPM=no


So i think this patch won't do me any good :(
any other idea ????

Thanks for the answer.



-- 
Charles-Edouard Ruault
GPG key Id E4D2B80C

