Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310278AbSCEGVd>; Tue, 5 Mar 2002 01:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293614AbSCEGVY>; Tue, 5 Mar 2002 01:21:24 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:14247 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S292847AbSCEGVG>; Tue, 5 Mar 2002 01:21:06 -0500
Date: Mon, 04 Mar 2002 22:21:43 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: Stephan von Krawczynski <skraw@ithnet.com>, riel@conectiva.com.br,
        phillips@bonn-fries.net, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
Message-ID: <797268050.1015280502@[10.10.2.3]>
In-Reply-To: <20020304230603.O20606@dualathlon.random>
In-Reply-To: <20020304230603.O20606@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> seems to me to be that the way we do current swap-out scanning is
>> virtual,  not physical, and thus cannot be per zone => per node.
>
> actually if you do process bindings the pte should be all allocated
> local to the node if numa is enabled, and if there's no binding, no
> matter if you have rmap or not, the ptes can be spread across the whole
> system (just like the physical pages in the inactive/active lrus,
> because they're not per-node).

Why does it matter if the ptes are spread across the system?
I get the feeling I'm missing some magic trick here ...

In reality we're not going to hard-bind every process,
though we'll try to keep most of the allocations local.

Imagine I have eight nodes (0..7), each with one zone (0..7).
I need to free memory from zone 5 ... with the virtual scan,
it seems to me that all I can do is blunder through the whole
process list looking for something that happens to have pages
on zone 5 that aren't being used much? Is this not expensive?
Won't I end up with a whole bunch of cross-node mem transfers?

M.

