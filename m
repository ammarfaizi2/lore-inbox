Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265950AbUAUFaN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 00:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265951AbUAUFaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 00:30:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:28879 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265950AbUAUFaK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 00:30:10 -0500
Date: Tue, 20 Jan 2004 21:30:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: More cleanups for swsusp
Message-Id: <20040120213037.66c9d5a0.akpm@osdl.org>
In-Reply-To: <20040121051855.B0C282C0A7@lists.samba.org>
References: <20040120225219.GA19190@elf.ucw.cz>
	<20040121051855.B0C282C0A7@lists.samba.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> wrote:
>
> In message <20040120225219.GA19190@elf.ucw.cz> you write:
>  > -	if (fill_suspend_header(&cur->sh))
>  > -		panic("\nOut of memory while writing header");
>  > +	BUG_ON (fill_suspend_header(&cur->sh));
> 
> ...
>  3) BUG_ON(complex condition expression) is much less clear than:
> 
>  	if (complex condition expression)
>  		BUG();

Worse.  If some smarty goes and makes BUG_ON a no-op (for space reasons),
it will break software suspend.  We should ensure that the expression which
is supplied to BUG_ON() never has side-effects for this reason.

I'll drop that chunk.

