Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282898AbRL0Wbb>; Thu, 27 Dec 2001 17:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282904AbRL0WbV>; Thu, 27 Dec 2001 17:31:21 -0500
Received: from gear.torque.net ([204.138.244.1]:28173 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S282898AbRL0WbJ>;
	Thu, 27 Dec 2001 17:31:09 -0500
Message-ID: <3C2BA1B4.EB853055@torque.net>
Date: Thu, 27 Dec 2001 17:33:24 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Leung Yau Wai <chris@gist.q-station.net>
CC: linux-scsi@vger.kernel.org
Subject: Re: dd cdrom error
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Leung Yau Wai <chris@gist.q-station.net> wrote:
> I come across a problem which seem exist in kernel 
> 2.4.x but not in 2.2.x.
>
> The problem is that, when I try to using dd to create 
> a ISO image of a cdrom then around dumping the end of 
> the disc it will give out the following error message:
>
> e.g. dd if=/dev/cdrom of=n.iso

If dd is used like that, it is surprising you do not get
more errors. An iso9660 image does not necessarily fill
the track. So the IDE equivalent of the SCSI READ CAPACITY 
command will often report a size that includes unwritten 
sectors at the end. Those unwritten sectors can/will cause
IO errors when an attempt is made to read them.

A very useful program called "isosize" has made a return to
util-linux-2.10s (and later). Execute:
  isosize -x /dev/cdrom
to find the number of sectors and the sector size of the iso9660
fs held _within_ the first track. Then use those numbers as the 
"count=" and "bs=" arguments to dd respectively.


If you still have problems try turning DMA off via hdparm
or set the DMA mode back to 33 MHz (-X34).

Doug Gilbert
