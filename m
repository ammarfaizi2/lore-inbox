Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVBVV6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVBVV6y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 16:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVBVV6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 16:58:54 -0500
Received: from fire.osdl.org ([65.172.181.4]:22213 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261288AbVBVV6w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 16:58:52 -0500
Date: Tue, 22 Feb 2005 13:59:25 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Jamie Lokier <jamie@shareable.org>, olof@austin.ibm.com,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [PATCH/RFC] Futex mmap_sem deadlock
In-Reply-To: <20050222134010.4c286e64.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0502221357160.2378@ppc970.osdl.org>
References: <20050222190646.GA7079@austin.ibm.com> <20050222115503.729cd17b.akpm@osdl.org>
 <20050222210752.GG22555@mail.shareable.org> <20050222134010.4c286e64.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 22 Feb 2005, Andrew Morton wrote:
> 
> However the pte can get unmapped by memory reclaim so we could still take a
> minor fault, and hit the same deadlock, yes?

You _could_ fix that by getting the pagetable spinlock, I guess. Which
check_user_page_readable() assumes you'd be holding anyway (not holding it
would appear to be a bug).

At which point you might as well just walk the tables by hand and just do 
the read that way. Of course, then you have virtual aliasing issues etc.

Insane, but possible.

		Linus
