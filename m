Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbWBYHbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWBYHbU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 02:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWBYHbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 02:31:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45540 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932386AbWBYHbT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 02:31:19 -0500
Date: Fri, 24 Feb 2006 23:30:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: kamezawa.hiroyu@jp.fujitsu.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] for_each_online_pgdat (take2)  [1/5]  define
 for_each_online_pgdat
Message-Id: <20060224233030.3fd18e25.akpm@osdl.org>
In-Reply-To: <20060225160736.56f9393e.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060225150528.98386921.kamezawa.hiroyu@jp.fujitsu.com>
	<20060224221651.58950b8c.akpm@osdl.org>
	<20060225152218.a9e74acf.kamezawa.hiroyu@jp.fujitsu.com>
	<20060225160736.56f9393e.kamezawa.hiroyu@jp.fujitsu.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
>
> On Sat, 25 Feb 2006 15:22:18 +0900
> KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
> 
> > On Fri, 24 Feb 2006 22:16:51 -0800
> > Andrew Morton <akpm@osdl.org> wrote:
> > > 
> > > Some of these things must generate a large amount of code - would you have
> > > time to look into uninlining them, see what impact that has on .text size?
> > 
> > Okay, I'll do soon on ia64.
> > 
> I compared inlined and out-of-lined vmlinux on ia64 NUMA config kernel.
> 
> 	inline		out-of-line
> .text   005c0680        005bf6a0
> 
> 005c0680 - 005bf6a0 = FE0 = 4Kbytes. 
> 
> Considering the usage of this loop,  above size looks big ;)

Yes, we inline too many things.  Still.

> I attaches a patch which makes pgdat_walk funcs out-of-line.

Looks fine to me.

> I'll rewrite this if necessary.
> (make this patch depends on some config or move the place of funcs...)

We wouldn't want a config option for it.

And the new mmzone.c probably makes sense too - I expect there are a few
related things (page_alloc.c) which could be moved there.
