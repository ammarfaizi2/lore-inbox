Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317423AbSGZJIy>; Fri, 26 Jul 2002 05:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317424AbSGZJIy>; Fri, 26 Jul 2002 05:08:54 -0400
Received: from [195.63.194.11] ([195.63.194.11]:52999 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317423AbSGZJIx>; Fri, 26 Jul 2002 05:08:53 -0400
Message-ID: <3D411134.60904@evision.ag>
Date: Fri, 26 Jul 2002 11:07:00 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: martin@dalecki.de, Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IDE 104
References: <Pine.LNX.4.33.0207241410040.3542-100000@penguin.transmeta.com>	 <3D40F8F9.1050507@evision.ag> <1027678411.13428.3.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Fri, 2002-07-26 at 08:23, Marcin Dalecki wrote:
> 
>>- Make the bit-sliced data types in hdreg.h use the bit-slice data types
>>   instead of the generic ones. This makes clear that those are supposed
>>   to be register masks.
> 
> 
> Because its an external API it needs to remain constant. Swapping

???

The only thing which is really 'external API' there is the declaration
of the HDIO_XXX ioctl and among them in reality only HDIO_GETGEO 
      is really used outside the scope of the dreddy hdparm application. 
And
99% of times its usage is bogous anyway. Or do you know any better
examples I'm not aware of?

The remainings will be moved away from there soon becouse it doesn't
make any sense to include this at every single place out there where
HDIO_GETGEO is the needed declaration. If some application needs ATA 
command macros - it should come with they own header declaring them 
instead of peeing in to the kernel becouse they don't depend on the
kernel in question. They are cut in stone at www.t13.org ;-).

> uchar/uint looks fine and the structure is off the drive anyway. However
> they should be __u16 __u8 __u32 so that C libraries and apps can still
> use the header (its __u16 because 'u16' cannot be exposed to user space
> directly or via libc)

I know - see above.

