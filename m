Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268583AbTBZEDq>; Tue, 25 Feb 2003 23:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268625AbTBZEDq>; Tue, 25 Feb 2003 23:03:46 -0500
Received: from dp.samba.org ([66.70.73.150]:59581 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S268583AbTBZEDp>;
	Tue, 25 Feb 2003 23:03:45 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eliminate warnings in generated module files 
In-reply-to: Your message of "Tue, 25 Feb 2003 19:36:10 MDT."
             <Pine.LNX.4.44.0302251930280.13501-100000@chaos.physics.uiowa.edu> 
Date: Wed, 26 Feb 2003 15:13:09 +1100
Message-Id: <20030226041359.C54792C04C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0302251930280.13501-100000@chaos.physics.uiowa.edu> y
ou write:
> FWIW, I think it's not a good idea. Why call it 'required' in the kernel 
> when the normal (gcc) expression for it is 'used'. - We didn't rename 
> 'deprecated' to 'obsolete', either ;)

But deprecated was a fine name.  "used" is a terrible name, and since
we're renaming it via a macro anyway... (see "likey").

> Also, I don't really see any use for __optional at this point, so why add 
> it at all?

>From ip_conntrack_core.c:

#ifdef CONFIG_SYSCTL
static struct ctl_table_header *ip_conntrack_sysctl_header;

static ctl_table ip_conntrack_table[] = {
	{
		.ctl_name	= NET_IP_CONNTRACK_MAX,
		.procname	= NET_IP_CONNTRACK_MAX_NAME,
		.data		= &ip_conntrack_max,
		.maxlen		= sizeof(ip_conntrack_max),
		.mode		= 0644,
		.proc_handler	= proc_dointvec
	},
 	{ .ctl_name = 0 }
};

static ctl_table ip_conntrack_dir_table[] = {
	{
		.ctl_name	= NET_IPV4,
		.procname	= "ipv4",
		.maxlen		= 0,
		.mode		= 0555,
		.child		= ip_conntrack_table
	},
	{ .ctl_name = 0 }
};

static ctl_table ip_conntrack_root_table[] = {
	{
		.ctl_name	= CTL_NET,
		.procname	= "net",
		.maxlen		= 0,
		.mode		= 0555,
		.child		= ip_conntrack_dir_table
	},
	{ .ctl_name = 0 }
};
#endif /*CONFIG_SYSCTL*/

I'd love to frop the #ifdef and just mark them __optional: before that
would just mean bloat, but when gcc 3.3 rolls in, they should vanish
nicely.

There are numerous other examples...
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
