Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265351AbSLMTf7>; Fri, 13 Dec 2002 14:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265361AbSLMTf7>; Fri, 13 Dec 2002 14:35:59 -0500
Received: from smtp.mailix.net ([216.148.213.132]:34903 "EHLO smtp.mailix.net")
	by vger.kernel.org with ESMTP id <S265351AbSLMTf6>;
	Fri, 13 Dec 2002 14:35:58 -0500
Date: Fri, 13 Dec 2002 20:43:40 +0100
From: Alex Riesen <fork0@users.sf.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert module directory hierarchy and depmod invocation
Message-ID: <20021213194340.GA1050@steel>
Reply-To: Alex Riesen <fork0@users.sf.net>
References: <20021213030554.F27312C14D@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021213030554.F27312C14D@lists.samba.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell, Fri, Dec 13, 2002 04:04:57 +0100:
> While the kernel, depmod et. al. don't care, other tools want the
> directory hierarchy under /lib/modules/`uname -r`/.  Sure, it's bogus
> for them to rely on kernel source layout, but noone has come up with a
> better alternative, so revert.
> 
> NOTE: You *still* can't have two modules of the same name!  (You never
> could).
> 

Are you sure it actually is the patch which does what
you have described?
And where can one find the patch, btw?

> Name: Module init reentry fix
> Author: Rusty Russell
> Status: Tested on 2.5.51
> 
> D: This changes the code to drop the module_mutex() before calling the
> D: module's init function, so module init functions can call
> D: request_module().  This was trivial before someone broke the module
> D: code to start non-live.  Now it requires us to keep info on the
> D: exact module state.
> 
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27854-linux-2.5.51/include/linux/module.h .27854-linux-2.5.51.updated/include/linux/module.h
> --- .27854-linux-2.5.51/include/linux/module.h	2002-12-10 15:56:53.000000000 +1100
> +++ .27854-linux-2.5.51.updated/include/linux/module.h	2002-12-12 11:31:28.000000000 +1100
