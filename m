Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263157AbTJJXWE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 19:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263172AbTJJXVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 19:21:45 -0400
Received: from dp.samba.org ([66.70.73.150]:51122 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263173AbTJJXVZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 19:21:25 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test6 module autoloading and reference counting broken? 
In-reply-to: Your message of "Fri, 03 Oct 2003 14:30:52 +0200."
             <16253.27644.578089.345998@gargle.gargle.HOWL> 
Date: Fri, 10 Oct 2003 15:25:20 +1000
Message-Id: <20031010232125.5C6692C01A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <16253.27644.578089.345998@gargle.gargle.HOWL> you write:
> FYI,
> 
> I'm seeing incorrect reference counting behaviour and module
> loading semi-failures in 2.6.0-test6.
> 
> I have a misc char driver module which announces an alias
> via a MODULE_ALIAS("char-major-10-<nnn>") declaration.
> 
> The first attempt by user-space to open the device node fails
> with ENODEV. However, afterwards the module _is_ loaded and its
> use count is 1 even though the user-space open() failed.

Sounds like a refcount bug somewhere (in your module, maybe?).
There's nothing magic about modules loaded via kmod, even via
aliases, unless there's a bug in drivers/char/misc.c...

Puzzled,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
