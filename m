Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132110AbRC2F4w>; Thu, 29 Mar 2001 00:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132594AbRC2F4m>; Thu, 29 Mar 2001 00:56:42 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:43246 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132110AbRC2F4d>;
	Thu, 29 Mar 2001 00:56:33 -0500
Date: Thu, 29 Mar 2001 00:55:50 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: John R Lenton <john@grulic.org.ar>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel panic in 2.4.2
In-Reply-To: <20010329024641.B4303@grulic.org.ar>
Message-ID: <Pine.GSO.4.21.0103290051560.29140-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Mar 2001, John R Lenton wrote:

> When I arrived at my machine tonight it was dead, with a nice
> panic on the screen as a greeting. On rebooting I found something
> in the logs, which is rare because it said "not syncing". So I'm
> assuming this isn't the panic that killed the box, but she
> probably knows (of) him, so let's interrogate her anyway:
> 
> Unable to handle kernel paging request at virtual address 00020008
> c0139fad
> *pde = 00000000
> Oops: 0002
> CPU:    0
> EIP:    0010:[bdput+5/96]
> EFLAGS: 00010206
> eax: 00020000   ebx: 00020000   ecx: ca59a648   edx: c15ddfa4
> esi: c15ddfa4   edi: c97b9428   ebp: c15ddfac   esp: c15ddf6c

inode with ->i_bdev == 0x20000. Very likely to be a one-bit memory
corruption. May be hardware, may be not - unfortunately, all we know
is that bit 18 in that word had been flipped. Whatever had done that
had no idea that word stores the pointer - that's for sure...

Check the memory - it _may_ be a hardware problem.

