Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288121AbSAMUYq>; Sun, 13 Jan 2002 15:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288113AbSAMUYh>; Sun, 13 Jan 2002 15:24:37 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38417 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288117AbSAMUYW>; Sun, 13 Jan 2002 15:24:22 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] 1-2-3 GB
Date: 13 Jan 2002 12:24:03 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a1sqd3$nc6$1@cesium.transmeta.com>
In-Reply-To: <20020112125625.E1482@inspiron.school.suse.de> <Pine.LNX.4.21.0201121825200.1105-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.21.0201121825200.1105-100000@localhost.localdomain>
By author:    Hugh Dickins <hugh@veritas.com>
In newsgroup: linux.dev.kernel
> 
> Usually not a problem: but if you configure for 1GB of user virtual
> and 3GB of kernel virtual, and you have more than 1GB of physical
> memory (as you normally would if chose HIGHMEM64G), then there's
> a page at physical address 0x3ffff000, directly mapped to virtual
> address 0x7ffff000.  And if that page happens to get used for the
> pmd of a process, then on exit the free_one_pgd loop wraps over
> to carry on freeing "entries" at 0x80000000, 0x80000008, ...
> A lot of pmd_ERROR messages, but eventually an entry scrapes
> through the pmd_bad test and is wrongly freed, not so good.
> 

By the way, expect user programs to fail due to lack of address space
if you only give them 1 GB of userspace.  At 1 GB of userspace there
is *no* address space which is compatible with the normal address
space map available to the user process.

I would personally vote against including that particular option.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
