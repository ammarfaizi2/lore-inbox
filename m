Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316768AbSEUXHH>; Tue, 21 May 2002 19:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316769AbSEUXHG>; Tue, 21 May 2002 19:07:06 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:9363 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S316768AbSEUXHF>;
	Tue, 21 May 2002 19:07:05 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15594.53956.275011.958879@argo.ozlabs.ibm.com>
Date: Wed, 22 May 2002 09:05:40 +1000 (EST)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Make 2.5.17 TLB even more friendlier
In-Reply-To: <Pine.LNX.4.33.0205211139440.3073-100000@penguin.transmeta.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> Sp why don't you just make "tlb_remove_pte_entry()" look at your bit, and 
> then if that bit is set you try to remove the entry from the hash chains 
> at that point?

Simply the desire to batch up the hash table searches for efficiency,
particularly on SMP where we have to take a spinlock before touching
the MMU hash table.  This will be an even bigger win on ppc64 on
partitioned machines where we have to call the hypervisor to make
changes to the MMU hash table.

I'm thinking now that I would be better off doing the batching by
storing a list of virtual addresses needing flushing in the
mmu_gather_t, instead of relying on getting at the special bits in the
PTEs at some time after the tlb_remove_tlb_entry call.

Regards,
Paul.
