Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261850AbULGQQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbULGQQL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 11:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbULGQQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 11:16:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50144 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261850AbULGQQI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 11:16:08 -0500
Subject: Re: Bug in kmem_cache_create with duplicate names
From: Arjan van de Ven <arjan@infradead.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <41B5CD41.9050102@osdl.org>
References: <1102434056.25841.260.camel@localhost.localdomain>
	 <41B5CD41.9050102@osdl.org>
Content-Type: text/plain
Message-Id: <1102436157.2882.8.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 07 Dec 2004 11:15:57 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-07 at 07:33 -0800, Randy.Dunlap wrote:
> Steven Rostedt wrote:
> > Is it really necessary to BUG on creating a cache with a duplicate name?
> > Wouldn't it just be better to fail the create. The reason I mentioned
> > this is that I was writing some modules and after doing a cut and paste,
> > I forgot to change a name of a cache that was created by one module and
> > I used it in another existing module.  So you can say that it was indeed
> > a bug, but did it really need to crash my machine?  I aways check the
> > return codes in my modules, and I would have figured it out why it
> > failed, but I didn't expect a simple module to crash the machine the way
> > it did.  Well anyway it did definitely show me where my bug was.
> 
> Yes, it does that.
> 
> However, I agree with you.  I don't see a good reason for it.

I do...
because if the registration gives success..... then you unregister it
later during module unload and the INITIAL user goes bang.
It's a bad bug. Don't do it. Fix your code ;)


