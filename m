Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269120AbUHYBjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269120AbUHYBjk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 21:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269124AbUHYBjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 21:39:40 -0400
Received: from mailhub.hp.com ([192.151.27.10]:25545 "EHLO mailhub.hp.com")
	by vger.kernel.org with ESMTP id S269120AbUHYBiN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 21:38:13 -0400
Subject: Re: [BK PATCH] I2C update for 2.6.8-rc1
From: Alex Williamson <alex.williamson@hp.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <greg@kroah.com>, akpm@osdl.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       sensors@Stimpy.netroedge.com
In-Reply-To: <Pine.LNX.4.58.0408241721330.17766@ppc970.osdl.org>
References: <20040715000527.GA18923@kroah.com>
	 <1093384722.8445.10.camel@tdi> <20040824220450.GE11165@kroah.com>
	 <Pine.LNX.4.58.0408241721330.17766@ppc970.osdl.org>
Content-Type: text/plain
Organization: LOSL
Date: Tue, 24 Aug 2004 19:38:01 -0600
Message-Id: <1093397881.9555.6.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-24 at 17:37 -0700, Linus Torvalds wrote:
> 
> On Tue, 24 Aug 2004, Greg KH wrote:
> > 
> > If someone can come up with a patch that works for everyone, I'll be
> > glad to apply it.
> 
> Hmm.. Why exactly does the PCI layer re-locate the IO ports?
> 
> Afaik, ACPI requesting the region shouldn't matter. The 
> "request_resource()" should still be happy..
> 
> Ahh. I see the problem. Because the ACPI code allocates the sub-resources, 
> the request_resource thing is indeed not happy.
> 
> How about this _trivial_ change? Does that fix things for you guys? Can 
> you send the /proc/ioport output if this works out for you, just so that 
> we can see?

   Yes, this works.  Please commit.  I still have reservations about
exposing this device (that firmware owns and we can't possibly
synchronize access to), but this is a big improvement over the unusable
state w/o this change.  Here's my /proc/ioports:

0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
03c0-03df : vga+
03e8-03ef : serial
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
1000-107f : 0000:00:1f.0
  1000-107f : motherboard
    1000-1003 : PM1a_EVT_BLK
    1004-1005 : PM1a_CNT_BLK
    1008-100b : PM_TMR
    1010-1015 : ACPI CPU throttle
    1020-1020 : PM2_CNT_BLK
    1028-102f : GPE0_BLK
1100-113f : 0000:00:1f.0
  1100-113f : motherboard
1200-121f : motherboard
  1200-121f : 0000:00:1f.3
2000-2fff : PCI Bus #01
  2000-20ff : 0000:01:00.0
    2000-20ff : radeonfb
3000-30ff : 0000:00:1f.5
3400-34ff : 0000:00:1f.6
  3400-34ff : Intel 82801DB-ICH4 Modem - AC'97
3800-387f : 0000:00:1f.6
  3800-387f : Intel 82801DB-ICH4 Modem - Controller
3880-38bf : 0000:00:1f.5
38c0-38df : 0000:00:1d.0
  38c0-38df : uhci_hcd
38e0-38ff : 0000:00:1d.1
  38e0-38ff : uhci_hcd
3c00-3c1f : 0000:00:1d.2
  3c00-3c1f : uhci_hcd
3c20-3c2f : 0000:00:1f.1
  3c20-3c27 : ide0
  3c28-3c2f : ide1
4000-40ff : PCI CardBus #03
4400-44ff : PCI CardBus #03
4800-48ff : PCI CardBus #07
4c00-4cff : PCI CardBus #07
5000-50ff : PCI CardBus #0b
5400-54ff : PCI CardBus #0b

Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

