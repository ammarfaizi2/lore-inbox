Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263922AbTDHDke (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 23:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263925AbTDHDke (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 23:40:34 -0400
Received: from dp.samba.org ([66.70.73.150]:56999 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263922AbTDHDkd (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 23:40:33 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: zwane@linuxpower.ca, linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: SET_MODULE_OWNER? 
In-reply-to: Your message of "Mon, 07 Apr 2003 22:27:28 -0400."
             <3E923390.9010206@pobox.com> 
Date: Tue, 08 Apr 2003 13:46:52 +1000
Message-Id: <20030408035210.02D142C06E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3E923390.9010206@pobox.com> you write:
> > ie. AFAICT it only buys you 2.2 compatibility, and even then only if
> > you #define it at the top of your driver.
> 
> no, farther back than that, to infinity and beyond :)  The idea of the 
> macro is that on earlier kernels, it is simply a no-op, and module 
> refcounting is handled by other means.

Crap.  Since hch removed the other module ops, if your module does its
own refcount THAT won't compile in 2.5.

> > I still don't understand: please demonstrate a use in existing source.
> 
> demonstrate?  grep for it.  It's used quite a bit.  Removal of 
> SET_MODULE_OWNER looks to me to be pointless churn for negative gain. 
> If if you wish to pointedly ignore the old-source compatibility angle, 
> it is a nice convenience macro.

This is complete crap.  It's an obfuscation macro, with no backwards
compatibility capabilities as currently implemented.

Christoph went through and substituted try_inc_mod_count to
try_module_get, for no gain, and broke backwards compatibility.

Unlike that, substituting dev->owner = THIS_MODULE; has no backwards
compatibility loss, and it removes a confusing and pointless macro
which *never* had a point.

Unless you can come up with a real *reason*, I'll move it back under
"deprecated" and start substituting.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
