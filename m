Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262130AbSKTSjB>; Wed, 20 Nov 2002 13:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262207AbSKTSjB>; Wed, 20 Nov 2002 13:39:01 -0500
Received: from elin.scali.no ([62.70.89.10]:46089 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S262130AbSKTSjA>;
	Wed, 20 Nov 2002 13:39:00 -0500
Date: Wed, 20 Nov 2002 19:48:27 +0100 (CET)
From: Steffen Persvold <sp@scali.com>
X-X-Sender: sp@sp-laptop.isdn.scali.no
To: Dave Jones <davej@codemonkey.org.uk>
cc: Margit Schubert-While <margit@margit.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-rc2 strange L1 cache values
In-Reply-To: <20021120181359.GA10698@suse.de>
Message-ID: <Pine.LNX.4.44.0211201941290.15336-100000@sp-laptop.isdn.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2002, Dave Jones wrote:

> On Wed, Nov 20, 2002 at 07:05:06PM +0100, Margit Schubert-While wrote:
>  > Any ideas anybody ?
>  > <6>CPU: L1 I cache: 0K, L1 D cache: 8K
>  > <6>CPU: L2 cache: 512K
>  > <6>Intel machine check architecture supported.
>  > <6>Intel machine check reporting enabled on CPU#0.
>  > <7>CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
>  > <7>CPU:             Common caps: 3febfbff 00000000 00000000 00000000
>  > <4>CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 04
> 
> P4 Trace cache isn't recognised.
> Apply ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.4/2.4.20/descriptors.diff
> 

Yep that works (I have two Xeon boxes with the same issue) :

(2.4.20-rc2 with descriptors.diff)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU0: Intel(R) XEON(TM) CPU 1.80GHz stepping 04

But why does this P4 Trace cache report as L1 I cache on 2.4.18 ? 

(2.4.18)
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU0: Intel(R) XEON(TM) CPU 1.80GHz stepping 04

Does this have any implications on the 2.4.18 performance (or the 
2.4.20-rc2 performance without the descriptors.diff) ?

Regards,
-- 
  Steffen Persvold   |       Scali AS      
 mailto:sp@scali.com |  http://www.scali.com
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY

