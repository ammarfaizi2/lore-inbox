Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbWBOUz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWBOUz1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 15:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWBOUz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 15:55:27 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:53448 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1751230AbWBOUz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 15:55:27 -0500
Message-ID: <43F39500.8060008@cfl.rr.com>
Date: Wed, 15 Feb 2006 15:54:24 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Seewer Philippe <philippe.seewer@bfh.ch>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: disk geometry via sysfs
References: <43EC8FBA.1080307@bfh.ch> <43F0B484.3060603@cfl.rr.com> <43F0D7AD.8050909@bfh.ch> <43F0DF32.8060709@cfl.rr.com> <43F206E7.70601@bfh.ch> <43F21F21.1010509@cfl.rr.com> <43F2E8BA.90001@bfh.ch> <58cb370e0602150051w2f276banb7662394bef2c369@mail.gmail.com> <1140019615.14831.22.camel@localhost.localdomain> <43F354E9.2020900@cfl.rr.com> <1140024754.14831.31.camel@localhost.localdomain> <43F3764C.8080503@cfl.rr.com> <Pine.LNX.4.61.0602151411130.9546@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0602151411130.9546@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Feb 2006 20:57:04.0707 (UTC) FILETIME=[6020F130:01C63272]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14270.000
X-TM-AS-Result: No--10.500000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> If the disc is a modern disk, and the BIOS is modern as well,
> it won't care. For instance, if we attempt to seek to cylinder
> 10, sector 10, and there are only 9 sectors, then the supplied
> head number is incremented, the sector to be read becomes 1
> (dumb ones based), and everything is fine. If the head number
> can't be incremented, it wraps to 0. Problems occur if the BIOS
> has been set to "physical" mode for access. In this mode, the
> CHS are absolute and "you can't get there from here." In the
> physical mode, you can't have more than 1024 cylinders because
> they need to fit into 10 bits.
> 
> As long as the BIOS is set for LBA, the boot sequence should not
> care.
> 

Are you sure?  Do all bioses perform this auto correction?  I would have 
thought that they would simply fail the request because you asked for a 
sector or head that is outside the valid range.  Even if some bioses 
will accept illegal values and auto translate, I doubt that they all do.

And what if you error in the other direction?  If the MBR lists a LOWER 
number of heads than the bios thinks there is?  In that case you're 
going to ask the bios for a larger cylinder number, and it will happily 
read a sector from the disk that is further from the start than you 
intended.


