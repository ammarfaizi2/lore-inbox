Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265823AbSKAXYM>; Fri, 1 Nov 2002 18:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265824AbSKAXYL>; Fri, 1 Nov 2002 18:24:11 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:5764 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265823AbSKAXYK>;
	Fri, 1 Nov 2002 18:24:10 -0500
Date: Fri, 1 Nov 2002 23:29:48 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: "Matt D. Robinson" <yakker@aparity.com>
Cc: "Donepudi, Suneeta" <sdonepudi@3eti.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Panic during memcpy_toio to PCI card
Message-ID: <20021101232948.GA7650@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Matt D. Robinson" <yakker@aparity.com>,
	"Donepudi, Suneeta" <sdonepudi@3eti.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <EF5625F9F795C94BA28B150706A215480DF84D@MAIL> <Pine.LNX.4.44.0211011527460.27345-100000@nakedeye.aparity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211011527460.27345-100000@nakedeye.aparity.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2002 at 03:28:10PM -0800, Matt D. Robinson wrote:

 >It still caused the crash in the same manner and at the same location.
 >Could someone help me with pointers to where I should start looking ?
 >Disabling interrupts around the memcpy_toio() did not make any
 >difference. Is this a hardware problem with the PCI card ? We are using
 >a Xilinx core with out FPGA build into it.

memcpy_toio() in 2.4 is still using memcpy() which could use prefetch()
if you compile for certain processors.  Prefetching io space could do
all sorts of nasties.

2.5 changed this define (in include/asm-i386/io.h) to use __memcpy
instead, which doesn't use prefetching.

		Dave

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
