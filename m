Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261709AbULUAa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbULUAa7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 19:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbULUAa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 19:30:58 -0500
Received: from mail.dif.dk ([193.138.115.101]:9100 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261709AbULUAao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 19:30:44 -0500
Date: Tue, 21 Dec 2004 01:41:24 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kill access_ok() call from copy_siginfo_to_user() that
 we might as well avoid.
In-Reply-To: <Pine.LNX.4.58.0412201617050.4112@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.61.0412210139050.3581@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0412210025100.3581@dragon.hygekrogen.localhost>
 <Pine.LNX.4.58.0412201617050.4112@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2004, Linus Torvalds wrote:

> 
> 
> On Tue, 21 Dec 2004, Jesper Juhl wrote:
> > 
> > In kernel/signal.c::copy_siginfo_to_user() we are calling access_ok()  
> > unconditionally. As I see it there's no need for this since we might as
> > well just call copy_to_user() instead of __copy_to_user() later on and
> > then only get the overhead of the access_ok() check (inside
> > copy_to_user())
> 
> No, the "access_ok()" is to protect the other side too, ie all the 
> "__put_user()" calls.
> 
> If you remove the access_ok(), you need to also change all the 
> __put_user() calls to "put_user()". And then the end result will be much 
> worse code than it is right now.
> 
Hmm, right, now that you point it out that's glaringly obvious - that 
slipped by me - sorry for the noice.

-- 
Jesper Juhl


