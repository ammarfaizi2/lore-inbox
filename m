Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbULUASW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbULUASW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 19:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbULUASW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 19:18:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:10970 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261683AbULUAST (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 19:18:19 -0500
Date: Mon, 20 Dec 2004 16:18:15 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kill access_ok() call from copy_siginfo_to_user() that
 we might as well avoid.
In-Reply-To: <Pine.LNX.4.61.0412210025100.3581@dragon.hygekrogen.localhost>
Message-ID: <Pine.LNX.4.58.0412201617050.4112@ppc970.osdl.org>
References: <Pine.LNX.4.61.0412210025100.3581@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Dec 2004, Jesper Juhl wrote:
> 
> In kernel/signal.c::copy_siginfo_to_user() we are calling access_ok()  
> unconditionally. As I see it there's no need for this since we might as
> well just call copy_to_user() instead of __copy_to_user() later on and
> then only get the overhead of the access_ok() check (inside
> copy_to_user())

No, the "access_ok()" is to protect the other side too, ie all the 
"__put_user()" calls.

If you remove the access_ok(), you need to also change all the 
__put_user() calls to "put_user()". And then the end result will be much 
worse code than it is right now.

		Linus
