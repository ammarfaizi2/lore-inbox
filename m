Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267225AbSLEFPW>; Thu, 5 Dec 2002 00:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267226AbSLEFPW>; Thu, 5 Dec 2002 00:15:22 -0500
Received: from h-64-105-35-8.SNVACAID.covad.net ([64.105.35.8]:28827 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267225AbSLEFPU>; Thu, 5 Dec 2002 00:15:20 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 4 Dec 2002 21:20:49 -0800
Message-Id: <200212050520.VAA03472@adam.yggdrasil.com>
To: david@gibson.dropbear.id.au
Subject: Re: [RFC] generic device DMA implementation
Cc: davem@redhat.com, James.Bottomley@steeleye.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, miles@gnu.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At the risk of beating a dead horse, I'd like to clarify a potential
ambiguity.

David Gibson wrote:
>It seems the "try to get consistent memory, but otherwise give me
>inconsistent" is only useful on machines which:
>	(1) Are not fully consisent, BUT
>	(2) Can get consistent memory without disabling the cache, BUT
>	(3) Not very much of it, so you might run out.

>The point is, there has to be an advantage to using consistent memory
>if it is available AND the possibility of it not being available.

	It is enough that there is an advantage to using consistent
memory on one platform (such as sparc64?) and the possibility of it
not being available on another platform (such as parisc), given that
you want the driver on both platforms (such as 53c700).  In that case,
we have identified three possible choices so far:

APPROACH				PROBLEMS

1. Use both memory allocators.		Increased source and object size,
   (as 53c700 currently does)		rarely used code branches, unneeded
					"if (!consistent)" tests on platforms
					where the answer is constant.

2. Assume only inconsistent memory.	Slower on platforms where consistent
					memory has speed advantage

3. Have "maybe consistent" allocation
   and {w,r}mb_maybe(addr,len) macros.


Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

