Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263573AbTDNROV (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 13:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbTDNROV (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 13:14:21 -0400
Received: from franka.aracnet.com ([216.99.193.44]:19587 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263573AbTDNROU (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 13:14:20 -0400
Date: Mon, 14 Apr 2003 10:22:46 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Antonio Vargas <wind@cocodriloo.com>
cc: Timothy Miller <tmiller10@cfl.rr.com>, linux-kernel@vger.kernel.org,
       nicoya@apia.dhs.org
Subject: Re: Quick question about hyper-threading (also some NUMA stuff)
Message-ID: <16700000.1050340965@[10.10.2.4]>
In-Reply-To: <20030414171419.GG14552@wind.cocodriloo.com>
References: <001301c3028a$25374f30$6801a8c0@epimetheus>
 <10760000.1050332136@[10.10.2.4]>
 <20030414152947.GB14552@wind.cocodriloo.com>
 <12790000.1050334744@[10.10.2.4]>
 <20030414155748.GD14552@wind.cocodriloo.com>
 <14860000.1050337484@[10.10.2.4]>
 <20030414164321.GE14552@wind.cocodriloo.com>
 <15700000.1050338226@[10.10.2.4]>
 <20030414171419.GG14552@wind.cocodriloo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Ah, you probably don't want to do that ... it's very expensive. Moreover,
>> if you exec 2ns later, all the effort will be wasted ... and it's very
>> hard to deterministically predict whether you'll exec or not (stupid
>> UNIX  semantics). Doing it lazily is probably best, and as to "nodes
>> would not  have to reference the memory from others" - you're still
>> doing that, you're just batching it on the front end.
> 
> True... What about a vma-level COW-ahead just like we have a file-level
> read-ahead, then? I mean batching the COW at unCOW-because-of-write time.

That'd be interesting ... and you can test that on a UP box, is not just
NUMA. Depends on the workload quite heavily, I suspect.
 
> btw, COW-ahead sound really silly :)

Yeah. So be sure to call it that if it works out ... we need more things
like that ;-) Moooooo.
 
> Not possible for me since I've got no SMP. But posting a quick note about
> your proposed "fake-NUMA-on-SMP.patch" would be good only if to have an
> offsite (offbrain also? ;) backup of your ideas :)

Oh, well basically you just need to split memory in half, and assign one
cpu to each "node" for each cpu_to_node thingy. Would be easy to just do it
as static #defines for sizes at first (most of the work in supporting a new
NUMA arch is just parsing the machinet tables). Set MAX_NUMNODES to > 1,
make sure you create a pgdat for each "node", and frig with build_zonelists
and free_area_init_core a bit. 

M.


