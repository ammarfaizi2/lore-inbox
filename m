Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316831AbSEWPrw>; Thu, 23 May 2002 11:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316834AbSEWPrv>; Thu, 23 May 2002 11:47:51 -0400
Received: from [195.63.194.11] ([195.63.194.11]:56845 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316831AbSEWPru>; Thu, 23 May 2002 11:47:50 -0400
Message-ID: <3CED004A.6000109@evision-ventures.com>
Date: Thu, 23 May 2002 16:44:26 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Oleg Drokin <green@namesys.com>
CC: "Gryaznova E." <grev@namesys.botik.ru>, martin@dalecki.de,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: [reiserfs-dev] Re: IDE problem: linux-2.5.17
In-Reply-To: <3CECF59B.D471F505@namesys.botik.ru> <3CECFC5B.3030701@evision-ventures.com> <20020523193959.A2613@namesys.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Oleg Drokin napisa?:
> Hello!
> 
> On Thu, May 23, 2002 at 04:27:39PM +0200, Martin Dalecki wrote:
> 
>>>hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
>>>hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
>>
>>Since this error can be expected to be quite common.
>>Its an installation error. I will just make the corresponding
>>error message more intelliglible to the average user:
>>hda: checksum error on data transfer occurred!
> 
> 
> BTW, I have a particular setup that spits out such errors,
> and I somehow thinks the cable is good.
> 
> I have IBM DTLA-307030 drive and Seagate Barracuda IV drive (last one purchased
> only recently).
> IBM drive is connected to far end of 80-wires IDE cable and Barracuda is
> connected to the middle of this same wire.
> Before I bought IBM drive, everything was ok.
> But now I see BadCRC errors on hdb (only on hdb, which is barracuda drive)
> usually when both drives are active.
> If I disable DMA on IBM drive (or if kernel disables it by itself for some
> reason, and it actually does it sometimes), these errors seems to go away.
> 
> This is all on 2.4.18, but actually I think this is irrelevant.
> 
> If that's a bad cable, why it is only happens when both drives are working
> in DMA mode?

It's most likely the cable. The error comes directly from the
status register of the drive. The drive is reporting that it got
corrupted data from the wire. This will be only checked in the
80 cable requiring DMA transfer modes. So if the drive resorts to
slower operation all will be fine. If it does not - well
you see the above...

Having two drives on a single cable canges the termination
of the cable as well as other electrical properties significantly
and apparently you are just out of luck with the above system.

What should really help is simple resort to slower operations
int he case of the driver.

It can of course be as well that the host chip driver is simply
programming the channel for too aggressive values.

Hmm thinking again about it... It occurrs to me
that actually there should be a mechanism which tells the
host chip drivers whatever there are only just one or
two drivers connected. I will have to look in to it.

