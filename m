Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264376AbTF3N4i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 09:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264304AbTF3N4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 09:56:38 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:57607 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264754AbTF3N4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 09:56:36 -0400
Subject: Re: [PATCH] fix for kallsyms module symbol resolution problem
From: James Bottomley <James.Bottomley@steeleye.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030630074948.8F43D2C0A7@lists.samba.org>
References: <20030630074948.8F43D2C0A7@lists.samba.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 30 Jun 2003 09:10:46 -0500
Message-Id: <1056982249.2069.25.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-30 at 01:17, Rusty Russell wrote:
> Yeah, but I was trying to get you to do more work.  And if the names
> resulting are useless anyway, why apply the patch?

I noticed.

However, not printing empty names makes the trace a lot more useful. 
Just doing a symbolic trace on modules on x86, I see pretty much the
correct call trace now.

But, I'll investigate and see if I can find a way of generically telling
if a particular symbol is useful or not.

> > Perhaps there should be a per-arch hook for purging the symbol tables of
> > irrelevant symbols before we do kallsyms lookups in it?
> 
> I think you can do it easily in module_finalize... or if we were
> ambitious we'd extract only the function symbols rather than keeping
> the whole strtab and symtab.

Apart from the dubious writing to a const * pointer, yes I can (it's
what I'm doing now).  There is some annoyance in that module_finalize
isn't told where the string or symbol tables are, so I have to find them
again.

James


