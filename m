Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbTFTCs0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 22:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbTFTCs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 22:48:26 -0400
Received: from dp.samba.org ([66.70.73.150]:10201 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262174AbTFTCsZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 22:48:25 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: torvalds@transmeta.com, akpm@zip.com.au, linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [PATCH] Make gcc3.3 Eliminate Unused Static Functions 
In-reply-to: Your message of "Thu, 19 Jun 2003 14:17:33 +0200."
             <20030619121732.GQ29247@fs.tum.de> 
Date: Fri, 20 Jun 2003 12:28:36 +1000
Message-Id: <20030620030225.8EC742C053@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030619121732.GQ29247@fs.tum.de> you write:
> On Fri, Jun 13, 2003 at 11:03:43AM +1000, Rusty Russell wrote:
> > Argh, bogus line pasted into Makefile turned up in patch.
> > 
> > This should be better...
> >...
> > +# Needs gcc 3.3 or above to understand max-inline-insns-auto.
> > +INLINE_OPTS	:= $(shell $(CC) -o /non/existent/file -c --param max-i
nline-insns-auto=0 -xc /dev/null 2>&1 | grep /non/existent/file >/dev/null && e
cho -finline-functions --param max-inline-insns-auto=0)
> >...
> 
> You have to add a -Wno-unused-function or you'll get a warning for every
> eliminated function.

No, suppressing warnings like that would be bad.  Instead, you write
functions like this:

	#ifdef CONFIG_FOO
	extern int register_foo(foo_fn myfunction);
	#else
	static inline int register_foo(foo_fn myfunction)
	{
		return 0;
	}
	#endif /* CONFIG_FOO */

That way, there's no unused warning, but gcc knows enough to discard
the function.

Hope that clarifies!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
