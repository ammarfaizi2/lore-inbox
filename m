Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267921AbTAMFXV>; Mon, 13 Jan 2003 00:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267924AbTAMFV6>; Mon, 13 Jan 2003 00:21:58 -0500
Received: from dp.samba.org ([66.70.73.150]:45774 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267921AbTAMFVM>;
	Mon, 13 Jan 2003 00:21:12 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Greg Ungerer <gerg@snapgear.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Miles Bader <miles@gnu.org>,
       linux-kernel@vger.kernel.org, David McCullough <davidm@snapgear.com>
Subject: Re: exception tables in 2.5.55 
In-reply-to: Your message of "Mon, 13 Jan 2003 13:49:42 +1000."
             <3E223756.3010200@snapgear.com> 
Date: Mon, 13 Jan 2003 16:26:48 +1100
Message-Id: <20030113053002.4AE6C2C09F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3E223756.3010200@snapgear.com> you write:
> OK, heres an alternative patch that fully supports exception tables
> for m68knommu (Miles you'll need to do the same for v850).

This seems way overkill.  How about you move the search_extable()
prototype out of linux/module.h and into each asm/uaccess.h, then:

include/asm-m68knommu/uaccess.h:

	/* We don't use such things. */
	struct exception_table_entry
	{
		int unused;
	};

	#define search_extable(first, last, value) ({ BUG(); NULL; })

Thoughts?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
