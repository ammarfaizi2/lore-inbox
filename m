Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262414AbSLTPV0>; Fri, 20 Dec 2002 10:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262420AbSLTPV0>; Fri, 20 Dec 2002 10:21:26 -0500
Received: from franka.aracnet.com ([216.99.193.44]:17863 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262414AbSLTPVZ>; Fri, 20 Dec 2002 10:21:25 -0500
Message-ID: <3E0336AF.6060607@BitWagon.com>
Date: Fri, 20 Dec 2002 07:26:39 -0800
From: John Reiser <jreiser@BitWagon.com>
Organization: -
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Dike <jdike@karaya.com>
CC: linux-kernel@vger.kernel.org, Jeremy Fitzhardinge <jeremy@goop.org>,
       Julian Seward <jseward@acm.org>
Subject: Re: Valgrind meets UML
References: <200212200241.VAA04202@ccure.karaya.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike wrote:
> I would also appreciate suggestions on what sort of memory access state table
> to implement, and where best to put the declarations.  What I'm not clear
> on is what sort of access a buffer should have when it's in the care of
> the allocator (i.e. it's free).  If the allocator sticks information 
> temporarily in the buffer, then that needs to be stated.

Probably there will be some benefits, at least for a while, if valgrind for UML
"knows" the kernel allocators like valgrind for applications "knows" malloc+free.
Implementors of allocators can have bugs in the valgrind declarations they add.
An "independent" check based on documented externally-visible behavior can help.

Nested allocators (inner allocator grabs a large region, outer allocator performs
sub-allocations of small pieces from the large region) can be troublesome.

Implementing a four-state status {-, W, RW, RO} might be much more work,
because some accounting schemes are oriented naturally towards only three states
{-, W, RW}.  Also, there are contenders for two additional states: watchpoints
for READ and WRITE, such as "any read of a back-pointer of this doubly-linked
list", etc.

-- 
John Reiser, jreiser@BitWagon.com

