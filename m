Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267999AbUIJEEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267999AbUIJEEI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 00:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268000AbUIJEEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 00:04:08 -0400
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:32935 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S267999AbUIJED5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 00:03:57 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16705.9974.143071.81625@wombat.chubb.wattle.id.au>
Date: Fri, 10 Sep 2004 14:00:54 +1000
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: having problems with remap_page_range() and virt_to_phys()
In-Reply-To: <972562878@toto.iv>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Chris" == Chris Friesen <cfriesen@nortelnetworks.com> writes:

Chris> I'm trying to allocate a page of in-kernel memory and make it
Chris> accessable to userspace and to late asm code where we don't
Chris> have virtual memory enabled.

Chris> I'm running code essentially equivalent to the following, where
Chris> "map_addr" is a virtual address passed in by userspace, and
Chris> "vma" is the appropriate one for that address:


Chris> struct page *pg = alloc_page(GFP_KERNEL); void *virt =
Chris> page_address(pg); unsigned long phys = virt_to_phys(virt)
Chris> remap_page_range(vma, map_addr, phys, PAGE_SIZE,
Chris> vma->vm_page_prot)


Chris> The problem that I'm having is that after the call to
Chris> remap_page_range, the result of

Chris> virt_to_phys(map_addr)

Did you set the VM_RESERVED bit on the VMA?  If you didn't then the remap
page range will allocate a new zero-filled page for you.


-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
