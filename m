Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266330AbSLTX1P>; Fri, 20 Dec 2002 18:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266335AbSLTX1P>; Fri, 20 Dec 2002 18:27:15 -0500
Received: from franka.aracnet.com ([216.99.193.44]:38077 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266330AbSLTX1J>; Fri, 20 Dec 2002 18:27:09 -0500
Message-ID: <3E03A88E.50200@BitWagon.com>
Date: Fri, 20 Dec 2002 15:32:30 -0800
From: John Reiser <jreiser@BitWagon.com>
Organization: -
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Dike <jdike@karaya.com>
CC: linux-kernel@vger.kernel.org, Jeremy Fitzhardinge <jeremy@goop.org>,
       Julian Seward <jseward@acm.org>
Subject: Re: Valgrind meets UML
References: <200212202258.RAA03444@ccure.karaya.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike wrote:
> jreiser@BitWagon.com said:
> 
>>Implementors of allocators can have bugs in the valgrind declarations
>>they add. An "independent" check based on documented
>>externally-visible behavior can help. 
> 
> 
> The problem is that valgrind is going to look under the covers of the kernel
> allocators and see the externally-visible requirements being violated.
> 
> Either you implement a globally correct description, which includes the 
> externally visible description as a subset, or you somehow tell valgrind not
> to complain about stuff inside the allocator.
> 
> The second sounds complicated, and anyway hides bugs in the allocator.

I suggest that useful partial progress can be made sooner by identifying the
allocators, telling valgrind about them and their external semantics, and having
valgrind trust them.  In particular, do not valgrind allocators at first.
Waiting for the globally correct description can take a long time, perhaps
about as long as waiting for the authors of device drivers to update to a new
device I/O model.  Also, the globally correct description is necessarily time
dependent: it changes while the allocator is active, and describing it correctly
at that level of detail can be hard, or at least tedious.

Not valgrinding allocators still will reveal plenty of problems.  Those will
help provide motivation for implementing descriptions that are more detailed,
eventually even globally correct at every instant.  Then you can turn valgrind
loose on the allocators themselves.

-- 
John Reiser, jreiser@BitWagon.com

