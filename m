Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131157AbQK3UGK>; Thu, 30 Nov 2000 15:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131070AbQK3UGA>; Thu, 30 Nov 2000 15:06:00 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:1723 "EHLO math.psu.edu")
        by vger.kernel.org with ESMTP id <S131106AbQK3TiT>;
        Thu, 30 Nov 2000 14:38:19 -0500
Date: Thu, 30 Nov 2000 14:07:51 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Jonathan Hudson <jonathan@daria.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: corruption
In-Reply-To: <b09.3a269edc.6bd12@trespassersw.daria.co.uk>
Message-ID: <Pine.GSO.4.21.0011301400290.20801-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 30 Nov 2000, Jonathan Hudson wrote:

> 
> In article <3A26625E.446AE3D@uow.edu.au>,
> 	Andrew Morton <andrewm@uow.edu.au> writes:
> AM> In thread "File corruption part deux", Lawrence Walton wrote:
> >> 
> >> my system has been acting slightly odd on all the pre 12 kernels
> >> with the fs going read only with out any messages until now.
> >> no opps or anything like that, but I did get this just now.
> >> 
> >> EXT2-fs error (device sd(8,2)): ext2_readdir:
> >> bad entry in directory #458430: directory entry
> >> across blocks - offset=152, inode=3393794200,
> >> rec_len=12440, name_len=73
> >>
> AM> 
> AM> 3393794200 == 0xca493098.  A kernel address. And 152 is 0x98,
> AM> which is equal to N * 0x20 + 0x18. Read on...
> AM> 
> 
> Don't know what these do for your analysis, observed on
> 2.4.0test12pre2, compiling mozilla. 
> 
>  EXT2-fs error (device ide0(3,11)):
>    ext2_readdir: bad entry in directory #409870: directory entry across blocks
>    - offset=88, inode=3284439128, rec_len=36952, name_len=196

offset 0x58, data: 58 90 c4 c3 58 90 c4

Confirms. That's definitely an empty list_head at address 0xc3c49058 and -pre2
has O_SYNC patches.

>  EXT2-fs error (device ide0(3,11)): 
>    ext2_add_entry: bad entry in directory #344273: rec_len % 4 != 0 - offset=0, 
>    inode=1769234798, rec_len=28271, name_len=85

data: 6e 61 74 69 6f 6e 55, i.e. "nationU"

... and that one looks like a duplicated blocks effect, but there may be a lot
of other reasons for that.

> Recompiling it with 2.4.0test12pre3 last night did not cause any fs
> problems, at least that I've noticed.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
