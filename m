Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbULIVa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbULIVa0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 16:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbULIVa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 16:30:26 -0500
Received: from mail.igrin.co.nz ([202.49.244.12]:32149 "EHLO mail.igrin.co.nz")
	by vger.kernel.org with ESMTP id S261631AbULIVaM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 16:30:12 -0500
Message-Id: <6.1.2.0.1.20041210102725.05bdc350@pop3.igrin.co.nz>
X-Mailer: QUALCOMM Windows Eudora Version 6.1.2.0
Date: Fri, 10 Dec 2004 10:29:41 +1300
To: Len Brown <len.brown@intel.com>, Willy Tarreau <willy@w.ods.org>
From: Simon Byrnand <simon@igrin.co.nz>
Subject: Re: 2.4.27 -> 2.4.28 breaks i810-tco watchdog timer
Cc: linux-kernel@vger.kernel.org, Shaohua Li <shaohua.li@intel.com>
In-Reply-To: <1102487662.2196.18.camel@d845pe>
References: <20041208054834.GD17946@alpha.home.local>
 <1102487662.2196.18.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 19:34 8/12/2004, Len Brown wrote:

>On Wed, 2004-12-08 at 00:48, Willy Tarreau wrote:
> > Hi,
> >
> > On Wed, Dec 08, 2004 at 08:59:35AM +1300, Simon Byrnand wrote:
> > (...)
> > > e400-e47f : motherboard
> > > e800-e81f : motherboard
> > > ec00-ec3f : motherboard
> > > f000-f00f : Intel Corp. 82801DB Ultra ATA Storage Controller
> > >   f000-f007 : ide0
> > >   f008-f00f : ide1
> > >
> > > Clearly the IO range the driver is trying to open is already in use
> > by
> > > "motherboard". If I check another almost identical machine still
> > running
>
>
>Does this patch in 2.4.29 help?
>http://linux.bkbits.net:8080/linux-2.4/cset@41a29b2db1heWGdXTVfdZPyWafsD8g

Yes! That did the trick. The watchdog timer now loads :-)

Cat /proc/ioports now shows:

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
02f8-02ff : serial(auto)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
1000-101f : Intel Corp. 82801DB/DBM SMBus Controller
a400-a47f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
   a400-a47f : 02:0c.0
a800-a8ff : 3ware Inc 3ware ATA-RAID
d000-dfff : PCI Bus #01
   d800-d8ff : ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE]
e400-e47f : motherboard
   e400-e403 : PM1a_EVT_BLK
   e404-e405 : PM1a_CNT_BLK
   e408-e40b : PM_TMR
   e428-e42f : GPE0_BLK
   e460-e46f : i810 TCO
e800-e81f : motherboard
ec00-ec3f : motherboard
f000-f00f : Intel Corp. 82801DB Ultra ATA Storage Controller
   f000-f007 : ide0
   f008-f00f : ide1

Is this patch already in 2.4.29 "for sure" or is it just a proposed patch 
at this time ? Hopefully it will go in.

Regards,
Simon

