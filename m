Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286311AbSCGImx>; Thu, 7 Mar 2002 03:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286647AbSCGImm>; Thu, 7 Mar 2002 03:42:42 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:44458 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S286311AbSCGImd>;
	Thu, 7 Mar 2002 03:42:33 -0500
Date: Thu, 7 Mar 2002 03:42:32 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Voluspa <voluspa@bigfoot.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.6-pre3 Kernel panic: VFS: Unable to mount root fs on 03:02
In-Reply-To: <20020307085636.4feb2372.voluspa@bigfoot.com>
Message-ID: <Pine.GSO.4.21.0203070329090.24127-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Mar 2002, Voluspa wrote:

> mount() -> -14
> VFS: Cannot open root device "302" or 03:02

Bloody hell...  14 is EFAULT.  And that - from sys_mount() called by
task that has KERNEL_DS as addr_limit.  What options do you pass to kernel
and what filesystems are compiled in?  Actually, adding printk("%s\n", p);
in the same place might give some hints...

Basically, sys_mount() is called in conditions when -EFAULT should not
be generated at all - it is handled on a pretty low level and AFAICS
that area hadn't been changed between -pre2 and -pre3.  Weird...

