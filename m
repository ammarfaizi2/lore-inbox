Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262889AbVCDRAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262889AbVCDRAJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 12:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262956AbVCDQ5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 11:57:46 -0500
Received: from ozlabs.org ([203.10.76.45]:7562 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262959AbVCDQy6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 11:54:58 -0500
Subject: Re: Undefined symbols in 2.6.11-rc5-mm1
From: Rusty Russell <rusty@rustcorp.com.au>
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       kai@germaschewski.name, Sam Ravnborg <sam@ravnborg.org>,
       vincent.vanackere@gmail.com, keenanpepper@gmail.com,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200503021723.j22HNMEQ019547@turing-police.cc.vt.edu>
References: <422550FC.9090906@gmail.com>
	 <20050302012331.746bf9cb.akpm@osdl.org>
	 <65258a58050302014546011988@mail.gmail.com>
	 <20050302032414.13604e41.akpm@osdl.org> <20050302140019.GC4608@stusta.de>
	 <20050302082846.1b355fa4.akpm@osdl.org>
	 <200503021723.j22HNMEQ019547@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Fri, 04 Mar 2005 21:26:37 +1100
Message-Id: <1109931997.28203.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-02 at 12:23 -0500, Valdis.Kletnieks@vt.edu wrote:
> static int __init init_hermes(void)
> {
>         return 0;
> }
> 
> static void __exit exit_hermes(void)
> {
> }
> 
> module_init(init_hermes);
> module_exit(exit_hermes);
> 
> That's it.  As far as I can tell, gcc 4.0 semi-correctly determined they were both
> static functions with no side effect, threw them away, and then the module_init
> and module_exit threw undefined symbols for them.

As a module, we create a non-static alias for "init_hermes", called
"init_module", effectively making it non-static.  GCC should not
eliminate it in this case.  Similar with module_exit().

For non-modules, we have __attribute_used__.

Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

