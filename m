Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265587AbTBCKoL>; Mon, 3 Feb 2003 05:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265754AbTBCKoL>; Mon, 3 Feb 2003 05:44:11 -0500
Received: from dp.samba.org ([66.70.73.150]:46472 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265587AbTBCKoK>;
	Mon, 3 Feb 2003 05:44:10 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: John Levon <levon@movementarian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Module alias and device table support. 
In-reply-to: Your message of "Mon, 03 Feb 2003 02:49:46 -0000."
             <20030203024946.GA90036@compsoc.man.ac.uk> 
Date: Mon, 03 Feb 2003 21:34:08 +1100
Message-Id: <20030203105342.0CE3B2C003@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030203024946.GA90036@compsoc.man.ac.uk> you write:
> On Mon, Feb 03, 2003 at 11:52:57AM +1100, Rusty Russell wrote:
> 
> > Well, "modprobe foo" will only give you the "new_foo" driver if (1) the
> > foo driver isn't found, and (2) the new driver author decides that
> > it's a valid replacement.
> 
> It's not the driver author's decision as to which module an admin would
> like to use. This just seems to make things a lot more awkward.

I disagree.

"insmod foo" will *always* get foo.  The only exception is when "foo"
doesn't exist, in which case modprobe looks for another module which
explicitly says it can serve in the place of foo.

This allows smooth transition when a driver is superceded, *if* the
new author wants it.

> > going to do this, I'd rather they did it in the kernel, rather than
> > some random userspace program.
> 
> Can you explain why please ?

Sure, but you cut the vital bit of my mail.  Currently we have (1)
request_module() which is used in various cases to request a service,
and (2) aliases like "char-major-36", which modprobe.conf (or the old
modutils' builtin) says is "netlink".  If you introduce a new char
major (or, say a new cypher, or new network family, etc), you currenly
have to get everyone to include it in their configuration file.

Now, the netlink module *knows* it provides char-major-36: with
MODULE_ALIAS() it can say so.

Obviously, there is a place for aliases which are configured by the
user: they are definitely not going away.  But many are simple
enumerations, which are currently duplicated external to the kernel
sources.

So I think it's a good idea, even if using it to replace drivers is
insane...

Does that clarify?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
