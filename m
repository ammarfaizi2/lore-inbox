Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbVB0INM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVB0INM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 03:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbVB0INM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 03:13:12 -0500
Received: from witte.sonytel.be ([80.88.33.193]:16267 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261367AbVB0IMi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 03:12:38 -0500
Date: Sun, 27 Feb 2005 09:12:25 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: Brian Gerst <bgerst@didntduck.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vsprintf.c cleanups 
In-Reply-To: <200502251337.j1PDbVbo005932@laptop11.inf.utfsm.cl>
Message-ID: <Pine.LNX.4.62.0502270910100.3143@numbat.sonytel.be>
References: <200502251337.j1PDbVbo005932@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Feb 2005, Horst von Brand wrote:
> Brian Gerst <bgerst@didntduck.org> said:
> > Horst von Brand wrote:
> > > Brian Gerst <bgerst@didntduck.org> said:
> > > 
> > >>- Make sprintf call vsnprintf directly
> > >>- use INT_MAX for sprintf and vsprintf
> 
> > > This is the size limit on what is written. 4GiB sounds a bit extreme...
> 
> > Sprintf has no limit, which is why it's generally bad to use it.  I just 
> > replaced an open coded ((~0U)>>1) value with the equivalent INT_MAX.
> 
> Which is the same as "no limit" in my book. Either you know a limit (in
> which case vsprintf() is OK) or you don't (in which case vsnprintf() is
> just obfuscation).

Indeed. So the only place that is allowed to pass the `no limit' value to
snprintf() is in the sprintf() wrapper that calls snprintf().

Calls to sprintf() must not be converted to snprintf(..., `no limit', ...), so
it's easier to find them when doing buffer overflow audits.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
