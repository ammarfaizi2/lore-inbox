Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265599AbTF3Cnp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 22:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265522AbTF3Cnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 22:43:45 -0400
Received: from dp.samba.org ([66.70.73.150]:7099 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265599AbTF3Cnm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 22:43:42 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix for kallsyms module symbol resolution problem 
In-reply-to: Your message of "27 Jun 2003 22:26:27 EST."
             <1056770789.1825.200.camel@mulgrave> 
Date: Mon, 30 Jun 2003 12:06:08 +1000
Message-Id: <20030630025802.F2F432C232@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1056770789.1825.200.camel@mulgrave> you write:
> In lots of KALLSYMS symbol resolution in modules, I've noticed the
> appearance of symbols with no names:
> 
> Jun 27 20:55:26 raven kernel:  [<10131440>] schedule_timeout+0x78/0xdc
> Jun 27 20:55:26 raven kernel:  [<000f8240>] +0x4e0/0x598 [sunrpc]
> Jun 27 20:55:26 raven kernel:  [<0014504c>] +0x150/0x43c [nfsd]
> Jun 27 20:55:26 raven kernel:  [<10109c5c>] ret_from_kernel_thread+0x1c/0x24
> 
> The problem seems to be that get_ksymbol doesn't eliminate empty symbol
> names when it does resolution.  The attached patch should fix this.

Please test, because that's only one problem.

The other is that the module_text_address() returns true if the value
is within the module, *not* just if it's within a function.  So you
can get some noise there, too, on archs which don't do real
backtracing.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
