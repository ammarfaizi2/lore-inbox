Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311710AbSEVLle>; Wed, 22 May 2002 07:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311871AbSEVLld>; Wed, 22 May 2002 07:41:33 -0400
Received: from pizda.ninka.net ([216.101.162.242]:29141 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S311710AbSEVLlc>;
	Wed, 22 May 2002 07:41:32 -0400
Date: Wed, 22 May 2002 04:27:23 -0700 (PDT)
Message-Id: <20020522.042723.56277072.davem@redhat.com>
To: rmk@arm.linux.org.uk
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.5.17
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020522121929.A16934@flint.arm.linux.org.uk>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Russell King <rmk@arm.linux.org.uk>
   Date: Wed, 22 May 2002 12:19:29 +0100

   So we have 3 different functions, 2 different orders of gather_mmu
   and cache handling, and one with no cache handling what so ever.
   
   I think we have two options - either leave the cache handling up to
   tlb_start_vma() (in which case, flush_cache_range and flush_cache_mm
   are redundant and should be removed) or let it be up to the caller
   of tlb_gather_mmu to call the right cache handling function.
   
We're in very much agreement with you, that is why we are
still hashing out how to make this thing as optimal as
possible.

The idea currently is that the tlb_vma_{start,end}() handle
cache and tlb flush respectively.

Ignore the exit_mmap() case, it will be optimized to shreds :-)
