Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVGLJrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVGLJrt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 05:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVGLJpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 05:45:36 -0400
Received: from aun.it.uu.se ([130.238.12.36]:32718 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261297AbVGLJom (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 05:44:42 -0400
Date: Tue, 12 Jul 2005 11:44:34 +0200 (MEST)
Message-Id: <200507120944.j6C9iYLo003533@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org, ssp@creativeresearch.org
Subject: Re: /proc/mtrr & BIOS-provided RAM map
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Jul 2005 01:00:54 -0700, Sheo Shanker Prasad wrote:
>(1) content of /proc/mtrr :
>
>reg00: base=0x00000000 (   0MB), size=2048MB: write-back, count=1
>reg01: base=0x80000000 (2048MB), size=1024MB: write-back, count=1
>reg02: base=0xc0000000 (3072MB), size= 128MB: write-back, count=1
>reg03: base=0xc8000000 (3200MB), size=  64MB: write-back, count=1
>reg04: base=0xd0000000 (3328MB), size= 256MB: write-combining, count=2
>
>(2) BIOS provided RAM map:
>
> BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
> BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
> BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
> BIOS-e820: 0000000000100000 - 00000000cbff0000 (usable)
> BIOS-e820: 00000000cbff0000 - 00000000cbfff000 (ACPI data)
> BIOS-e820: 00000000cbfff000 - 00000000cc000000 (ACPI NVS)
> BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)

Your BIOS gives you "usable" memory up to 0xcbff0000-1,
but it set up the MTRRs to only cache up to 0xc8010000-1.
Thus the memory at 0xc8010000 to 0xcbff0000-1 will be slow as h*ll.

This is a BIOS problem. An upgrade (if available) may help.

Using mem=3264M should work around the MTRR issue. You've
apparently tried that, so whatever's causing your performance
variations must be something else.

/Mikael
