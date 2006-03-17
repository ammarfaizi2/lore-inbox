Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbWCQWyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWCQWyl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 17:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbWCQWyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 17:54:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39558 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750800AbWCQWyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 17:54:40 -0500
Date: Fri, 17 Mar 2006 14:56:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org, aia21@cantab.net,
       len.brown@intel.com
Subject: Re: [patch 1/1] consolidate TRUE and FALSE
Message-Id: <20060317145649.4215761c.akpm@osdl.org>
In-Reply-To: <20060317234311.c5e338f6.xavier.bestel@free.fr>
References: <200603161004.k2GA46Fc029649@shell0.pdx.osdl.net>
	<20060316164932.GT27946@ftp.linux.org.uk>
	<20060316132639.274691d6.akpm@osdl.org>
	<20060317234311.c5e338f6.xavier.bestel@free.fr>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xavier Bestel <xavier.bestel@free.fr> wrote:
>
> On Thu, 16 Mar 2006 13:26:39 -0800
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > C99 does have boolean support, so the proper thing to do is to start
> > using it - implement stdbool.h, fix up fallout, start fixing subsystems. 
> > Given that, and as Greg has fixed up this particular build error I'll drop
> > the patch.
> 
> Isn't there a runtime cost converting all "non-false" values to a unique "true" (i.e. converting non-zero values to one) ?

Yes, there will be.  If people do wrong things.

> I mean:
> 
> bool res = strcmp(string, "whatever");
> if(res)
> 	something_else();

There's an implicit conversion from integer (-1, 0, 1) to boolean there. 
It _should_ require a typecast or, better,

	bool res = (strcmp(...) != 0);

But it won't require that - the compiler will just accept it..  A new `gcc
--implement-bools-properly' or perhaps sparse should warn about the above.

(Hopefully the compiler would have the brains to optimise it all away in
this specific example).

But yeah, it's always possible to deoptimise your code.
