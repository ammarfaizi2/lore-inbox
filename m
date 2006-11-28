Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756297AbWK1W2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756297AbWK1W2a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 17:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756314AbWK1W2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 17:28:30 -0500
Received: from smtp.osdl.org ([65.172.181.25]:48046 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1756297AbWK1W23 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 17:28:29 -0500
Date: Tue, 28 Nov 2006 14:27:51 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       trivial@kernel.org
Subject: Re: [PATCH] Don't compare unsigned variable for <0 in sys_prctl()
In-Reply-To: <200611282317.14020.jesper.juhl@gmail.com>
Message-ID: <Pine.LNX.4.64.0611281425220.4244@woody.osdl.org>
References: <200611282317.14020.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 28 Nov 2006, Jesper Juhl wrote:
> 
> In kernel/sys.c::sys_prctl() the argument named 'arg2' is very clearly 
> of type 'unsigned long', and when compiling with "gcc -W" gcc also warns :
>   kernel/sys.c:2089: warning: comparison of unsigned expression < 0 is always false
> 
> So this patch removes the test of "arg2 < 0".

No, we don't do this. 

This is why we don't compile with "-W". Gcc is crap.

The fact is, if it's unsigned, it's not something that the programmer 
should have to care about. We should write our code to be readable and 
obviously safe, and that means that

	if (x < 0 || x > MAX) 
		return -ERROR;

is the _right_ way to do things, without having to carry stupid context 
around in our heads.

If the compiler (whose _job_ it is to carry all that context and use it to 
generate good code) notices that the fact that "x" is unsignes means that 
one of the tests is unnecessary, that does not make it wrong.

Gcc warns for a lot of wrong things. This is one of them. 

Friends don't let friends use "-W".

		Linus
