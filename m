Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314058AbSDKNzR>; Thu, 11 Apr 2002 09:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314059AbSDKNzQ>; Thu, 11 Apr 2002 09:55:16 -0400
Received: from [195.63.194.11] ([195.63.194.11]:30227 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314058AbSDKNzP>; Thu, 11 Apr 2002 09:55:15 -0400
Message-ID: <3CB5872B.9090708@evision-ventures.com>
Date: Thu, 11 Apr 2002 14:52:59 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: vda@port.imtp.ilyichevsk.odessa.ua
CC: linux-kernel@vger.kernel.org
Subject: Re: New IDE code and DMA failures
In-Reply-To: <200204111236.g3BCaMX10247@Port.imtp.ilyichevsk.odessa.ua> <3CB57C1F.9060607@evision-ventures.com> <200204111341.g3BDfJX10546@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:

> # hdparm -i /dev/hda
>  Model=Maxtor 51369U3, FwRev=DA620CQ0, SerialNo=EK3HAE61C
>  Config={ Fixed }
>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
>  BuffType=3(DualPortCache), BuffSize=2048kB, MaxMultSect=16, MultSect=16
>  DblWordIO=no, maxPIO=2(fast), DMA=yes, maxDMA=0(slow)
>  CurCHS=17475/15/63, CurSects=16513875, LBA=yes
>  LBA CHS=512/511/63 Remapping, LBA=yes, LBAsects=26520480
>  tDMA={min:120,rec:120}, DMA modes: mword0 mword1 mword2
>  IORDY=on/off, tPIO={min:120,w/IORDY:120}, PIO modes: mode3 mode4
>  UDMA modes: mode0 mode1 *mode2

To answer an later question.
The asterix here denotes the active UDMA mode!

> 
> # hdparm -i /dev/hdc
>  Model=ST31277A, FwRev=0.75, SerialNo=VAE07701
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
>  RawCHS=2482/16/63, TrkSize=0, SectSize=0, ECCbytes=4
>  BuffType=0(?), BuffSize=0kB, MaxMultSect=16, MultSect=16
>  DblWordIO=no, maxPIO=1(medium), DMA=yes, maxDMA=2(fast)
>  CurCHS=2482/16/63, CurSects=2501856, LBA=yes
>  LBA CHS=620/64/63 Remapping, LBA=yes, LBAsects=2501856
>  tDMA={min:120,rec:120}, DMA modes: mword0 mword1 *mword2
>  IORDY=on/off, tPIO={min:383,w/IORDY:120}, PIO modes: mode3 mode4
> 
> I have problems with hdc. hda is mostly unused, so maybe it is DMA errors
> prone too but I have not seen that yet.
> 
> 
>>3. Some timeout values got increased to more generally used values (in esp.
>>    IBM microdrives advice about timeout values. Could you see whatever
>>    the data doesn't eventually go to the disk after georgeous
>>    amounts of time.
> 
> 
> Erm.. my English comprehension fails here... do you say my disk
> does not like bigger timeouts?

Please just wait and look whatever the driver actually recovers (can be
minutes...)

> 
>>4. Could you try to set the DMA mode lower then it's set up
>>    per default by using hdparm and try whatever it helps?
> 
> 
> Current params:
> 
> # hdparm /dev/hda /dev/hdc
> /dev/hda:
>  multcount    = 16 (on)
>  I/O support  =  1 (32-bit)
>  unmaskirq    =  1 (on)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Could you try to disable this please? This can cause trouble
as well.

>  using_dma    =  1 (on)
>  keepsettings =  0 (off)
>  nowerr       =  0 (off)
>  readonly     =  0 (off)
>  BLKRAGET failed: Invalid argument
>  geometry     = 1754/240/63, sectors = 26520480, start = 0
> 
> /dev/hdc:
>  multcount    = 16 (on)
>  I/O support  =  1 (32-bit)
>  unmaskirq    =  1 (on)
>  using_dma    =  1 (on)
>  keepsettings =  0 (off)
>  nowerr       =  0 (off)
>  readonly     =  0 (off)
>  BLKRAGET failed: Invalid argument
>  geometry     = 620/64/63, sectors = 2501856, start = 0
> 
> I can't quite figure what MW/UDMA mode is active.

See above.

