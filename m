Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261844AbVGQCKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbVGQCKF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 22:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbVGQCKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 22:10:05 -0400
Received: from mta7.srv.hcvlny.cv.net ([167.206.4.202]:36647 "EHLO
	mta7.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S261844AbVGQCKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 22:10:03 -0400
Date: Sat, 16 Jul 2005 22:08:48 -0400
From: Vincent C Jones <vcjones@networkingunlimited.com>
Subject: Re: [2.6.13-rc3][PCMCIA] - iounmap: bad address f1d62000
In-reply-to: <20050716151258.GA7819@isilmar.linta.de>
To: Dominik Brodowski <linux@dominikbrodowski.net>,
       linux-kernel@vger.kernel.org
Message-id: <20050717020848.GA8217@NetworkingUnlimited.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <4qGHl-3Hm-11@gated-at.bofh.it>
 <20050716144024.14C8E1F3DC@X31.networkingunlimited.com>
 <20050716151258.GA7819@isilmar.linta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2005 at 05:12:58PM +0200, Dominik Brodowski wrote:
> Could you check whether this patch helps, please?
> 
> Index: 2.6.13-rc3-git2/drivers/pcmcia/cistpl.c
> ===================================================================
> --- 2.6.13-rc3-git2.orig/drivers/pcmcia/cistpl.c
> +++ 2.6.13-rc3-git2/drivers/pcmcia/cistpl.c
> @@ -88,31 +88,38 @@ EXPORT_SYMBOL(release_cis_mem);
>  static void __iomem *

This patch appears to have cured it! Good job.

Just in case it is of use to use, I've also responded to your first
request below.

> Hi,
> 
> Could you send me the output of /proc/iomem on both a working kernel and on
> 2.6.13-rc3-APM, please?
> 
> Thanks,
> 	Dominik


First is as fails, second is same kernel with your patch applied, where
it seems to work just fine. Let me know if you would like it from
2.6.12.2 or 2.6.11.4-21.7 (SuSE 9.3) kernel.

Linux X31 2.6.13-rc3-APM #13 Fri Jul 15 23:55:12 EDT 2005 i686 i686 i386 GNU/Linux

00000000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cffff : Video ROM
000d0000-000d0fff : Adapter ROM
000d1000-000d1fff : Adapter ROM
000d2000-000d3fff : reserved
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-2ff5ffff : System RAM
  00100000-00361cfc : Kernel code
  00361cfd-004083e7 : Kernel data
2ff60000-2ff76fff : ACPI Tables
2ff77000-2ff78fff : ACPI Non-volatile Storage
2ff80000-2fffffff : reserved
30000000-300003ff : 0000:00:1f.1
b0000000-b0000fff : 0000:02:00.0
  b0000000-b0000fff : yenta_socket
b1000000-b1000fff : 0000:02:00.1
  b1000000-b1000fff : yenta_socket
c0000000-c00003ff : 0000:00:1d.7
  c0000000-c00003ff : ehci_hcd
c0000800-c00008ff : 0000:00:1f.5
  c0000800-c00008ff : Intel 82801DB-ICH4
c0000c00-c0000dff : 0000:00:1f.5
  c0000c00-c0000dff : Intel 82801DB-ICH4
c0100000-c01fffff : PCI Bus #01
  c0100000-c010ffff : 0000:01:00.0
    c0100000-c010ffff : radeonfb
  c0120000-c013ffff : 0000:01:00.0
c0200000-cfffffff : PCI Bus #02
  c0200000-c020ffff : 0000:02:01.0
  c0210000-c021ffff : 0000:02:02.0
    c0210000-c021ffff : ath
  c0220000-c023ffff : 0000:02:01.0
  c0240000-c02407ff : 0000:02:00.2
    c0240000-c02407ff : ohci1394
  c1200000-c1200fff : pcmcia_socket1
  c2000000-c3ffffff : PCI CardBus #03
  c4000000-c5ffffff : PCI CardBus #07
d0000000-dfffffff : 0000:00:00.0
e0000000-e7ffffff : PCI Bus #01
  e0000000-e7ffffff : 0000:01:00.0
    e0000000-e7ffffff : radeonfb
e8000000-efffffff : PCI Bus #02
  e8000000-e9ffffff : PCI CardBus #03
  ea000000-ebffffff : PCI CardBus #07
  ec000000-ec00ffff : 0000:02:01.0
ff800000-ffffffff : reserved

==================================================================================

Linux X31 2.6.13-rc3-APM #14 Sat Jul 16 10:19:10 EDT 2005 i686 i686 i386 GNU/Linux

00000000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cffff : Video ROM
000d0000-000d0fff : Adapter ROM
000d1000-000d1fff : Adapter ROM
000d2000-000d3fff : reserved
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-2ff5ffff : System RAM
  00100000-00359af0 : Kernel code
  00359af1-003fe3e7 : Kernel data
2ff60000-2ff76fff : ACPI Tables
2ff77000-2ff78fff : ACPI Non-volatile Storage
2ff80000-2fffffff : reserved
30000000-300003ff : 0000:00:1f.1
b0000000-b0000fff : 0000:02:00.0
  b0000000-b0000fff : yenta_socket
b1000000-b1000fff : 0000:02:00.1
  b1000000-b1000fff : yenta_socket
c0000000-c00003ff : 0000:00:1d.7
  c0000000-c00003ff : ehci_hcd
c0000800-c00008ff : 0000:00:1f.5
  c0000800-c00008ff : Intel 82801DB-ICH4
c0000c00-c0000dff : 0000:00:1f.5
  c0000c00-c0000dff : Intel 82801DB-ICH4
c0100000-c01fffff : PCI Bus #01
  c0100000-c010ffff : 0000:01:00.0
    c0100000-c010ffff : radeonfb
  c0120000-c013ffff : 0000:01:00.0
c0200000-cfffffff : PCI Bus #02
  c0200000-c020ffff : 0000:02:01.0
  c0210000-c021ffff : 0000:02:02.0
    c0210000-c021ffff : ath
  c0220000-c023ffff : 0000:02:01.0
  c0240000-c02407ff : 0000:02:00.2
    c0240000-c02407ff : ohci1394
  c1200000-c1200fff : pcmcia_socket1
  c2000000-c3ffffff : PCI CardBus #03
  c4000000-c5ffffff : PCI CardBus #07
d0000000-dfffffff : 0000:00:00.0
e0000000-e7ffffff : PCI Bus #01
  e0000000-e7ffffff : 0000:01:00.0
    e0000000-e7ffffff : radeonfb
e8000000-efffffff : PCI Bus #02
  e8000000-e9ffffff : PCI CardBus #03
  ea000000-ebffffff : PCI CardBus #07
  ec000000-ec00ffff : 0000:02:01.0
ff800000-ffffffff : reserved

-- 
Dr. Vincent C. Jones, PE              Expert advice and a helping hand
Computer Network Consultant           for those who want to manage and
Networking Unlimited, Inc.            control their networking destiny
Phone: +1 201 568-7810
14 Dogwood Lane, Tenafly, NJ 07670
VCJones@NetworkingUnlimited.com     http://www.networkingunlimited.com
