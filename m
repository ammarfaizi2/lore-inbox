Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965041AbVI0SlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbVI0SlM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 14:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965042AbVI0SlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 14:41:12 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:24536 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S965041AbVI0SlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 14:41:11 -0400
Date: Tue, 27 Sep 2005 15:32:19 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][Fix] Fix Bug #4959 (take 2)
Message-ID: <20050927133218.GB9484@openzaurus.ucw.cz>
References: <200509241936.12214.rjw@sisk.pl> <200509271007.03865.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509271007.03865.rjw@sisk.pl>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I do not really like new exports from swsusp.c, but I'm afraid
there's no way around.

> The following patch fixes Bug #4959.  For this purpose it creates temporary
> page translation tables including the kernel mapping (reused) and the direct
> mapping (created from scratch) and makes swsusp switch to these tables
> right before the image is restored.

Why do you need *two* mappings? Should not just kernel mapping be enough?

> NOTES:
> (1) I'm quite sure that to fix the problem we need to use temporary page
> translation tables that won't be modified in the process of copying the image.
> (2) These page translation tables have to be present in memory before the
> image is copied, so there are two possible ways in which they can be created:
> 	(a) in the startup kernel code that is executed before calling swsusp
> 	on resume, in which case they have to be marked with PG_nosave,
> 	(b) in swsusp, after the image has been loaded from disk (to set up
> 	the tables we need to know which pages will be overwritten while
> 	copying the image).
> However, (a) is tricky, because it will only work if the tables are always located
> at the same physical addresses, which I think would be quite difficult to achieve.

Why? Reserve ten pages for them... static char resume_page_tables[10*PAGE_SIZE] does not
sound that bad.

> Moreover, such a code would have to be executed on every boot and the
> temporary page tables would always be present in memory.

Yep, but I do not see that as a big problem.


-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

