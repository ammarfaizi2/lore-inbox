Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbULTC3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbULTC3A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 21:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbULTC27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 21:28:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:8090 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261396AbULTC2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 21:28:43 -0500
Date: Sun, 19 Dec 2004 18:28:36 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Zwane Mwaikambo <zwane@fsmlabs.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Boottime allocated GDTs and doublefault handler
In-Reply-To: <Pine.LNX.4.61.0412191730330.18272@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.58.0412191824280.4112@ppc970.osdl.org>
References: <Pine.LNX.4.61.0412191730330.18272@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 19 Dec 2004, Zwane Mwaikambo wrote:
>
> GDTs on SMP tend to be above the current ptr_ok limits since they are 
> boottime allocated. How does the following new arbitrary limit look?

Ugh. That "ptr_ok()" macro was a total hack to get it working in the first 
place, we really shouldn't do that.

How about just making it a small function that actually walks the page 
tables (looking at %cr3 to find the base - at doublefault time it's not 
sane to try to depend on much anything else than raw register/memory 
state)?

It's not much of an issue for the gdt/tss checks, since those are very 
unlikely to be wrong anyway, but if we want to make the code print out any 
other information (like the old stack contents, and process info), then a 
"ptr_ok()" thing that actually is dependable would be a lot more useful..

Hint hint..

		Linus
