Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265429AbUFRRCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265429AbUFRRCc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 13:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265698AbUFRRCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 13:02:32 -0400
Received: from outmail1.freedom2surf.net ([194.106.33.237]:14046 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S265429AbUFRQ7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 12:59:53 -0400
Date: Fri, 18 Jun 2004 17:59:02 +0100
From: Ian Molton <spyro@f2s.com>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com, tony@atomide.com, david-b@pacbell.net, jamey.hicks@hp.com,
       joshua@joshuawise.com
Subject: DMA API issues
Message-Id: <20040618175902.778e616a.spyro@f2s.com>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.9.12-gtk2-20040617 (GTK+ 2.4.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This may have come up previously but I havent seen it, so...

My colleagues and I are encountering a number of difficulties with the
DMA API, to which a generic solution is required (or risk multiple
architectures, busses, and devices going their own way...)

Here is an example system that illustrates these problems:

I have a System On Chip device which, among other functions, contains an
OHCI controller and 32K of SRAM.

heres the catch:- The OHCI controller has a different address space than
the host bus, and worse, can *only* DMA data from its internal SRAM.

The architecture is not broken, merely unusual.

This causes the following problems:

1) The DMA API provides no methods to set up a mapping between the host
   memory map and the devices view of the space
        example:
           the OHCI controller above would see its 32K of SRAM as
           mapped from 0x10000 - 0x1ffff and not 0xXXX10000 - 0xXXX1ffff
           which is the address the CPU sees.
2) The DMA API assumes the device can access SDRAM
        example:
           the OHCI controller base is mapped at 0x10000000 on my platform.
           this is NOT is SDRAM, its in IO space.

If these points are possible to be addressed, it would allow at LEAST three chips *in use* in linux devices able to use mainline OHCI code directly - TC6393XB (in toshiba PDAs), SAMCOP (Ipaqs), and mediaQ (dell axims).

I am told HPPA has some similar problems also.

PS. please make use of CC: when replying
