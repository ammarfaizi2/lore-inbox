Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264069AbTIIMJm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 08:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264088AbTIIMHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 08:07:53 -0400
Received: from vlugnet.org ([217.160.107.28]:47233 "EHLO vlugnet.org")
	by vger.kernel.org with ESMTP id S264084AbTIIMHf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 08:07:35 -0400
From: Ronny Buchmann <ronny-lkml@vlugnet.org>
To: Marko Kreen <marko@l-t.ee>
Subject: Re: [OOPS] 2.4.22 / HPT372N
Date: Tue, 9 Sep 2003 14:06:56 +0200
User-Agent: KMail/1.5.3
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309091406.56334.ronny-lkml@vlugnet.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marko Kreen wrote:

> On Thu, Sep 04, 2003 at 10:46:53PM +0100, Alan Cox wrote:
>> On Iau, 2003-09-04 at 20:07, Marko Kreen wrote:
>> > As i used the pen&paper method for oops tracking i dont have
>> > full oops.
>> > 
>> > In hpt366.c function hpt372_tune_chipset line 427:
>> > 
>> >        list_conf = pci_bus_clock_list(speed,
>> >                         (struct chipset_bus_clock_list_entry *)
>> 
>> I thought I'd fixed that crash case but it seems your system is over
>> clocked.
>> 
>> FREQ: 85 PLL: 41
>> hpt: no known IDE timings,
>> 
>> so your PCI bus is running at somewhere about 35Mhz and outside the
>> drivers safe threshold.
> 
> Thats surprising, nobody has intentionally overclocked it.
> 
> Now we did some experimenting with it and no BIOS settings seem
> to affect the FREQ numbers. (Lower CPU/mem speed, 50/25 AGP/PCI speed.)
> The FREQ still stays fixed at 85.
> 
> Motherboard is EP-4PDA2+.
> 
> Any idea how to remove the overclocking?  Otherwise it seems
> like driver bug to me.
What bios version do you use? Have you tried a CMOS reset?

I have the same motherboard but a different problem with the hpt chip, only 
the first channel is recognized. (see 
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=97824)

part from dmesg (klogd) output
---
Sep  7 23:50:17 bserv kernel: HPT366: IDE controller at PCI slot 02:00.0
Sep  7 23:50:17 bserv kernel: HPT366: chipset revision 6
Sep  7 23:50:17 bserv kernel: HPT366: not 100%% native mode: will probe irqs 
later
Sep  7 23:50:17 bserv kernel: hpt: HPT372N detected, using 372N timing.
Sep  7 23:50:17 bserv kernel: FREQ: 82 PLL: 35
Sep  7 23:50:17 bserv kernel: HPT37X: using 50MHz internal PLL
Sep  7 23:50:17 bserv kernel:     ide2: BM-DMA at 0x8000-0x8007, BIOS 
settings:
hde:DMA, hdf:pio
Sep  7 23:50:17 bserv kernel: HPT372N support is EXPERIMENTAL ONLY.
---

Currently the driver provided by highpoint 
(http://www.highpoint-tech.com/hpt3xx-opensource-v131.tgz) is working ok for 
me (apart from it's lack of s.ma.r.t. support).

Did you try this?

-- 
ronny

