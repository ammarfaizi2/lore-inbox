Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262369AbVCBRin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbVCBRin (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 12:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbVCBRin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 12:38:43 -0500
Received: from fire.osdl.org ([65.172.181.4]:46534 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262369AbVCBRik (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 12:38:40 -0500
Date: Wed, 2 Mar 2005 09:34:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: bunk@stusta.de, kai@germaschewski.name, sam@ravnborg.org,
       rusty@rustcorp.com.au, vincent.vanackere@gmail.com,
       keenanpepper@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Undefined symbols in 2.6.11-rc5-mm1
Message-Id: <20050302093459.71b2fdd2.akpm@osdl.org>
In-Reply-To: <200503021723.j22HNMEQ019547@turing-police.cc.vt.edu>
References: <422550FC.9090906@gmail.com>
	<20050302012331.746bf9cb.akpm@osdl.org>
	<65258a58050302014546011988@mail.gmail.com>
	<20050302032414.13604e41.akpm@osdl.org>
	<20050302140019.GC4608@stusta.de>
	<20050302082846.1b355fa4.akpm@osdl.org>
	<200503021723.j22HNMEQ019547@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
>
> (hermes.c)
>  static int __init init_hermes(void)
>  {
>          return 0;
>  }
> 
>  static void __exit exit_hermes(void)
>  {
>  }
> 
>  module_init(init_hermes);
>  module_exit(exit_hermes);
> 
>  That's it.  As far as I can tell, gcc 4.0 semi-correctly determined they were both
>  static functions with no side effect, threw them away, and then the module_init
>  and module_exit threw undefined symbols for them.
> 
>  My totally incorrect workaround was to stick a printk(KERN_DEBUG) in the body
>  of the 3 trimmed functions so they had side effects.
> 
>  Anybody got a *better* solution?

uh, maybe

static int __init init_hermes(void)
{
	asm("");
	return 0;
}

then raise a gcc bug report?
