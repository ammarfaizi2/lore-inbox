Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269453AbUIZAdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269453AbUIZAdt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 20:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269464AbUIZAds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 20:33:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41698 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269451AbUIZAbZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 20:31:25 -0400
Date: Sat, 25 Sep 2004 20:31:13 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@novell.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ptep_establish/establish_pte needs set_pte_atomic and all set_pte
 must be written in asm
In-Reply-To: <20040926002037.GP3309@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0409252030260.28582-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Sep 2004, Andrea Arcangeli wrote:

> But even ppc64 is wrong as far as C is concerned,

Looks fine to me.  From include/asm-ppc64/pgtable.h

static inline void set_pte(pte_t *ptep, pte_t pte)
{
        if (pte_present(*ptep)) {
                pte_clear(ptep);
                flush_tlb_pending();
        }
        *ptep = __pte(pte_val(pte)) & ~_PAGE_HPTEFLAGS;
}


-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

