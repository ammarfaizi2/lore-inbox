Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315451AbSEBVxZ>; Thu, 2 May 2002 17:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315453AbSEBVxY>; Thu, 2 May 2002 17:53:24 -0400
Received: from [195.63.194.11] ([195.63.194.11]:59664 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315451AbSEBVxW>; Thu, 2 May 2002 17:53:22 -0400
Message-ID: <3CD1A698.80408@evision-ventures.com>
Date: Thu, 02 May 2002 22:50:32 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: akpm@zip.com.au, daniel@rimspace.net, linux-kernel@vger.kernel.org
Subject: Re: 2.5.12 severe ext3 filesystem corruption warning!
In-Reply-To: <UTC200205022140.g42Le8N14139.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Andries.Brouwer@cwi.nl napisa³:
>>>2.5.12, serious ext3 filesystem corrupting behavior
>>
> 
> I have had problems with 2.5.10 (first few blocks of the root
> filesystem overwritten) and then went back to 2.5.8 that I had
> used for a while already, but then also noticed corruption there.
> Back at 2.4.17 today..
> 
> In my case the problem was almost certainly the IDE code.
> More in particular, the 2.5.8 corruption happened on four
> different occasions, on two different disks, hanging off
> an HPT366 that is without problems on 2.4*. Three of the
> four times there were messages like

Hmm... let me assume that you are using UDMA on all those drives.
Since you have apparently a system with quite a lot of
different simultanecousy active drives in them it could be very well possible
that the code that determined the do_request drive selection strategy
was the cause of your problems. It could very well be that
the recent changes with respect to this actually could have cured
this. (2.5.8 is the time around where die PADAM_ tags got introduced
there.

> Apr 29 15:26:00 kernel: hde: task_out_intr: status=0x51 { DriveReady SeekComplete Error }
> Apr 29 15:26:00 kernel: hde: task_out_intr: error=0x04 { DriveStatusError }
> 
> May  2 01:21:23 kernel: hdf: status error: status=0x50 { DriveReady SeekComplete }
> May  2 01:21:23 kernel: hdf: no DRQ after issuing WRITE
> May  2 01:21:37 kernel: hdf: task_out_intr: status=0x51 { DriveReady SeekComplete Error }
> May  2 01:21:37 kernel: hdf: task_out_intr: error=0x04 { DriveStatusError }
> 
> Each time some data was written at a wrong address on disk.
> Now these are ext2 filesystems, so I noticed.
> Elsewhere I have ext3 and reiserfs, but journalling does not
> protect against IDE drivers that write stuff to the wrong disk block.

