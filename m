Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268273AbTAMHQA>; Mon, 13 Jan 2003 02:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268274AbTAMHQA>; Mon, 13 Jan 2003 02:16:00 -0500
Received: from pacific.moreton.com.au ([203.143.238.4]:62737 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S268273AbTAMHP7>; Mon, 13 Jan 2003 02:15:59 -0500
Message-ID: <3E226969.5080406@snapgear.com>
Date: Mon, 13 Jan 2003 17:23:21 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.56: undefined reference to `_ebss' from drivers/mtd/maps/uclinux.c
References: <20030112095559.GT21826@fs.tum.de>
In-Reply-To: <20030112095559.GT21826@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

Adrian Bunk wrote:
> trying to compile 2.5.56 with CONFIG_MTD_UCLINUX fails on i386 with
>   undefined reference to `_ebss'
> at the final linking.
> 
> It seems _ebss is only defined on the architectures m68knommu and v850?

Hmm, currently that is correct. There doesn't appear to be a
"standard" symbol name applied to the immediate end of the bss
section. Different architectures are using different names:

   _ebss        -- m68knommu, v850
   __bss_stop   -- i386, alpha, ppc, s390
   __bss_end    -- x86_64
   _end         -- mips, parisc, sparc, (actually most have this)

Actually it looks like _end is probably closer, it seems to
almost always fall strait after the bss, on just about every
architecture that has it.

Come to think of it _end is probably more appropriate anyway.
Since that code is trying to find the location of something
concatenated to the end of the kernel image.

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

