Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319109AbSHFMsY>; Tue, 6 Aug 2002 08:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319111AbSHFMrx>; Tue, 6 Aug 2002 08:47:53 -0400
Received: from [195.63.194.11] ([195.63.194.11]:16904 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S319109AbSHFMrt>; Tue, 6 Aug 2002 08:47:49 -0400
Message-ID: <3D4C68C0.2090205@evision.ag>
Date: Sun, 04 Aug 2002 01:35:28 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Petr Vandrovec <VANDROVE@vc.cvut.cz>, dalecki@evision-ventures.com,
       linux-kernel@vger.kernel.org
Subject: Re: IDE hang, partition strangeness
References: <DA7022651A@vcnet.vc.cvut.cz> <3D4AC83A.5A0E37C0@zip.com.au>
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Andrew Morton napisa?:
> Petr Vandrovec wrote:
> 
> 
> Hi, Petr.  We're able to reproduce the ntpd thing btw.  It is
> caused by cset 1.403.142.43 "avoid allocating pte_chains for unshared
> pages" - Rik is looking into it.
> 
> 
>>On  1 Aug 02 at 23:56, Andrew Morton wrote:
>>
>>>>Seems that the partitioning code in 2.5.30 is sending illegal LBAs
>>>>to the IDE driver, which responds by hanging the box:
>>>
>>>I misread this backtrace:
>>>
>>>_this_ is the lba. 160086527.  It is the very last sector on the disk.
>>
>>Did not it issued an error on the console before that? Something
>>like 'hda: xxxx: status=YY' ?
> 
> 
> There are no error messages.
> 
> 
>>If it did, just open
>>drivers/ide/ide.c in your favorite editor, locate function ata_error,
>>in this function locate 'if (rq->errors >= ERROR_MAX)' and replace
>>it with 'if (1)'...
> 
> 
> Tried that - it made no difference.
> 
> It'd be convenient to get my IDE disks back.  I'll try the 2.4
> forward-port drivers.

I thnik the sector calculation patch intriduced by the
recent gendisk handling patches (in esp. not me) should fix this.
I suppose that we are simply asking the drive to return more data
then it contains.

I can of course try to introduce a band aid guard against such
*pysical* mismatches in ide-disk.c. At least it should
be possible to confirm the above hypothesis.



