Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315419AbSEUSms>; Tue, 21 May 2002 14:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315420AbSEUSmr>; Tue, 21 May 2002 14:42:47 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59911 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315419AbSEUSmr>; Tue, 21 May 2002 14:42:47 -0400
Date: Tue, 21 May 2002 11:42:36 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Paul Mackerras <paulus@samba.org>
cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Make 2.5.17 TLB even more friendlier
In-Reply-To: <15594.17227.311046.740703@argo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.33.0205211139440.3073-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 21 May 2002, Paul Mackerras wrote:
> 
> I have a bit in the PTE that tells me if there is an MMU hash table
> entry for the virtual address represented by the PTE.

This is exactly why 2.5.17 has the "tlb_remove_pte_entry()", and why it is 
passed down the pte that we just cleared out - so that architectures can 
hide details like this in the page tables (the other use is to hide things 
like "iTBL vs dTLB" etc).

Sp why don't you just make "tlb_remove_pte_entry()" look at your bit, and 
then if that bit is set you try to remove the entry from the hash chains 
at that point?

You _have_ to do it this way, in fact, since reserved pages and other 
"VM-invisible" pages aren't even passed down to "tlb_remove_page()" 
(because they have no freeing logic, and they have no impact on RSS).

		Linus

