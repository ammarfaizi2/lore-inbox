Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129034AbQKCPGQ>; Fri, 3 Nov 2000 10:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129129AbQKCPGH>; Fri, 3 Nov 2000 10:06:07 -0500
Received: from pizda.ninka.net ([216.101.162.242]:15267 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129034AbQKCPF7>;
	Fri, 3 Nov 2000 10:05:59 -0500
Date: Fri, 3 Nov 2000 06:51:05 -0800
Message-Id: <200011031451.GAA10924@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: tytso@MIT.EDU
CC: davej@suse.de, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
In-Reply-To: <200011031456.JAA21492@tsx-prime.MIT.EDU> (tytso@MIT.EDU)
Subject: Re: BUG FIX?: mm->rss is modified in some places without holding the  page_table_lock
In-Reply-To: <200011031456.JAA21492@tsx-prime.MIT.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Fri, 3 Nov 2000 09:56:15 -0500
   From: "Theodore Y. Ts'o" <tytso@MIT.EDU>

   Are you saying that the original bug report may not actually be a
   problem?  Is ms->rss actually protected in _all_ of the right
   places, but people got confused because of the syntactic sugar?

I don't know if all of them are ok, most are.

Someone would need to do the analysis.  David's patch could be used as
a good starting point.  A quick glance at mm/memory.c shows these
spots need to be fixed:

1) End of zap_page_range()
2) Middle of do_swap_page
3) do_anonymous_page
4) do_no_page

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
