Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbVIUS0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbVIUS0a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 14:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbVIUS03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 14:26:29 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:58019 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S1751358AbVIUS03
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 14:26:29 -0400
Date: Wed, 21 Sep 2005 20:26:27 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Jay Lan <jlan@engr.sgi.com>
Cc: Hugh Dickins <hugh@veritas.com>,
       Frank van Maarseveen <frankvm@frankvm.com>,
       Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc2] fix incorrect mm->hiwater_vm and mm->hiwater_rss
Message-ID: <20050921182627.GB17272@janus>
References: <20050921121915.GA14645@janus> <Pine.LNX.4.61.0509211515330.6114@goblin.wat.veritas.com> <43319111.1050803@engr.sgi.com> <Pine.LNX.4.61.0509211802150.8880@goblin.wat.veritas.com> <4331990A.80904@engr.sgi.com> <Pine.LNX.4.61.0509211835190.9340@goblin.wat.veritas.com> <4331A0DA.5030801@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4331A0DA.5030801@engr.sgi.com>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 11:05:14AM -0700, Jay Lan wrote:
> 
> System accounting improvement is needed because those accouting
> information were needed and used at real customer sites.
> 
> So, yes, the basic system accounting code (ie, BSD) needs
> improvement, and, no, i am done with sys acct data collection.

Ok, but how do you verify that the mm->hiwater_* counters are correct to
any degree? because it appears that at least hiwater_vm is incorrect in
post-2.6.11 and not by a small amount.


What about calling

static inline void grow_total_vm(struct mm_struct *mm, unsigned long increase)
{
	mm->total_vm += increase;
	if (mm->total_vm > mm->hiwater_vm)
		mm->hiwater_vm = mm->total_vm;
}

whenever total_vm is increased and possibly doing something similar for rss at
different places? If it is not on the fast path then it's not necessary to
#ifdef the thing anywhere.

-- 
Frank
