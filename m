Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275086AbRJAODk>; Mon, 1 Oct 2001 10:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275098AbRJAODb>; Mon, 1 Oct 2001 10:03:31 -0400
Received: from relais.videotron.ca ([24.201.245.36]:45738 "EHLO
	VL-MS-MR001.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id <S275096AbRJAODS>; Mon, 1 Oct 2001 10:03:18 -0400
Date: Mon, 1 Oct 2001 10:03:43 -0400
From: Greg Ward <gward@python.net>
To: bugs@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: "hde: timeout waiting for DMA": message gone, same behaviour
Message-ID: <20011001100343.A625@cthulhu.mems-exchange.org>
In-Reply-To: <20010921134402.A975@gerg.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010921134402.A975@gerg.ca>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 September 2001, I said:
> Having problems with an ATA/100 drive under Linux 2.4.{2,9}.
[...]
>   Partition check:
>    hda:hda: timeout waiting for DMA
>   ide_dmaproc: chipset supported ide_dma_timeout func only: 14
>   hda: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
>   [...repeat 2 times...]
>   hda: DMA disabled
>   ide0: reset: success
>    hda1

After a lengthy thread with many helpful tips from lots of people, I
have resolved this problem.  It was a bad hard drive after all.  I tried
the drive in two separate computers, with four operating systems (Linux,
Windows 98, MS-DOS, and DR-DOS).
  * Linux had the problems described ("DMA timeout" message)
  * Windows 98 didn't complain or have lengthy timeouts, but it
    turned DMA off on the drive in question
  * MS-DOS (version 5.0 and 6.22, booted from a floppy) crashed cold on
    bootup -- probably as soon as it tried to read the MBR of the disk
  * DR-DOS didn't complain or crash

In my humble estimation, Linux 2.4.9 and 2.4.10 deal with this "DMA
timeout" problem about as well as can be expected.  One revision the
kernel IDE folks might consider is that, as soon as a DMA timeout is
detected, turn off DMA on the affected drive.  This is what Linux 2.4.2
did, and it at least avoided repeating the lengthy timeout delays I
experienced with 2.4.2 on bootup.  With 2.4.9/10, the timeout delay
repeated every time I accessed the drive until I explicitly turned DMA
off with "hdparm -d0".

Many thanks to all who had suggestions and ideas.  I love the Linux
community, almost as much as I hate flaky hardware.  ;-)

        Greg
-- 
Greg Ward - programmer-at-large                         gward@python.net
http://starship.python.net/~gward/
Life is too short for ordinary music.
