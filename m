Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314558AbSDSFSk>; Fri, 19 Apr 2002 01:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314559AbSDSFSj>; Fri, 19 Apr 2002 01:18:39 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:18050 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S314558AbSDSFSj>; Fri, 19 Apr 2002 01:18:39 -0400
Date: Thu, 18 Apr 2002 22:18:43 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Mel <mel@csn.ul.ie>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documenation/vm/numa
Message-ID: <2809819807.1019168322@[10.10.2.3]>
In-Reply-To: <Pine.LNX.4.44.0204190448070.8173-100000@skynet>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Below is a small extension of the numa file in the vm Documenation branch
> which tries to give a brief explanation about pg_data_t and zone_t
> structs. Patch is against 2.4.19pre7 but I think it'll apply to any 2.4.x
> or 2.5.x kernel. No change of code etc etc etc. Comments, corrections and
> opinions very welcome

Nice job. Thanks for doing this.

> + node_start_paddr  The starting physical addres of the node?

Yes. Note that it's an unsigned long, which doesn't work for ia32 
with PAE (just as a for instance). Using a pfn (page frame number) 
would be a better choice here, IMHO (see my definition of pfn below).
Same comment for zone_start_paddr.

> + node_start_mapnr  This appears to be a "nice" place to put the zone
> inside +                   the larger mem_map. It's set during
> +                   free_page_init_core. Presumably there is some
> architecture +                   dependant way of defining nice.

Nice would be a strange term to use in this context - it's an ugly
hack ;-) It's the offset of the lmem_map array for that node within 
the global mem_map array, which doesn't really exist (I'm calling 
them arrays, though they're really just pointers - we use them like 
arrays though). mem_map is some arbitrary constant, set to point to 
PAGE_OFFSET or something similar.

> + zone_start_mapnr Address inside mem_map ?

Yes. Same comment as above ;-)

Note that there are two possible ways to define a pfn, in my mind.
One would be page_phys_addr >> PAGE_SHIFT. The other would be the
offset of the struct page for that page within the mythical mem_map
array. I prefer the former, though it probably contradicts everyone
else ;-) It's useful to have some way to pass around a 36 bit address
inside a 32 bit field.

M.

