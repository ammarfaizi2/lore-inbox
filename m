Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131483AbRCQMdB>; Sat, 17 Mar 2001 07:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131448AbRCQMcw>; Sat, 17 Mar 2001 07:32:52 -0500
Received: from schmee.sfgoth.com ([63.205.85.133]:55044 "EHLO
	schmee.sfgoth.com") by vger.kernel.org with ESMTP
	id <S131483AbRCQMcg>; Sat, 17 Mar 2001 07:32:36 -0500
Date: Sat, 17 Mar 2001 04:31:54 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Junfeng Yang <yjf@stanford.edu>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu
Subject: Re: [CHECKER] 120 potential dereference to invalid pointers errors for linux 2.4.1
Message-ID: <20010317043154.B67406@sfgoth.com>
In-Reply-To: <Pine.GSO.4.31.0103170126540.14147-100000@elaine24.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.GSO.4.31.0103170126540.14147-100000@elaine24.Stanford.EDU>; from yjf@stanford.edu on Sat, Mar 17, 2001 at 01:30:54AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Junfeng Yang wrote:
> [BUG] fore200e_kmalloc can return NULL
> /u2/acc/oses/linux/2.4.1/drivers/atm/fore200e.c:2032:fore200e_get_esi: ERROR:NULL:2020:2032: Using unknown ptr "prom" illegally! set by 'fore200e_kmalloc':2020

I don't see the bug - there is an explicit "if(!prom) return -ENOMEM;" after
the allocation.  It looks fine to me.

> [BUG] break the while loop, but not the for loop
> /u2/acc/oses/linux/2.4.1/drivers/atm/zatm.c:1817:zatm_detect: ERROR:NULL:1804:1817: Using NULL ptr "zatm_dev" illegally! set by 'kmalloc':1804

Ah, good catch.  It'd be almost impossible to actually trigger this since
you'd need multiple cards of different types (all of which are rare) and
end up with really bad allocation luck, but it is technically a bug.
Really line 1829 should be "if(!zatm_dev) return devs;"

> [BUG] at line 1796
> /u2/acc/oses/linux/2.4.1/net/atm/lec.c:1799:lec_arp_update: ERROR:NULL:1798:1799: Using unknown ptr "entry" illegally! set by 'make_entry':1798

Yep, all three of the catches in lec.c are real bugs - great work as always.

-Mitch
