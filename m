Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289039AbSAVAIr>; Mon, 21 Jan 2002 19:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289029AbSAVAIh>; Mon, 21 Jan 2002 19:08:37 -0500
Received: from jalon.able.es ([212.97.163.2]:32739 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S289027AbSAVAId>;
	Mon, 21 Jan 2002 19:08:33 -0500
Date: Tue, 22 Jan 2002 01:08:21 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Hugh Dickins <hugh@veritas.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>,
        alad@hss.hns.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] free_swap_and_cache misses
Message-ID: <20020122010821.A19992@werewolf.able.es>
In-Reply-To: <Pine.LNX.4.21.0201210016040.1153-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.21.0201210016040.1153-100000@localhost.localdomain>; from hugh@veritas.com on lun, ene 21, 2002 at 01:21:29 +0100
X-Mailer: Balsa 1.3.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20020121 Hugh Dickins wrote:
>free_swap_and_cache() often misses its purpose and leaves freeable page
>in swap and cache.  Wrong in mainline 2.4 and 2.5, but looks okay in -aa
>(so don't bother to apply this if you're now merging that).
>
>Hugh
>
>--- 2.4.18-pre4/mm/swapfile.c	Sun Dec 23 10:47:32 2001
>+++ linux/mm/swapfile.c	Sun Jan 20 23:30:52 2002
>@@ -344,7 +344,7 @@
> 	if (page) {
> 		page_cache_get(page);
> 		/* Only cache user (+us), or swap space full? Free it! */
>-		if (page_count(page) == 2 || vm_swap_full()) {
>+		if (page_count(page) - !!page->buffers == 2 || vm_swap_full()) {

Don't you trust too much on precendence, people...?

-		if (page_count(page) == 2 || vm_swap_full()) {
+		if ( ((page_count(page) - !!page->buffers) == 2) || vm_swap_full() ) {

Or i'm paranoid.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.18-pre4-beo #3 SMP Wed Jan 16 02:58:41 CET 2002 i686
