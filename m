Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264857AbSJPEYx>; Wed, 16 Oct 2002 00:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264853AbSJPEYx>; Wed, 16 Oct 2002 00:24:53 -0400
Received: from [203.117.131.12] ([203.117.131.12]:2215 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S264848AbSJPEYt>; Wed, 16 Oct 2002 00:24:49 -0400
Message-ID: <3DACEB6E.6050700@metaparadigm.com>
Date: Wed, 16 Oct 2002 12:30:38 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: GrandMasterLee <masterlee@digitalroadkill.net>
Cc: Simon Roscic <simon.roscic@chello.at>,
       Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [Kernel 2.5] Qlogic 2x00 driver
References: <200210152120.13666.simon.roscic@chello.at>	 <1034710299.1654.4.camel@localhost.localdomain>	 <200210152153.08603.simon.roscic@chello.at>	 <3DACD41F.2050405@metaparadigm.com> <1034740592.29313.0.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I doubt it will make a difference. LVM and qlogic drivers seem
to be a bad mix. I've already tried the beta5 of 6.01
and same problem exists - ooops about every 5-8 days.
Removing LVM and solved the problem.

The changelog only lists small changes since between 6.01 and 6.01b5

Although one entry suggests a fix to a race in qla2x00_done
that would allow multiple completions on the same IO. Not sure
if this relates to my problem with LVM as this occured with
earlier versions of the qlogic driver without the dpc threads.

~mc

On 10/16/02 11:56, GrandMasterLee wrote:
> You might wanna look at version 6.01 instead. I say this because it's
> *not* a beta driver. 
> 
> 
> On Tue, 2002-10-15 at 21:51, Michael Clark wrote:
> 
>>Version 6.1b5 does appear to be a big improvement from looking
>>at the code (certainly much more readable than version 4.x end earlier).
>>
>>Although the method for creating the different modules for
>>different hardware is pretty ugly.
>>
>>in qla2300.c
>>
>>#define ISP2300
>>[snip]
>>#include "qla2x00.c"
>>
>>in qla2200.c
>>
>>#define ISP2200
>>[snip]
>>#include "qla2x00.c"
>>
>>I'm sure this would have to go before it got it.
>>
>>~mc
>>
>>On 10/16/02 03:53, Simon Roscic wrote:
>>
>>>On Tuesday 15 October 2002 21:31, Arjan van de Ven <arjanv@redhat.com> wrote:
>>>
>>>
>>>>Oh so you haven't notices how it buffer-overflows the kernel stack, how
>>>>it has major stack hog issues, how it keeps the io request lock (and
>>>>interrupts disabled) for a WEEK ?
>>>
>>This may have been the cause of problems I had running qla driver with
>>lvm and ext3 - I was getting ooops with what looked like corrupted bufferheads.
>>
>>This was happening in pretty much all kernels I tried (a variety of
>>redhat kernels and aa kernels). Removing LVM has solved the problem.
>>Although i was blaming LVM - maybe it was a buffer overflow in qla driver.
>>
>>The rh kernel I tried had quite an old version (4.31) of the driver
>>suffered from problems recovering from LIP resets. The latest 6.x drivers
>>seem to handle this much better.
>>
>>~mc
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Michael Clark,  . . . . . . . . . . . . . . .  michael@metaparadigm.com
Managing Director,  . . . . . . . . . . . . . . .  phone: +65 6395 6277
Metaparadigm Pte. Ltd.  . . . . . . . . . . . . . mobile: +65 9645 9612
25F Paterson Road, Singapore 238515  . . . . . . . . fax: +65 6234 4043

I'm successful because I'm lucky.  The harder I work, the luckier I get.


