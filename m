Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265063AbUBEArC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 19:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265125AbUBEAqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 19:46:02 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:44936 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265063AbUBEAg7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 19:36:59 -0500
Date: Wed, 04 Feb 2004 16:36:40 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm mailing list <linux-mm@kvack.org>, kmannth@us.ibm.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Bugme-new] [Bug 2019] New: Bug from the mm subsystem involving X  (fwd)
Message-ID: <64260000.1075941399@flay>
In-Reply-To: <60330000.1075939958@flay>
References: <51080000.1075936626@flay> <Pine.LNX.4.58.0402041539470.2086@home.osdl.org> <60330000.1075939958@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> which seems to be the "PageReserved(pfn_to_page(pfn))" test.
>> 
>> This implies that you have either:
>>  - a buggy "pfn_valid()" macro (do you use CONFIG_DISCONTIGMEM?)
> 
> Yup.
># define pfn_valid(pfn)          ((pfn) < num_physpages)
> 
> Which is wrong. There's a even a comment above it that says:
> 
> /*
>  * pfn_valid should be made as fast as possible, and the current definition
>  * is valid for machines that are NUMA, but still contiguous, which is what
>  * is currently supported. A more generalised, but slower definition would
>  * be something like this - mbligh:
>  * ( pfn_to_pgdat(pfn) && ((pfn) < node_end_pfn(pfn_to_nid(pfn))) )
>  */
> 
> ;-)
> 
> Which I still don't think is correct, as there's a hole in the middle of
> node 0 ... I'll make a new patch up somehow and give to Keith to test ;-)

Oh hell ... I remember what's wrong with this whole bit. pfn_valid is
used inconsistently in different places, IIRC. Linus / Andrew ... what
do you actually want it to mean? Some things seem to use it to say
"the memory here is valid accessible RAM", some things "there is a 
valid struct page for this pfn". I was aiming for the latter, but a
few other arches seemed to disagree.

Could I get a ruling on this? ;-)

Thanks,

M.

