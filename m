Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263056AbTETAU2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 20:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbTETAU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 20:20:28 -0400
Received: from dp.samba.org ([66.70.73.150]:30352 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263056AbTETAU1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 20:20:27 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: try_then_request_module 
In-reply-to: Your message of "Mon, 19 May 2003 11:08:32 +0200."
             <20030519110832.G626@nightmaster.csn.tu-chemnitz.de> 
Date: Tue, 20 May 2003 10:19:00 +1000
Message-Id: <20030520003322.D38CA2C09D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030519110832.G626@nightmaster.csn.tu-chemnitz.de> you write:
> So try_then_request_module() will consolidate the the
> branch or in the worst case just duplicating that code
> everywhere (depends on wether you implement it as a non-inline
> function or define).

I'm not speculating: here it is from kmod.h:

	#define try_then_request_module(x, mod...) ((x) ?: request_module(mod), (x))

It really should be:

#ifdef CONFIG_KMOD
#define try_then_request_module(x, mod...) ((x) ?: request_module(mod), (x))
#else
#define try_then_request_module(x, mod...) (x)
#endif /* CONFIG_KMOD */

Patches welcome.

Getting rid of the CONFIG_KMOD's in general code without leaving
unused code around is the aim here.

Hope that clarifies!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
