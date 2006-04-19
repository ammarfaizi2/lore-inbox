Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbWDSB1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWDSB1i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 21:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbWDSB1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 21:27:38 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:1449 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750934AbWDSB1h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 21:27:37 -0400
Date: Tue, 18 Apr 2006 18:27:28 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
cc: hugh@veritas.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       akpm@osdl.org
Subject: Re: Read/Write migration entries: Implement correct behavior in
 copy_one_pte
In-Reply-To: <20060419095044.d7333b21.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.64.0604181823590.9747@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0604181119480.7814@schroedinger.engr.sgi.com>
 <20060419095044.d7333b21.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2006, KAMEZAWA Hiroyuki wrote:

> > Note that this is again only a partial solution. mprotect() also has the
> > potential of changing the write status to read. 
> yes. in change_pte_range(). 
> 
> Note:
> fork() and mprotect() both requires mm->mmap_sem.
> So both of them is not problem when migration holds mm->mmap_sem.
> If we does lazy migration or memory hot removing or allows migration from
> another process, this will be problem.

Oh. We already allow migration from another process since the page may 
be mapped by multiple mm's. Page migration will then replace the ptes in 
*all* mm_structs that map this page with migration entries.

So we need a fix here.

