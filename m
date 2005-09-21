Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbVIUT2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbVIUT2h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 15:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbVIUT2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 15:28:37 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:62371 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S1751393AbVIUT2g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 15:28:36 -0400
Date: Wed, 21 Sep 2005 21:28:35 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Frank van Maarseveen <frankvm@frankvm.com>, Jay Lan <jlan@engr.sgi.com>,
       Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc2] fix incorrect mm->hiwater_vm and mm->hiwater_rss
Message-ID: <20050921192835.GA18347@janus>
References: <20050921121915.GA14645@janus> <Pine.LNX.4.61.0509211515330.6114@goblin.wat.veritas.com> <43319111.1050803@engr.sgi.com> <Pine.LNX.4.61.0509211802150.8880@goblin.wat.veritas.com> <4331990A.80904@engr.sgi.com> <Pine.LNX.4.61.0509211835190.9340@goblin.wat.veritas.com> <4331A0DA.5030801@engr.sgi.com> <20050921182627.GB17272@janus> <Pine.LNX.4.61.0509211958410.10449@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0509211958410.10449@goblin.wat.veritas.com>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 08:19:31PM +0100, Hugh Dickins wrote:
> On Wed, 21 Sep 2005, Frank van Maarseveen wrote:
> > 
> > What about calling
> > 
> > static inline void grow_total_vm(struct mm_struct *mm, unsigned long increase)
> > {
> > 	mm->total_vm += increase;
> > 	if (mm->total_vm > mm->hiwater_vm)
> > 		mm->hiwater_vm = mm->total_vm;
> > }
> > 
> > whenever total_vm is increased and possibly doing something similar for rss at
> > different places? If it is not on the fast path then it's not necessary to
> > #ifdef the thing anywhere.
> 
  ...
> But I think you're right that hiwater_vm is best updated where total_vm
> is: I'm not sure if it covers all cases completely (I think there's one
> or two places which don't bother to call __vm_stat_account because they
> believe it won't change anything), but in principle it would make lots of
> sense to do it in the __vm_stat_account which typically follows adjusting
> total_vm, as you did, and if possible nowhere else; rather than adding
> your inline above.

But update_mem_hiwater() is called at various places too, and I guess that
covers merely the total_vm increase, not rss.

Maybe above inline should replace update_mem_hiwater()?

-- 
Frank
