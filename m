Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbVKKTHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbVKKTHt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 14:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbVKKTHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 14:07:49 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:46829 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751056AbVKKTHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 14:07:48 -0500
Date: Fri, 11 Nov 2005 11:07:34 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Ingo Oeser <ioe-lkml@rameria.de>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Badari Pulavarty <pbadari@us.ibm.com>, andrea@suse.de, hugh@veritas.com,
       linux-mm@kvack.org
Subject: Re: [RFC] sys_punchhole()
In-Reply-To: <200511110925.48259.ioe-lkml@rameria.de>
Message-ID: <Pine.LNX.4.62.0511111105240.20589@schroedinger.engr.sgi.com>
References: <1131664994.25354.36.camel@localhost.localdomain>
 <20051110153254.5dde61c5.akpm@osdl.org> <200511110925.48259.ioe-lkml@rameria.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2005, Ingo Oeser wrote:

> > I haven't even heard anyone mention a need for this in the past 1-2 years.
> 
> Because the people need it are usally at the application level.
> It would be useful with hard disk editing.
> 
> But this would need a move_blocks within the filesystem, which
> could attach a given list of blocks to another file.
> 
> E.g. mremap() for files :-)

Something similar to that is included in my patch migration patchsets.

It will also allow you to selectively push pages in a range out. So it 
does something similar to hole punching.

For that you would scan over the range to be cleared and put the pages on 
a list using isolate_lru_page(). Then do whatever you need to with the 
pages. Push em out with migrate_pages(list, NULL) etc.


