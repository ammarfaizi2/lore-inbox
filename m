Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264378AbTKUQF3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 11:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264379AbTKUQF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 11:05:29 -0500
Received: from holomorphy.com ([199.26.172.102]:30130 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264378AbTKUQFY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 11:05:24 -0500
Date: Fri, 21 Nov 2003 08:05:18 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Tim Kelsey <accent0@mail2.midnet.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9-mm4 ans ALSA
Message-ID: <20031121160518.GS22764@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Tim Kelsey <accent0@mail2.midnet.co.uk>,
	linux-kernel@vger.kernel.org
References: <20031121155833.1ab1f5b6.accent0@mail2.midnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031121155833.1ab1f5b6.accent0@mail2.midnet.co.uk>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 21, 2003 at 03:58:33PM +0000, Tim Kelsey wrote:
> with mm4 the aplay program exits with a seg fault and the xmms alsa 0.9 output plugin hangs, also any ps -aux or kill/killall commands hang with no output and dont answer a ctrl+c after trying to play somthing via xmms alsa output
> 
> in 2.6.0-test9 vanilla all the alsa stuff works fine and i think in 2.6.0-t9-mm3 (ill confirm if it does) but in 2.6.0-t9-mm4 it seems to be broken at least for my card. OSS emulation works fine tho with 2.6.0-t9-mm4 
> 
> if any more information would be helpfull to any one please let me know whats needed.


diff -prauN mm4-2.6.0-test9-1/mm/memory.c mm4-2.6.0-test9-default-2/mm/memory.c
--- mm4-2.6.0-test9-1/mm/memory.c	2003-11-19 00:07:15.000000000 -0800
+++ mm4-2.6.0-test9-default-2/mm/memory.c	2003-11-19 18:08:49.000000000 -0800
@@ -1424,7 +1424,7 @@ do_no_page(struct mm_struct *mm, struct 
 	pte_t entry;
 	struct pte_chain *pte_chain;
 	int sequence = 0;
-	int ret;
+	int ret = VM_FAULT_MINOR;
 
 	if (!vma->vm_ops || !vma->vm_ops->nopage)
 		return do_anonymous_page(mm, vma, page_table,
