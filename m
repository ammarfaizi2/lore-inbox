Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263647AbTLOPLi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 10:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263662AbTLOPLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 10:11:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:33185 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263647AbTLOPLd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 10:11:33 -0500
Date: Mon, 15 Dec 2003 07:11:17 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: dan carpenter <error27@email.com>
cc: Ingo Molnar <mingo@elte.hu>, Petr Vandrovec <vandrove@vc.cvut.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, Roland McGrath <roland@redhat.com>
Subject: Re: [patch] Re: Problem with exiting threads under NPTL
In-Reply-To: <200312142230.20952.error27@email.com>
Message-ID: <Pine.LNX.4.58.0312150708050.1488@home.osdl.org>
References: <20031214052516.GA313@vana.vc.cvut.cz> <Pine.LNX.4.58.0312141433520.1481@home.osdl.org>
 <Pine.LNX.4.58.0312142358210.16392@earth> <200312142230.20952.error27@email.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 14 Dec 2003, dan carpenter wrote:
>
> I'm running the patch from BK and I still get unkillable zombies.

Note that zombies are normal, and yes, they are _always_ unkillable.
That's why they are called zombies ;)

The only way to get rid of a zombie is to reap it with "wait()", or just
have the parent die (at which point init will do so).

Your case looks like the parent isn't waiting for the zombie, mostly
because the parent is stopped:

> mknod09       T 00000001     0  1403      1          1420  1394 (NOTLB)

and that is easy to make happen with strace if you don't detach from the
thing you are tracing.

You can fix it up by just a "killall -CONT mknod09", and once the parent
continues it will reap the zombie.

			Linus
