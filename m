Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264454AbUBEB3Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 20:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264481AbUBEB3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 20:29:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:15264 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264454AbUBEB3N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 20:29:13 -0500
Date: Wed, 4 Feb 2004 17:29:04 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: mbligh@aracnet.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       kmannth@us.ibm.com
Subject: Re: [Bugme-new] [Bug 2019] New: Bug from the mm subsystem involving
 X  (fwd)
In-Reply-To: <20040204165620.3d608798.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0402041719300.2086@home.osdl.org>
References: <51080000.1075936626@flay> <Pine.LNX.4.58.0402041539470.2086@home.osdl.org>
 <60330000.1075939958@flay> <64260000.1075941399@flay>
 <Pine.LNX.4.58.0402041639420.2086@home.osdl.org> <20040204165620.3d608798.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 4 Feb 2004, Andrew Morton wrote:
> 
> pfn_valid() could become quite expensive indeed, and it lies on super-duper
> hotpaths.

Yes. However, sometimes it is the only choice. 

So it does need to be fixed, and if it ends up being a noticeable
perofmance problem, then we can look at the hot-paths one by one and see
if we can avoid using it. We probably can, most of the time.

> An alternative which is less conceptually clean but should work in this
> case is to mark all vma's which were created by /dev/mem mappings as VM_IO,
> and test that in remap_page_range().

Hmm.. Grepping for "pfn_valid()", I'm starting to suspect that yes, with a
VM_IO approach and a fixed virt_addr_valid(), there really aren't any
other uses.

(virt_addr_valid() is useful for debugging and for validation of untrusted
pointers, but pfn_valid() just isn't very good for it. Never really was:  
it started out as an ugly hack, and it never got cleaned up. It should be
easily fixable with something _proper_).

			Linus
