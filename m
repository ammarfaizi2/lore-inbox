Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264716AbTAJJCh>; Fri, 10 Jan 2003 04:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264683AbTAJJBe>; Fri, 10 Jan 2003 04:01:34 -0500
Received: from dp.samba.org ([66.70.73.150]:42910 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264688AbTAJJB3>;
	Fri, 10 Jan 2003 04:01:29 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Miles Bader <miles@gnu.org>
Cc: linux-kernel@vger.kernel.org, Greg Ungerer <gerg@snapgear.com>,
       David McCullough <davidm@snapgear.com>, torvalds@transmeta.com
Subject: Re: exception tables in 2.5.55 
In-reply-to: Your message of "09 Jan 2003 15:20:41 +0900."
             <buo1y3msv2e.fsf@mcspd15.ucom.lsi.nec.co.jp> 
Date: Fri, 10 Jan 2003 19:30:06 +1100
Message-Id: <20030110091012.290C02C3CE@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <buo1y3msv2e.fsf@mcspd15.ucom.lsi.nec.co.jp> you write:
> I'm building for the v850, which has no MMU.
> 
> Starting with 2.5.55, I'm getting link errors like:
> 
>   kernel/extable.c:29: undefined reference to `search_extable'
> 
> I didn't have to worry about this with earlier kernels, and it looks
> like what happened is that previously arch-specific code was
> consolidated into the generic kernel.

Yes.  This patch (like most of the module stuff) was written long
before the mmuless archs were merged.  It didn't occur to me to look
through all the archs again.

> As far as I can see, the purpose of exception tables is to deal with
> unexpected memory access traps and on the v850, this basically can't
> happen (there's no MMU, and no way I know of to detect non-existant
> memory).  So I'd like to make the generic exception handling stuff
> optional.

You can now make kernel/extable.o depend on this configuration option
(whatever you decide it should be).

And surround kernel/module.c's search_module_extables with the same
option.

It's trivial, just CC: me when you send to Linus, and I'll re-xmit if
he drops it.

> However, I'm not sure the best way to do this -- I could try to make it
> dependent on CONFIG_MMU, but are there non-MMU processors that _can_
> usefully use exception tables (in which case perhaps there should just
> be a separate CONFIG_EXTABLES or something)?
> 
> [Oh, and also, please tell me if I'm mistaken about the purpose of
> these tables and really _should_ just implement them.]

No, they're for copy_to/from_user and friends.  If your arch doesn't
rely on exception handling to trap wierd accesses, you can turn this
off.

Hope that helps,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
