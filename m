Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315471AbSEBXwE>; Thu, 2 May 2002 19:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315474AbSEBXwD>; Thu, 2 May 2002 19:52:03 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9744 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315471AbSEBXwD>; Thu, 2 May 2002 19:52:03 -0400
Date: Thu, 2 May 2002 16:50:41 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roman Zippel <zippel@linux-m68k.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.12: remove VALID_PAGE
In-Reply-To: <Pine.LNX.4.21.0205022231180.23113-100000@serv>
Message-ID: <Pine.LNX.4.33.0205021648330.26798-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 2 May 2002, Roman Zippel wrote:
> 
> Ok, here is a new patch and it does indeed generate better code. :)
> virt_to_valid_page() also became virt_addr_valid().

You're going to hate me, but I'm going to ask you to do one more thing: 
make "mk_pte_phys()" go away, and replace it with "pfn_pte(pfn,prot)". 
Because logically it _is_ the reverse of "pte_pfn()", and that also means 
that the HIGHMEM stuff on x86 would get cleaned up (we can generate 
highmem pages without having a 64-bit physical address, we just have the 
same old 32-bit PFN).

Pretty please?

		Linus

