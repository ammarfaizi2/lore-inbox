Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269451AbUIZAh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269451AbUIZAh6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 20:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269464AbUIZAh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 20:37:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47844 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269470AbUIZAhi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 20:37:38 -0400
Date: Sat, 25 Sep 2004 20:37:31 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@novell.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: ptep_establish/establish_pte needs set_pte_atomic and all set_pte
 must be written in asm
In-Reply-To: <20040926003120.GQ3309@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0409252036050.28582-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Sep 2004, Andrea Arcangeli wrote:

> I'm not very fond on software TLBs and their internal locking, but
> exactly because of what you said ("they grab the page_table_lock."), how
> can the software TLB ever care about the flush_tlb in between
> ptep_get_and_clear and set_pte?

It only grabs the page_table_lock if it finds pte_none(pte),
otherwise it'll run without any of the generic VM locks.

> How can a software TLB care about a tlb flush in between two pieces of
> code that are anyways under the page_table_lock?

Thing is, it's not under page_table_lock ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

