Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964994AbVJDVsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbVJDVsv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 17:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbVJDVsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 17:48:51 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:21916 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S964994AbVJDVsu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 17:48:50 -0400
Message-ID: <4342F8BA.8050002@engr.sgi.com>
Date: Tue, 04 Oct 2005 14:48:42 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
Cc: Frank van Maarseveen <frankvm@frankvm.com>,
       Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc2] fix incorrect mm->hiwater_vm and mm->hiwater_rss
References: <20050921121915.GA14645@janus> <Pine.LNX.4.61.0509211515330.6114@goblin.wat.veritas.com> <43319111.1050803@engr.sgi.com> <Pine.LNX.4.61.0509211802150.8880@goblin.wat.veritas.com> <4331990A.80904@engr.sgi.com> <Pine.LNX.4.61.0509211835190.9340@goblin.wat.veritas.com> <4331A0DA.5030801@engr.sgi.com> <20050921182627.GB17272@janus> <Pine.LNX.4.61.0509211958410.10449@goblin.wat.veritas.com> <4339AED4.8030108@engr.sgi.com> <Pine.LNX.4.61.0509281337420.6830@goblin.wat.veritas.com> <433AD359.8070509@engr.sgi.com> <Pine.LNX.4.61.0510032030320.13179@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0510032030320.13179@goblin.wat.veritas.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> 
> And thanks for your patch, which I've factored in with Frank's, and come
> come up with the one below, against 2.6.14-rc2-mm2.  Which uses no CONFIG
> flag: I think we're enough out of the fast paths that it's not needed.
> 
> See comment in fs/proc/task_mmu.c for the principle.  Could maintain
> hiwater_vm straightforwardly, but I think it's easier to remember if
> we handle them both in the same way.
> 
> I did look into doing the total_vm increment and calling vm_stat_account
> in insert_vm_struct, but concluded it solved no particular problem, and
> raised some questions (where architectures, notably ia64, have special
> vmas which they may have good reason to leave out of total_vm).
> 
> I haven't cross-checked the mm_struct cacheline rearrangement yet,
> it looks plausible, but could easily turn out to straddle boundaries.
> 
> Christoph, Frank, Jay: does this patch look like it fits your needs?

I am building a kernel with your patch and am going to run some test
to compare the statistics.

Thanks,
  - jay

> 
