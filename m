Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266075AbUFPDET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266075AbUFPDET (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 23:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266088AbUFPDBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 23:01:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:8681 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266115AbUFPCxo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 22:53:44 -0400
Date: Tue, 15 Jun 2004 19:53:28 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chris Wright <chrisw@osdl.org>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, Mika Kukkonen <mika@osdl.org>
Subject: Re: [PATCH] security_sk_free void return fixup
In-Reply-To: <20040615161646.S21045@build.pdx.osdl.net>
Message-ID: <Pine.LNX.4.58.0406151946220.4142@ppc970.osdl.org>
References: <20040615161646.S21045@build.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 Jun 2004, Chris Wright wrote:
>
>   CHECK   net/core/sock.c
> include/linux/security.h:2636:39: warning: return expression in void function
>   CC      net/core/sock.o

I'm going to remove this warning from sparse. Apparently it is valid C99, 
and somebody (I think Richard Henderson) made the excellent point that it 
allows for type-independent code where you do something like

	mytype myfunc1(xxx);

	mytype myfunc2(xxx)
	{
		...
		return myfunc1(...);
	}

and it just works regardless of what type it is. 

sparse will obviously warn about expressions with non-void types being 
returned from a void function, but the case where the expression exists 
and has the right type should be ok.

I'm not sure it's wonderful C in general, but I certainly can't claim it 
is actively offensive, and since gcc accepts it and we have these things 
in the kernel, why complain? 

		Linus
