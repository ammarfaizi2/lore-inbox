Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262181AbSJQUjw>; Thu, 17 Oct 2002 16:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262182AbSJQUjv>; Thu, 17 Oct 2002 16:39:51 -0400
Received: from pizda.ninka.net ([216.101.162.242]:43198 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262181AbSJQUjt>;
	Thu, 17 Oct 2002 16:39:49 -0400
Date: Thu, 17 Oct 2002 13:38:16 -0700 (PDT)
Message-Id: <20021017.133816.82029797.davem@redhat.com>
To: greg@kroah.com
Cc: hch@infradead.org, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021017203652.GB592@kroah.com>
References: <20021017185352.GA32537@kroah.com>
	<20021017.131830.27803403.davem@redhat.com>
	<20021017203652.GB592@kroah.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Greg KH <greg@kroah.com>
   Date: Thu, 17 Oct 2002 13:36:52 -0700

   > Are the LSM modules that exist now using portable types in the objects
   > passed into sys_security?  Note that pointers and things like "long"
   > are not allowed as types, for example, those would need to be translated.
   
   Yes, you are correct, they better be implemented properly, or they will
   not work.
   
How am I supposed to know what the things are being passed in
via these opaque "unsigned long" parameters?

Could they be pointers?  If so, game over already, and this needs
to be fixed NOW.

   And (ignoring the network hooks) there is not a measurable overhead for
   these hooks.  We have documented this many times (OLS paper, USENIX
   paper, etc.)  With the patch I'm about to submit, disabling the option
   makes them go away entirely.
   
Look at the code that gets output, look at the 32K of kernel image
I get even though I have no intention of _ever_ loading a security
module.

So if distribution makers enable CONFIG_SECURITY, EVERY USER eats
this 32K.  That _SUCKS_.

And I severely contest your overhead argument, look at the assembler
code being output, the kernel parts where the hooks are placed are
different.  Lots of places that used to be leaf functions are no
longer leaf functions due to the security_ops invocation being there
now.  Register allocation is also going to be quite different
different.

In short, it's bloat, and if you refuse to realize that perhaps kernel
development is not your true calling in life :-)
