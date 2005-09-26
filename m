Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbVIZHZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbVIZHZf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 03:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbVIZHZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 03:25:35 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:9389 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932425AbVIZHZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 03:25:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Subject:From:To:Cc:In-Reply-To:References:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=39WLGwEzSnjlKEcsLO7izDi6qwF0BTehVMV1JAm/wESOlcYpqrVf3dFOwHx6sTUZUngFwsoUUvCnyfYQhwZimqQaOdLliruHVmMCrH/NKbuonQvrlxbNZU1Gl0t7z5YNXJqUk1MNHudSyRDVml0Kc0YwlP5apq5eyUyDWwBUSGA=  ;
Subject: Re: [PATCH 17/21] mm: batch updating mm_counters
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0509251707171.3490@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
	 <Pine.LNX.4.61.0509251707171.3490@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Mon, 26 Sep 2005 17:25:03 +1000
Message-Id: <1127719503.5101.38.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-09-25 at 17:08 +0100, Hugh Dickins wrote:
> tlb_finish_mmu used to batch zap_pte_range's update of mm rss, which may
> be worthwhile if the mm is contended, and would reduce atomic operations
> if the counts were atomic.  Let zap_pte_range now batch its updates to
> file_rss and anon_rss, per page-table in case we drop the lock outside;
> and copy_pte_range batch them too.

Good idea.

>  			progress++;
>  			continue;
>  		}
> -		copy_one_pte(dst_mm, src_mm, dst_pte, src_pte, vm_flags, addr);
> +		anon = copy_one_pte(dst_mm, src_mm, dst_pte, src_pte,
> +							vm_flags, addr);
> +		rss[anon]++;

How about passing rss[2] to copy_one_pte, and have that
increment the correct rss value accordingly? Not that
you may consider that any nicer than what you have here.

Nick

-- 
SUSE Labs, Novell Inc.



Send instant messages to your online friends http://au.messenger.yahoo.com 
