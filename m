Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265538AbUBBBCW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 20:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265549AbUBBBCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 20:02:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:64987 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265538AbUBBBCU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 20:02:20 -0500
Date: Sun, 1 Feb 2004 17:00:37 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Bill Davidsen <davidsen@tmr.com>
cc: "David S. Miller" <davem@redhat.com>, James Morris <jmorris@redhat.com>,
       jakub@redhat.com, dparis@w3works.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       rspchan@starhub.net.sg
Subject: Re: [CRYPTO]: Miscompiling sha256.c by gcc 3.2.3 and arch   pentium3,4
In-Reply-To: <401D6D38.3020009@tmr.com>
Message-ID: <Pine.LNX.4.58.0402011657310.2229@home.osdl.org>
References: <Xine.LNX.4.44.0401301133350.16128-100000@thoron.boston.redhat.com>
 <20040130131400.13190af5.davem@redhat.com> <401D6D38.3020009@tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 1 Feb 2004, Bill Davidsen wrote:
> 
> What didn't you like about Jakob's patch which avoids the 64 byte size 
> penalty?

What size penalty?

The data has to be allocated somewhere, and on the stack is simply not 
acceptable. So there can be no size penalty.

Yes, the text size of the binary is slightly bigger, because a "static 
const" ends up in the ro-section, but that's _purely_ an accounting thing. 
It has to be somewhere, be it .text, .data or .bss. Who would ever care 
where it is?

Having it in .ro means that there are no initialization issues, and a 
compressed kernel compresses the zero bytes better than having init-time 
code to initialize the array (or, worse, doing it over and over at 
run-time).

So where does this size penalty idea come from?

In short: "static const" is correct.

		Linus
