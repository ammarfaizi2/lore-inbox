Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261859AbVCHIF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261859AbVCHIF5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 03:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbVCHIF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 03:05:57 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:57497 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261859AbVCHIFt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 03:05:49 -0500
Date: Tue, 8 Mar 2005 13:45:25 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: sct@redhat.com, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] Re: [RFC] ext3/jbd race: releasing in-use journal_heads
Message-ID: <20050308081525.GA4085@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20050307123118.3a946bc8.akpm@osdl.org> <1110229687.15117.612.camel@sisko.sctweedie.blueyonder.co.uk> <20050307131113.0fd7477e.akpm@osdl.org> <1110230527.15117.625.camel@sisko.sctweedie.blueyonder.co.uk> <1110237205.15117.702.camel@sisko.sctweedie.blueyonder.co.uk> <20050307155001.099352b5.akpm@osdl.org> <20050308062827.GA3756@in.ibm.com> <20050307224618.1cae3425.akpm@osdl.org> <20050308072650.GA3998@in.ibm.com> <20050307233742.79737606.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050307233742.79737606.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 11:37:42PM -0800, Andrew Morton wrote:
> Suparna Bhattacharya <suparna@in.ibm.com> wrote:
> >
> > (let me know if the interface in the patch
> >  I just posted seems like the right direction to use when we go for the
> >  cleanup)
> 
> Well what are the semantics?  Pass in an inclusive max_index and the gang
> lookup functions terminate when they hit an item whose index is greater
> than max_index?  And return the number of items thus found?

Yes. (end_index or max_items, whichever it hits first)

> 
> Seems sensible, and all the comparisons do the right thing if max_index = -1.

end_index is unsigned long - so -1 would imply highest index possible
... i.e. all items, subject to the radix_tree_maxindex (max_index used
internally in the radix tree code).


Regards
Suparna

> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Ext2-devel mailing list
> Ext2-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ext2-devel

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

