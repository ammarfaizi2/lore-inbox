Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265661AbSLBH54>; Mon, 2 Dec 2002 02:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265670AbSLBH54>; Mon, 2 Dec 2002 02:57:56 -0500
Received: from pizda.ninka.net ([216.101.162.242]:6848 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265661AbSLBH5z>;
	Mon, 2 Dec 2002 02:57:55 -0500
Date: Mon, 02 Dec 2002 00:01:54 -0800 (PST)
Message-Id: <20021202.000154.38083110.davem@redhat.com>
To: ralf@linux-mips.org
Cc: torvalds@transmeta.com, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
       anton@samba.org, ak@muc.de, davidm@hpl.hp.com, schwidefsky@de.ibm.com,
       willy@debian.org
Subject: Re: [PATCH] Start of compat32.h (again)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021202085923.A11711@linux-mips.org>
References: <1038804400.4411.4.camel@rth.ninka.net>
	<20021201233901.B32203@twiddle.net>
	<20021202085923.A11711@linux-mips.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ralf Baechle <ralf@linux-mips.org>
   Date: Mon, 2 Dec 2002 08:59:23 +0100
   
   What's the plan to attack 32-bit ioctls?
  ...
   but I guess that's going to cause objections?

Yes, a huge dragon to slay for sure.

To be honest, I'm happy with what's possible right now.
SIOCDEVPRIVATE was the biggest problem and that can be
gradually phased out.

Let's attack the easy stuff first, then we can retry finding
a nicer solution to the ioctl bits.

There are places where real work is needed, for example emulation
of drivers/usb/core/devio.c is nearly impossible without adding
some code to devio.c  It keeps around user pointers, and doesn't
write to the area during that syscall but at some later time
as the result of another system call.
