Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266163AbUAVDbJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 22:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266169AbUAVD3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 22:29:31 -0500
Received: from dp.samba.org ([66.70.73.150]:8172 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266159AbUAVD30 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 22:29:26 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@suse.de>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: 2.6.1-mm4 
In-reply-to: Your message of "Wed, 21 Jan 2004 13:46:57 BST."
             <20040121134657.6cd27cbd.ak@suse.de> 
Date: Thu, 22 Jan 2004 12:31:14 +1100
Message-Id: <20040122032941.2C6F12C259@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040121134657.6cd27cbd.ak@suse.de> you write:

> As for the implementation of doing it at runtime - i took a look at
> it but got scared by sysfs livetime rules and the lack of callbacks
> in module_parm.

FYI module_parm is just a convenience wrapper around

	module_param_call(name, set, get, arg, perm)

Where get and set are the callbacks:

	/* Returns 0, or -errno.  arg is in kp->arg. */
	typedef int (*param_set_fn)(const char *val, struct kernel_param *kp);
	/* Returns length written or -errno.  Buffer is 4k (ie. be short!) */
	typedef int (*param_get_fn)(char *buffer, struct kernel_param *kp);

With these the implementation should be fairly neat.

Hope that clarifies,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
