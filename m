Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265830AbTAJSbF>; Fri, 10 Jan 2003 13:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265628AbTAJSad>; Fri, 10 Jan 2003 13:30:33 -0500
Received: from [193.158.237.250] ([193.158.237.250]:10633 "EHLO
	mail.intergenia.de") by vger.kernel.org with ESMTP
	id <S265677AbTAJS3A>; Fri, 10 Jan 2003 13:29:00 -0500
Date: Fri, 10 Jan 2003 19:37:40 +0100
Message-Id: <200301101837.h0AIbeO05540@mail.intergenia.de>
To: Your.message.of"09 Jan 2003 15:20:41 +0900."@mail.intergenia.de
From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: exception tables in 2.5.55  [rescued]
CC: linux-kernel@vger.kernel.org, Greg Ungerer <gerg@snapgear.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

