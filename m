Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318277AbSHPJsj>; Fri, 16 Aug 2002 05:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318281AbSHPJsj>; Fri, 16 Aug 2002 05:48:39 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:31498 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S318277AbSHPJsi>;
	Fri, 16 Aug 2002 05:48:38 -0400
Date: Fri, 16 Aug 2002 11:52:30 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Misha Alex <misha_zant@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20020816095230.GA14227@alpha.home.local>
References: <F159156pqkw3Wctbnyd0000b29b@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F159156pqkw3Wctbnyd0000b29b@hotmail.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !

On Fri, Aug 16, 2002 at 07:51:37AM +0000, Misha Alex wrote:
 
>      Also i tried the linear addressing linear = c*H*S + h*S +s -1 .But 
> linear or linear*512 never gave me the exact byte offset to seek.
> 
> I am working in linux and using a hexeditor to seek .How many exact bytes 
> should i seek to find out the extended partition.I read the MBR and found 
> the exteneded partiton.
> 00 01 01 00 02 fe 3f 01 3f 00 00 00 43 7d 00 00
> 80 00 01 02 0b fe bf 7e 82 7d 00 00 3d 26 9c 00
> 00 00 81 7f 0f fe ff ff bf a3 9c 00 f1 49 c3 01
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

I haven't played with this for a long time, but I still have some memory
about this. First, when an offset is higher than 8GB, there's no way to
code it with the bios' CHS scheme as you find it in the partition table.
I see that you know how to decode this, so set all the CHS bits to ones
and look at the offset. For this reason, we often use only the size to
locate these partitions. If I recall correctly, the last 4 bytes of your
parts are the sizes in sectors. For example, hda2 is 9c263d sectors long,
which equals 5.2 GB. You'll notice that bytes 8 to 11 of each partitions
are nearly equivalent to the size of the previous part. They should be
the start offset in sectors. So in this case, hda3 begins at 9ca3bf
(byte 5255953920), and is 1c349f1 sectors long (15.1 GB).

I think that 'fe ff ff' after the partition type indicates that only the
linear mode should be used, but I'm not sure about this nor I do I have
any proof. You should read the partition code to get more clues, IMHO.

Hoping this helps,
Willy

