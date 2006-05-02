Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWEBLTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWEBLTV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 07:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbWEBLTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 07:19:21 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:38860 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932200AbWEBLTU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 07:19:20 -0400
Date: Tue, 2 May 2006 13:24:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: blaisorblade@yahoo.it, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [patch 00/14] remap_file_pages protection support
Message-ID: <20060502112409.GA28159@elte.hu>
References: <20060430172953.409399000@zion.home.lan> <4456D5ED.2040202@yahoo.com.au> <4456D85E.6020403@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4456D85E.6020403@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> >Let's try get back to the good old days when people actually reported
> >their bugs (togther will *real* numbers) to the mailing lists. That way,
> >everybody gets to think about and discuss the problem.
> 
> Speaking of which, let's see some numbers for UML -- performance and 
> memory. I don't doubt your claims, but I (and others) would be 
> interested to see.

firstly, thanks for the review feedback!

originally i tested this feature with some minimal amount of RAM 
simulated by UML 128MB or so. That's just 32 thousand pages, but still 
the improvement was massive: context-switch times in UML were cut in 
half or more. Process-creation times improved 10-fold. With this feature 
included I accidentally (for the first time ever!) confused an UML shell 
prompt with a real shell prompt. (before that UML was so slow [even in 
"skas mode"] that you'd immediately notice it by the shell's behavior)

the 'have 1 vma instead of 32,000 vmas' thing is a really, really big 
plus. It makes UML comparable to Xen, in rough terms of basic VM design.

Now imagine a somewhat larger setup - 16 GB RAM UML instance with 4 
million vmas per UML process ... Frankly, without 
sys_remap_file_pages_prot() the UML design is still somewhat of a toy.

	Ingo
