Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1766646AbWJUS0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766646AbWJUS0q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 14:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423368AbWJUS0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 14:26:46 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:59862 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1422691AbWJUS0p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 14:26:45 -0400
Date: Sat, 21 Oct 2006 19:27:01 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au, akpm@osdl.org,
       linux-kernel@vger.kernel.org, anemo@mba.ocn.ne.jp,
       linux-arch@vger.kernel.org, schwidefsky@de.ibm.com,
       James.Bottomley@SteelEye.com
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
Message-ID: <20061021182701.GA22194@linux-mips.org>
References: <Pine.LNX.4.64.0610201625190.3962@g5.osdl.org> <20061021000609.GA32701@linux-mips.org> <Pine.LNX.4.64.0610201733490.3962@g5.osdl.org> <20061020.191134.63996591.davem@davemloft.net> <Pine.LNX.4.64.0610201934170.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610201934170.3962@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 07:37:24PM -0700, Linus Torvalds wrote:

> Well, if you can re-create the performance numbers (Ralf - can you send 
> the full series with the final "remove the now unnecessary flush" to 
> Davem?), that will make deciding things easier, I think.
> 
> I suspect sparc, mips and arm are the main architectures where virtually 
> indexed caching really matters enough for this to be an issue at all.

What I was using for my fork benchmark was basically the series as posted
in this thread + the quick hack patch below.

I'll dig up some numbers for the posted patchset and will send them later.

   Ralf

diff --git a/kernel/fork.c b/kernel/fork.c
index 29ebb30..c83d226 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -202,7 +202,6 @@ static inline int dup_mmap(struct mm_str
 	struct mempolicy *pol;
 
 	down_write(&oldmm->mmap_sem);
-	flush_cache_mm(oldmm);
 	/*
 	 * Not linked in yet - no deadlock potential:
 	 */
