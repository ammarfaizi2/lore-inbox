Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267649AbSKTH2P>; Wed, 20 Nov 2002 02:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267648AbSKTHUN>; Wed, 20 Nov 2002 02:20:13 -0500
Received: from dp.samba.org ([66.70.73.150]:56275 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267637AbSKTHTt>;
	Wed, 20 Nov 2002 02:19:49 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [PATCH] mii module broken under new scheme 
In-reply-to: Your message of "Tue, 19 Nov 2002 12:51:44 CDT."
             <3DDA7A30.4010403@pobox.com> 
Date: Wed, 20 Nov 2002 08:38:52 +1100
Message-Id: <20021120072654.1B6192C07A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3DDA7A30.4010403@pobox.com> you write:
> Matt Reppert wrote:
> 
> > drivers/net/mii.c doesn't export module init/cleanup functions. That 
> > means it
> > can't be loaded under the new module scheme. This patch adds do-nothing
> > functions for it, which allows it to load. (8139too depends on mii, so
> > without this I don't have network.)
> 
> ahhh!   I was wondering what was up, but since I was busy with other 
> things I just compiled it into the kernel and continued on my way.
> 
> That's a bug in the new module loader.

Yes.  But the workaround of calling the module "unknown" isn't nice
either: just put "no_module_init;" in and be done with it (it's also a
big hint that the module doesn't do anything itself).

Richard Henderson, Kai and myself are discussing a post-link stage for
modules, which will allow us to add the .modname section at that time,
but 99% of the cases are already fixed.

Sorry for any trouble,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
