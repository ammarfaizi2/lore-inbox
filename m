Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316971AbSFWEKu>; Sun, 23 Jun 2002 00:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316973AbSFWEKt>; Sun, 23 Jun 2002 00:10:49 -0400
Received: from spruce.woods.net ([166.70.175.33]:61879 "EHLO a.smtp.woods.net")
	by vger.kernel.org with ESMTP id <S316971AbSFWEKt>;
	Sun, 23 Jun 2002 00:10:49 -0400
Date: Sat, 22 Jun 2002 22:02:33 -0600 (MDT)
From: "Christopher E. Brown" <cbrown@woods.net>
To: "Griffiths, Richard A" <richard.a.griffiths@intel.com>
Cc: "'Andrew Morton'" <akpm@zip.com.au>, <mgross@unix-os.sc.intel.com>,
       "'Jens Axboe'" <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <lse-tech@lists.sourceforge.net>
Subject: RE: ext3 performance bottleneck as the number of spindles gets large
In-Reply-To: <01BDB7EEF8D4D3119D95009027AE99951B0E63EA@fmsmsx33.fm.intel.com>
Message-ID: <Pine.LNX.4.44.0206222119500.28630-100000@spruce.woods.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jun 2002, Griffiths, Richard A wrote:

> I should have mentioned the throughput we saw on 4 adapters 6 drives was
> 126KB/s.  The max theoretical bus bandwith is 640MB/s.


This is *NOT* correct.  Assuming a 64bit 66Mhz PCI bus your MAX is
503MB/sec minus PCI overhead...

This of course assumes nothing else is using the PCI bus.


120 something MB/sec sounds a hell of a lot like topping out a 32bit
33Mhz PCI bus, but IIRC the earlier posting listed 39160 cards, PCI
64bit w/ backward compat to 32bit.

You do have *ALL* of these cards plugged into a full PCI 64bit/66Mhz
slot right?  Not plugging them into a 32bit/33Mhz slot?


32bit/33Mhz	(32 * 33,000,000) / (1024 * 1024 * 8) = 125.89 MByte/sec
64bit/33Mhz	(64 * 33,000,000) / (1024 * 1024 * 8) = 251.77 MByte/sec
64bit/66Mhz	(64 * 66,000,000) / (1024 * 1024 * 8) = 503.54 MByte/sec


NOTE: PCI transfer rates are often listed as

32bit/33Mhz, 132 MByte/sec
64bit/33Mhz, 264 MByte/sec
64bit/66Mhz, 528 MByte/sec

This is somewhat true, but only if we start with Mbit rates as used in
transmission rates (1,000,000 bits/sec) and work from there, instead
of 2^20 (1,048,576).  I will not argue about PCI 32bit/33Mhz being
1056Mbit, if talking about line rate, but when we are talking about
storage media and transfers to/from as measured by files remember to
convert.

-- 
I route, therefore you are.


