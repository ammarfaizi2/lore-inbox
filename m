Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264054AbTF3Hgc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 03:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263918AbTF3Hgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 03:36:31 -0400
Received: from dp.samba.org ([66.70.73.150]:11231 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263777AbTF3Hf2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 03:35:28 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix for kallsyms module symbol resolution problem 
In-reply-to: Your message of "29 Jun 2003 22:13:08 EST."
             <1056942790.10904.324.camel@mulgrave> 
Date: Mon, 30 Jun 2003 16:17:15 +1000
Message-Id: <20030630074948.8F43D2C0A7@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1056942790.10904.324.camel@mulgrave> you write:
> On Sun, 2003-06-29 at 21:06, Rusty Russell wrote:
> > Please test, because that's only one problem.
> > 
> > The other is that the module_text_address() returns true if the value
> > is within the module, *not* just if it's within a function.  So you
> > can get some noise there, too, on archs which don't do real
> > backtracing.
> 
> Well, the fix is pretty cast iron in that it will print out the closest
> symbol with a non null name (which has got to be better than printing an
> empty string).  The routine length may still be wrong since the next
> closest symbol may still be null.

Yeah, but I was trying to get you to do more work.  And if the names
resulting are useless anyway, why apply the patch?

> Perhaps there should be a per-arch hook for purging the symbol tables of
> irrelevant symbols before we do kallsyms lookups in it?

I think you can do it easily in module_finalize... or if we were
ambitious we'd extract only the function symbols rather than keeping
the whole strtab and symtab.

Cheers!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
