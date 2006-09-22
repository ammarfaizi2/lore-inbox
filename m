Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbWIVRfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbWIVRfo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 13:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbWIVRfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 13:35:44 -0400
Received: from main.gmane.org ([80.91.229.2]:13804 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964816AbWIVRfn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 13:35:43 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Matthieu CASTET" <castet.matthieu@free.fr>
Subject: Re: [PATCH 1/3] [BFIN] Blackfin architecture patch for 2.6.18
Date: Fri, 22 Sep 2006 17:34:31 +0000 (UTC)
Message-ID: <ef16r7$vjo$1@sea.gmane.org>
References: <489ecd0c0609212204k6cbbf63ej7d59d3855a4993e7@mail.gmail.com>
	<20060921232921.88d2aa5d.rdunlap@xenotime.net>
	<489ecd0c0609220248m41749725t75ccf9ca8753b8dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cac94-1-81-57-151-96.fbx.proxad.net
User-Agent: pan 0.112 (Elijah Craig)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006 17:48:03 +0800, Luke Yang wrote:

>> 9.  In struct sport_register, what are all of those volatiles
>> for?  Use of volatile usually
>> indicates bad locking or bad memory barriers, etc., somewhere.
>  This is not a bug. In embedded, a memory mapped register should be
> defined as volatile, becasue the hardware may change it without
> notifying the software.
>
No this is bad design. Each time you want to access those memory map
register you should use read{bwl}/in{bwl} variants.
After all memory mapped register are not so different of mmio on standard
PC.

For example on au1x00 mips platform [1], some helper are defined to access
those memory map registers.

using volatile is awful : instead of a clean API to access those
registers, you often forgot that volatile is need which lead to very hard
to debug bugs (depend of compiler optimization, state of memory, ...).
For example on a embedded platform (ADI fusiv) where volatile are used
everywhere, some developers forgot some, which lead to random lockup on
boot.

Matthieu


[1]
include/asm-mips/mach-au1x00/au1000.h
static inline u32 au_readl(unsigned long reg)
{
    return (*(volatile u32 *)reg);
}

