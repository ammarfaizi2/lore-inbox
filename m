Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbTJIQdx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 12:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbTJIQdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 12:33:53 -0400
Received: from [80.88.36.193] ([80.88.36.193]:41635 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261743AbTJIQdv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 12:33:51 -0400
Date: Thu, 9 Oct 2003 18:33:43 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Paul Mundt <lethal@linux-sh.org>
cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net/sunrpc/clnt.c compile fix
In-Reply-To: <20031009161350.GA9170@linux-sh.org>
Message-ID: <Pine.GSO.4.21.0310091829220.7430-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Oct 2003, Paul Mundt wrote:
> Not sure if anyone has submitted this already, but as the subject implies,
> net/sunrpc/clnt.c does not compile in either stock test7 or in current BK:
> 
>   CC      net/sunrpc/clnt.o
>   net/sunrpc/clnt.c: In function `call_verify':
>   net/sunrpc/clnt.c:965: structure has no member named `tk_pid'
>   net/sunrpc/clnt.c:970: structure has no member named `tk_pid'
>   net/sunrpc/clnt.c:976: structure has no member named `tk_pid'
>   make[1]: *** [net/sunrpc/clnt.o] Error 1
>   make: *** [net/sunrpc/clnt.o] Error 2
> 
> This is due to the fact that tk_pid is protected by RPC_DEBUG. Wrapping
> through dprintk() fixes this.

Since it compiled in my m68k-build-all-that-builds kernel, I decided to jump
into this.

Apparently RPC_DEBUG is set if CONFIG_SYSCTL is defined
(<linux/sunrpc/debug.h>), so it builds or not depending on CONFIG_SYSCTL.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

