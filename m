Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282604AbRKZWuH>; Mon, 26 Nov 2001 17:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282613AbRKZWt5>; Mon, 26 Nov 2001 17:49:57 -0500
Received: from sj-msg-core-2.cisco.com ([171.69.24.11]:20899 "EHLO
	sj-msg-core-2.cisco.com") by vger.kernel.org with ESMTP
	id <S282604AbRKZWtm>; Mon, 26 Nov 2001 17:49:42 -0500
Message-Id: <4.3.2.7.2.20011126143930.045eec28@171.69.24.15>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Mon, 26 Nov 2001 14:44:19 -0800
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: Unresponiveness of 2.4.16
Cc: ngrennan@okcforum.org (Nathan G. Grennan), linux-kernel@vger.kernel.org
In-Reply-To: <E168U3m-00077F-00@the-village.bc.nu>
In-Reply-To: <1006812135.1420.0.camel@cygnusx-1.okcforum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:17 PM 26/11/2001 +0000, Alan Cox wrote:
> > 2.4.16 becomes very unresponsive for 30 seconds or so at a time during
> > large unarchiving of tarballs, like tar -zxf mozilla-src.tar.gz. The
> > file is about 36mb. I run top in one window, run free repeatedly in
>
>This seems to be one of the small as yet unresolved problems with the newer
>VM code in 2.4.16. I've not managed to prove its the VM or the differing
>I/O scheduling rules however.

it is I/O scheduling.

i have a system with a large amount of RAM.
it has both 15K RPM SCSI disks (off a symbios controller) and some bog-slow 
IDE/ATA disks which the system decides to use PIO for rather than DMA.  (i 
don't use them for anything other than bootup so don't really care about it 
deciding to use PIO..).

a copy to/from the 15K RPM SCSI disks doesn't show any performance problems.
a copy to/from the PIO-based IDE disks has the same effect -- 20/30 seconds 
of no interactiveness -- even a "vmstat 1" *stops* for 20-30 seconds while 
200+MB of buffer-cache data gets written out to disk.

i'm guessing that:
  (a) the i/o scheduler isn't taking into account "disk speed" and thus 
slower disks
      show it more effectively than fast-disks
  (b) its isolated to somewhere in the IDE drivers


cheers,

lincoln.

