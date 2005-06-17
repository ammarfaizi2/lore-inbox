Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261971AbVFQNnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbVFQNnl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 09:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbVFQNnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 09:43:40 -0400
Received: from mailhub3.nextra.sk ([195.168.1.146]:29444 "EHLO
	mailhub3.nextra.sk") by vger.kernel.org with ESMTP id S261971AbVFQNnf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 09:43:35 -0400
Message-ID: <42B2D384.70104@rainbow-software.org>
Date: Fri, 17 Jun 2005 15:43:32 +0200
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Nick Piggin <nickpiggin@yahoo.com.au>,
       Grant Coady <grant_lkml@dodo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Odd IDE performance drop 2.4 vs 2.6?
References: <ac0qa19omlt7bsh8mcfsfr2uhshk338f0c@4ax.com>	 <42AD6362.1000109@rainbow-software.org>	 <1118669975.13260.23.camel@localhost.localdomain>	 <42AD92F2.7080108@yahoo.com.au>	 <1118675343.13773.1.camel@localhost.localdomain>	 <42B07E5D.9070004@rainbow-software.org> <1119012053.27908.87.camel@localhost.localdomain>
In-Reply-To: <1119012053.27908.87.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mer, 2005-06-15 at 20:15, Ondrej Zary wrote:
> 
>>Now I've tested it with preempt disabled and nothing has changed. When 
>>fiddling around with hdparm, I got about 16MB/s max. with 2.6.12-rc5. 
>>With 2.4.31, I got about 21MB/s when just the DMA was enabled 
>>(read-ahead and multcount set to 0 - changing them does not make almost 
>>any difference).
> 
> 
> multcount is only used for PIO so that would be expected. Similarly the
> block readahead should matter but not anything drive level.
> 
> If you compare the hdparm data are both 2.4 and 2.6 selecting the same
> IDE modes ?

This is in my init scripts:
/usr/sbin/hdparm -u1c1k1 /dev/hda /dev/hdc /dev/hdd 1> /dev/null
It selects UDMA2 mode in both 2.4 and 2.6.

hdparm -i /dev/hda shows exactly the same output in both 2.4 and 2.6:

/dev/hda:

  Model=WDC WD300BB-00AUA1, FwRev=18.20D18, SerialNo=WD-WMA6W1847372
  Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
  RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=40
  BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=58633344
  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
  PIO modes:  pio0 pio1 pio2 pio3 pio4
  DMA modes:  mdma0 mdma1 mdma2
  UDMA modes: udma0 udma1 *udma2
  AdvancedPM=no WriteCache=enabled
  Drive conforms to: device does not report version:

  * signifies the current active mode

-- 
Ondrej Zary

