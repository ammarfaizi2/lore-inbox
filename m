Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317752AbSIIRbD>; Mon, 9 Sep 2002 13:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318139AbSIIRbC>; Mon, 9 Sep 2002 13:31:02 -0400
Received: from antigonus.hosting.pacbell.net ([216.100.98.13]:22167 "EHLO
	antigonus.hosting.pacbell.net") by vger.kernel.org with ESMTP
	id <S317752AbSIIRax>; Mon, 9 Sep 2002 13:30:53 -0400
Reply-To: <imran.badr@cavium.com>
From: "Imran Badr" <imran.badr@cavium.com>
To: <root@chaos.analogic.com>
Cc: "'David S. Miller'" <davem@redhat.com>, <phillips@arcor.de>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Calculating kernel logical address ..
Date: Mon, 9 Sep 2002 10:31:44 -0700
Message-ID: <019f01c25826$c553f310$9e10a8c0@IMRANPC>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.3.95.1020909132344.17307A-100000@chaos.analogic.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The virt_to_bus() macro would work only for kernel logical addresses. I am
trying to find a portable way to figure out the kernel logical address of a
user buffer so that I could use virt_to_bus() for DMA. The user address is
mmap'ed from kmalloc'ed buffer in the mmap() entry of my driver. Now when
the user wants to send this data to the PCI device, it makes an ioctl call
and give the user address to the driver. Now driver has to figure out the
kernel logical address for DMA.

Thanks,
Imran.

-----Original Message-----
From: Richard B. Johnson [mailto:root@chaos.analogic.com]
Sent: Monday, September 09, 2002 10:30 AM
To: Imran Badr
Cc: 'David S. Miller'; phillips@arcor.de; linux-kernel@vger.kernel.org
Subject: RE: Calculating kernel logical address ..


On Mon, 9 Sep 2002, Imran Badr wrote:

>
> So, what you gurus suggest me to do? How can I get physical address of a
> user buffer (which was originally mmap'ed() from a kmalloc() allocation)
and
> which would also be protable across multiple platforms?
>
> Thanks.
> Imran.

I think there is a virt_to_bus() macro and its inverse. The 'bus' address
is what you need to give to bus-masters that do DMA. This is different
than virt_to_phys(), which happens to be the same on some platforms
but would not be the same on those, like PPC (Motorola), which have
separate address spaces for different things (RAM, I/O, etc).

Isn't this what you want?

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.


