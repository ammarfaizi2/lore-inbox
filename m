Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbTLNUpl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 15:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbTLNUpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 15:45:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:31918 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262458AbTLNUpk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 15:45:40 -0500
Date: Sun, 14 Dec 2003 12:45:34 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Petr Vandrovec <vandrove@vc.cvut.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, Roland McGrath <roland@redhat.com>
Subject: Re: [patch] Re: Problem with exiting threads under NPTL
In-Reply-To: <Pine.LNX.4.58.0312141228170.1478@home.osdl.org>
Message-ID: <Pine.LNX.4.58.0312141238460.1478@home.osdl.org>
References: <20031214052516.GA313@vana.vc.cvut.cz> <Pine.LNX.4.58.0312142032310.9900@earth>
 <Pine.LNX.4.58.0312141228170.1478@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 14 Dec 2003, Linus Torvalds wrote:
>
> That code looks fragile as hell. I think you fixed a bug and it might be
> the absolutely proper fix, but I'd be happier about it if it was more
> obvious what the rules are and _why_ that is the only case that matters..

Btw, on another note: to avoid the appearance of recursion, I'd prefer a

	p = leader;
	goto top;

instead of a "release_task(leader);".

I realize that the recursion should be just one deep (the leader of the
leader is itself, and that will stop the thing from going further), but it
looks trivial to avoid it, and any automated source checking tool would be
confused by the apparent recursion.

		Linus
