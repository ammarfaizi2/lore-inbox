Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261580AbSIXGMK>; Tue, 24 Sep 2002 02:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261582AbSIXGMK>; Tue, 24 Sep 2002 02:12:10 -0400
Received: from dp.samba.org ([66.70.73.150]:12450 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261580AbSIXGMI>;
	Tue, 24 Sep 2002 02:12:08 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] streq() 
In-reply-to: Your message of "Tue, 24 Sep 2002 07:40:26 +0200."
             <Pine.LNX.4.44.0209240731060.8824-100000@localhost.localdomain> 
Date: Tue, 24 Sep 2002 16:04:33 +1000
Message-Id: <20020924061722.688A32C0A6@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0209240731060.8824-100000@localhost.localdomain> you 
write:
>  - kmalloc(size, flags)/gfp(order, flags) argument ordering. A few months
>    ago i wasted two days on such a bug - since 'size' was very small
>    usually, it never showed up that the allocated buffer was short, until
>    some rare load-test increased the 'size'.
> 
> we should do something about these. list_add() is hard, while we could
> introduce a separate type for list heads, there are some valid uses of
> non-head list_add(). But perhaps those could be separated out.
> 
> handling most of the gfp() mixups should be a bit easier, perhaps by
> detecting invalid flags in the inline section, which is optimized away at
> runtime in like 95% of the cases?

I had a gcc patch which made enum typing strict for C
(-Wstrict-enums), which was designed for the GFP_xxx case and things
like it (you make them enums).  It was against 2.95.2, RSN I should
update it, and (as Tridge suggested) make it an __attribute__.

For runtime checks (which are never as good) you could change the GFP_
defined to set the high bit.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
