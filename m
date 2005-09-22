Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030411AbVIVPrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030411AbVIVPrJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 11:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030412AbVIVPrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 11:47:09 -0400
Received: from teetot.devrandom.net ([66.35.250.243]:48841 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S1030411AbVIVPrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 11:47:06 -0400
Date: Thu, 22 Sep 2005 08:58:54 -0700
From: thockin@hockin.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: scampbell@malone.edu, linux-kernel@vger.kernel.org
Subject: Re: PCI Express or TG3 issue
Message-ID: <20050922155854.GA31157@hockin.org>
References: <15F23A40330F5742B268A041F003055705D2A3@srv-elijah1.malone.int> <20050921181151.GA809@hockin.org> <20050923.002548.126141978.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050923.002548.126141978.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2005 at 12:25:48AM +0900, Atsushi Nemoto wrote:
> >>>>> On Wed, 21 Sep 2005 11:11:51 -0700, thockin@hockin.org said:
> 
> thockin> This device is claiming that it has a 64-bit base-address
> thockin> which has been programmed by BIOS to be at
> thockin> 0x80000001d0000000.
> 
> thockin> I suspect that the 4 bytes at offset 0x14 want to be 0.  The
> thockin> address 0xd0000000 jives with the rest of your PCI listing.
> 
> thockin> I don't know where that extra 0x80000001 comes from, but it's
> thockin> pretty clearly wrong.  BIOS bug?  I can't see where kernel
> thockin> would have boned that up *that* badly.
> 
> I also have seen same problem on some custom MIPS-based boards which
> do not have BIOS.  Broadcom BCM5751 had garbage in its 64-bit BAR on
> power-up.  So it should not be a BIOS bug.  And I also could not find
> any good place to fixup it at that time.

Well, on a PC (i386 or x86_64) system, that address is almost certainly
going to be below 4G.  You could reguister a quirk to zero the upper half
of that BAR...
