Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135454AbRDMJp1>; Fri, 13 Apr 2001 05:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135455AbRDMJpS>; Fri, 13 Apr 2001 05:45:18 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:27552 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S135454AbRDMJpA>; Fri, 13 Apr 2001 05:45:00 -0400
Date: Fri, 13 Apr 2001 11:44:56 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Dennis Bjorklund <db@zigo.dhs.org>
Cc: linux-kernel@vger.kernel.org, Andre Hedrick <andre@linux-ide.org>,
        Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Data-corruption bug in VIA chipsets
Message-ID: <20010413114456.C682@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <Pine.LNX.4.30.0104130953160.20273-100000@merlin.zigo.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.30.0104130953160.20273-100000@merlin.zigo.dhs.org>; from db@zigo.dhs.org on Fri, Apr 13, 2001 at 10:00:32AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2001 at 10:00:32AM +0200, Dennis Bjorklund wrote:
> Here might be one of the resons for the trouble with VIA chipsets:
> 
> http://www.theregister.co.uk/content/3/18267.html
> 
> Some DMA error corrupting data, sounds like a really nasty bug. The
> information is minimal on that page.

These are the things, that one of the German links[1] suggest
(translated only, because I'm not the IDE guy ;-)):
   
   - PCI Delay Transaction = 0 (off) (Register 0x70, Bit 1)
   - PCI Master Read Caching = 0 (off) (Register 0x70, Bit 2)
   - PCI Latency = 0 (values between 0 and 32 *seem* to be safe,
        everything above seems to be *not* !)

Note: This also fixes some related USB issues according to [1].

Some hassles of setting the "PCI Latency" are described and one
of their reader found out, that it is "PCI Bus Master Time-Out"
on his board.

Register 0x75, Bits 0-3 are at 0001, which means 32 as latency
value. He set it to 0000 and it helps. This setting also does no
harm according to the magazine.

The observations are valid for the VT82C686B. One of their
readers also observed it at VT82C686A too and reported, that the
workaround helps.

So we might want to enable these workarounds for this
southbridge, too.

Hope this translation helps our maintainers a little ;-)

Regards

Ingo Oeser

[1] http://home.tiscalinet.de/au-ja/review-kt133a-4.html
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
