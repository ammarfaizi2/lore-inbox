Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964996AbWFZBt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbWFZBt1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 21:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbWFZBt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 21:49:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33164 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964996AbWFZBt1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 21:49:27 -0400
Date: Sun, 25 Jun 2006 18:49:17 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Shaohua Li <shaohua.li@intel.com>
cc: Daniel Ritz <daniel.ritz-ml@swissonline.ch>, Pavel Machek <pavel@ucw.cz>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] swsuspend breakage in 2.6.17-git
In-Reply-To: <1151285213.21189.28.camel@sli10-desk.sh.intel.com>
Message-ID: <Pine.LNX.4.64.0606251845560.3747@g5.osdl.org>
References: <200606251605.10956.daniel.ritz-ml@swissonline.ch> 
 <Pine.LNX.4.64.0606250943580.3747@g5.osdl.org> <1151285213.21189.28.camel@sli10-desk.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 26 Jun 2006, Shaohua Li wrote:
>
> Below is from ACPI spec 3.0 (p405). From my understanding, OS should
> save/restore NVS memory ?

Ok, that's what it looks like.

However, the patches clearly don't actually work right now. 

I suspect part of the problem is that Linux will normally create the 
"struct page *" array (and page tables) only for the pages marked as being 
usable RAM, so when you start to try to save specialty pages, we won't 
have page tables set up for them, nor will we have any "struct page" for 
them either.

Also, clearly this also breaks other architectures.

So I'm reverting them from my tree for now, I just have to test that I got 
it right first (there were some partial dependencies on the patches as 
follow-on cleanups).

		Linus
