Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbULGQbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbULGQbX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 11:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbULGQbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 11:31:23 -0500
Received: from bgm-24-94-57-164.stny.rr.com ([24.94.57.164]:14519 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261845AbULGQbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 11:31:19 -0500
Subject: Re: Bug in kmem_cache_create with duplicate names
From: Steven Rostedt <rostedt@goodmis.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Randy.Dunlap" <rddunlap@osdl.org>
In-Reply-To: <1102436777.25841.271.camel@localhost.localdomain>
References: <1102434056.25841.260.camel@localhost.localdomain>
	 <41B5CD41.9050102@osdl.org>  <1102436157.2882.8.camel@laptop.fenrus.org>
	 <1102436777.25841.271.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Tue, 07 Dec 2004 11:31:19 -0500
Message-Id: <1102437079.25841.275.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-07 at 11:15 -0500, Arjan van de Ven wrote:

> > However, I agree with you.  I don't see a good reason for it.
> 
> I do...
> because if the registration gives success..... then you unregister it
> later during module unload and the INITIAL user goes bang.
> It's a bad bug. Don't do it. Fix your code ;)
> 

Your module should fail to load if you can't register a cache. If you
are a good boy and check your return codes from the kmem_cache_create,
you would know that the cache failed and not load the module.
Otherwise, if it failed for other reasons, then you can be causing bugs
later when you go to use it. 

Now this raises the issue of name space, this will bug if two modules
use the same cache name. If this happens with two different vendors,
than the poor user will have to figure out who to blame.

-- Steve

(Arjan, Sorry for the duplicate, I forgot to do a reply all)
