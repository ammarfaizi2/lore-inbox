Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265852AbUBBSzr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 13:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265853AbUBBSzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 13:55:47 -0500
Received: from mail.tmr.com ([216.238.38.203]:42251 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S265852AbUBBSzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 13:55:45 -0500
Date: Mon, 2 Feb 2004 13:55:03 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Linus Torvalds <torvalds@osdl.org>
cc: "David S. Miller" <davem@redhat.com>, jakub@redhat.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CRYPTO]: Miscompiling sha256.c by gcc 3.2.3 and arch   pentium3,4
In-Reply-To: <Pine.LNX.4.58.0402011657310.2229@home.osdl.org>
Message-ID: <Pine.LNX.3.96.1040202134803.15622J-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Feb 2004, Linus Torvalds wrote:

> 
> 
> On Sun, 1 Feb 2004, Bill Davidsen wrote:
> > 
> > What didn't you like about Jakob's patch which avoids the 64 byte size 
> > penalty?
> 
> What size penalty?
> 
> The data has to be allocated somewhere, and on the stack is simply not 
> acceptable. So there can be no size penalty.

The point was that it doesn't have to be allocated somewhere unless it's
actually used, and many kernels will want the capability but in practice
won't use it. David pointed out the overhead of repeated initialize, and
that's an overpowering reason not to do runtime allocation.

> 
> Yes, the text size of the binary is slightly bigger, because a "static 
> const" ends up in the ro-section, but that's _purely_ an accounting thing. 
> It has to be somewhere, be it .text, .data or .bss. Who would ever care 
> where it is?
> 
> Having it in .ro means that there are no initialization issues, and a 
> compressed kernel compresses the zero bytes better than having init-time 
> code to initialize the array (or, worse, doing it over and over at 
> run-time).
> 
> So where does this size penalty idea come from?

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

