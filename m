Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbULGQKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbULGQKv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 11:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbULGQKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 11:10:51 -0500
Received: from fire.osdl.org ([65.172.181.4]:50853 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261848AbULGQKp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 11:10:45 -0500
Message-ID: <41B5CD41.9050102@osdl.org>
Date: Tue, 07 Dec 2004 07:33:21 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Bug in kmem_cache_create with duplicate names
References: <1102434056.25841.260.camel@localhost.localdomain>
In-Reply-To: <1102434056.25841.260.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> Is it really necessary to BUG on creating a cache with a duplicate name?
> Wouldn't it just be better to fail the create. The reason I mentioned
> this is that I was writing some modules and after doing a cut and paste,
> I forgot to change a name of a cache that was created by one module and
> I used it in another existing module.  So you can say that it was indeed
> a bug, but did it really need to crash my machine?  I aways check the
> return codes in my modules, and I would have figured it out why it
> failed, but I didn't expect a simple module to crash the machine the way
> it did.  Well anyway it did definitely show me where my bug was.

Yes, it does that.

However, I agree with you.  I don't see a good reason for it.

Duplicate name can just return NULL.  NOTE:  Such a change most
likely requires an audit of all callers of kmem_cache_create()
to be sure that they check its return value.  There's a gcc
attribute that can be added to the function prototype to
warn if the function is called without looking at its
return value, although just doing
	x = kmem_cache_create(...);
and ignoring x probably evades the warning.


include/linux/compiler-gcc+.h:
#define __must_check 		__attribute__((warn_unused_result))

-- 
~Randy
