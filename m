Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132072AbRACEbj>; Tue, 2 Jan 2001 23:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132172AbRACEb3>; Tue, 2 Jan 2001 23:31:29 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:54424 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132072AbRACEbZ>;
	Tue, 2 Jan 2001 23:31:25 -0500
Date: Tue, 2 Jan 2001 23:00:58 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops in prune_dcache (2.4.0-prerelease)
In-Reply-To: <3A529F06.5BFA4229@Hell.WH8.TU-Dresden.De>
Message-ID: <Pine.GSO.4.21.0101022248400.13824-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2001, Udo A. Steinberg wrote:

> 
> Hi Linus et. all
> 
> While under massive disk and cpu load, 2.4.0-prerelease produced
> the following oops (decode see below)
 
> Unable to handle kernel paging request at virtual address 01000014
 
> Code;  c01419cc <prune_dcache+9c/120>   <=====
>    0:   8b 40 14                  movl   0x14(%eax),%eax   <=====
> Code;  c01419cf <prune_dcache+9f/120>
>    3:   85 c0                     testl  %eax,%eax
> Code;  c01419d1 <prune_dcache+a1/120>
>    5:   74 09                     je     10 <_EIP+0x10> c01419dc <prune_dcache+ac/120>

dentry->d_op == 0x1000000 in dentry_iput(). 9:1 that you've got bit 24 flipped
(i.e. it was supposed to be NULL and you are seeing an effect of hardware
problem).

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
