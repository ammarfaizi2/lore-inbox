Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbTEGCSz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 22:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262793AbTEGCSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 22:18:55 -0400
Received: from dp.samba.org ([66.70.73.150]:21736 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262788AbTEGCSw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 22:18:52 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: "David S. Miller" <davem@redhat.com>
Cc: Roger Luethi <rl@hellgate.ch>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.69 
In-reply-to: Your message of "Tue, 06 May 2003 15:24:44 -0300."
             <20030506182444.GC24780@conectiva.com.br> 
Date: Wed, 07 May 2003 12:22:05 +1000
Message-Id: <20030507023126.1FBDC2C061@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030506182444.GC24780@conectiva.com.br> you write:
> > On Tue, 2003-05-06 at 06:39, Roger Luethi wrote:
> > > I'm seeing "kernel BUG at include/linux/module.h:284!" with 2.5.69.

Clearly, this statement in sys_accept is false:

	/*
	 * We don't need try_module_get here, as the listening socket (sock)
	 * has the protocol module (sock->ops->owner) held.
	 */
	__module_get(sock->ops->owner);

Now, the question is, when is this not true?  sock_create certainly
seems to grab a reference count to sock->ops->owner.  Maybe a
refcounting bug elsewhere?

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
