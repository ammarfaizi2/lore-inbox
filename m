Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261660AbTAIGMY>; Thu, 9 Jan 2003 01:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261686AbTAIGMY>; Thu, 9 Jan 2003 01:12:24 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:5259 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S261660AbTAIGMX>; Thu, 9 Jan 2003 01:12:23 -0500
To: Rusty Russell <rusty@rustcorp.com.au>, Greg Ungerer <gerg@snapgear.com>,
       David McCullough <davidm@snapgear.com>
Cc: linux-kernel@vger.kernel.org
Subject: exception tables in 2.5.55
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 09 Jan 2003 15:20:41 +0900
Message-ID: <buo1y3msv2e.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm building for the v850, which has no MMU.

Starting with 2.5.55, I'm getting link errors like:

  kernel/extable.c:29: undefined reference to `search_extable'

I didn't have to worry about this with earlier kernels, and it looks
like what happened is that previously arch-specific code was
consolidated into the generic kernel.

As far as I can see, the purpose of exception tables is to deal with
unexpected memory access traps and on the v850, this basically can't
happen (there's no MMU, and no way I know of to detect non-existant
memory).  So I'd like to make the generic exception handling stuff
optional.

However, I'm not sure the best way to do this -- I could try to make it
dependent on CONFIG_MMU, but are there non-MMU processors that _can_
usefully use exception tables (in which case perhaps there should just
be a separate CONFIG_EXTABLES or something)?

[Oh, and also, please tell me if I'm mistaken about the purpose of
these tables and really _should_ just implement them.]

Thanks,

-Miles
-- 
Somebody has to do something, and it's just incredibly pathetic that it
has to be us.  -- Jerry Garcia
