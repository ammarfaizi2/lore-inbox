Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265028AbSJRHJX>; Fri, 18 Oct 2002 03:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265029AbSJRHJX>; Fri, 18 Oct 2002 03:09:23 -0400
Received: from pizda.ninka.net ([216.101.162.242]:6084 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265028AbSJRHJW>;
	Fri, 18 Oct 2002 03:09:22 -0400
Date: Fri, 18 Oct 2002 00:07:38 -0700 (PDT)
Message-Id: <20021018.000738.05626464.davem@redhat.com>
To: crispin@wirex.com
Cc: hch@infradead.org, greg@kroah.com, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3DAFB260.5000206@wirex.com>
References: <20021017201030.GA384@kroah.com>
	<20021017211223.A8095@infradead.org>
	<3DAFB260.5000206@wirex.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Crispin Cowan <crispin@wirex.com>
   Date: Fri, 18 Oct 2002 00:04:00 -0700

   Christoph Hellwig wrote:
   
   >On Thu, Oct 17, 2002 at 01:10:31PM -0700, Greg KH wrote:
   >I know.  but hiding them doesn't make them any better..

   Actuall, yes it does, and that is the point. You don't have to like 
   SELinux's system calls, or any other module's syscalls. The whole point 
   of LSM was to decouple security design from the Linux kernel development.

Anything which passes a completely opaque value through a system
call is a sign of trouble, design wise.

There is simply no way we can enfore proper portable typing by
all these security module authors such that we can do any kind
of proper 32-bit/64-bit syscall translation on the ports that
need to do this.

If we do things such as the fs stacking or fs filter ideas,
that eliminates a whole swath of the facilities the security_ops
"provide".  No ugly syscalls passing opaque types through the kernel
to some magic module, but rather a real facility that is useful
to many things other than LSM.

