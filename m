Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262129AbSJQUUH>; Thu, 17 Oct 2002 16:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262130AbSJQUUH>; Thu, 17 Oct 2002 16:20:07 -0400
Received: from pizda.ninka.net ([216.101.162.242]:28862 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262129AbSJQUUG>;
	Thu, 17 Oct 2002 16:20:06 -0400
Date: Thu, 17 Oct 2002 13:18:30 -0700 (PDT)
Message-Id: <20021017.131830.27803403.davem@redhat.com>
To: greg@kroah.com
Cc: hch@infradead.org, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove sys_security
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021017185352.GA32537@kroah.com>
References: <20021017195015.A4747@infradead.org>
	<20021017185352.GA32537@kroah.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Greg KH <greg@kroah.com>
   Date: Thu, 17 Oct 2002 11:53:52 -0700
   
   No, don't remove this!
   Yes, it's a big switch, but what do you propose otherwise?  SELinux
   would need a _lot_ of different security calls, which would be fine, but
   we don't want to force every security module to try to go through the
   process of getting their own syscalls.
   
   And other subsystems in the kernel do the same thing with their syscall,
   like networking, so there is a past history of this usage.

Well, here is another issue about opaque interfaces, how are we
supposed to audit whether 32-bit/64-bit execution environments
will be able to work correctly?

If there is no description available of what the types are going
through these system calls, it cannot be handled properly.

It is one thing if some existing legacy user interface we can't make
go away creates this kind of problem, but when we add new system calls
we ought to be much much more careful.

I brought this up months ago, and I believe someone (perhaps you :),
said "oh I'll bring that up with the folks, thanks" and I've seen
no action taken since.

Are the LSM modules that exist now using portable types in the objects
passed into sys_security?  Note that pointers and things like "long"
are not allowed as types, for example, those would need to be translated.

The more I look at LSM the more and more I dislike it, it sticks it's
fingers everywhere.  Who is going to use this stuff?  %99.999 of users
will never load a security module, and the distribution makers are
going to enable this NOP overhead for _everyone_ just so a few telcos
or government installations can get their LSM bits?

This doesn't make any sense to me, including LSM appears to be quite
against one of the basic maxims of Linux kernel ideology if you ask me
:-)  (said maxim is: If %99 of users won't use it, they better not
even notice it is there or be affected by it in any way)
