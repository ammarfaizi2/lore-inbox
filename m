Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265030AbTFTXXp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 19:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265031AbTFTXXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 19:23:45 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:4486 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S265030AbTFTXXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 19:23:42 -0400
Date: Fri, 20 Jun 2003 16:36:07 -0700
From: Greg KH <greg@kroah.com>
To: Bastian Blank <bastian@waldi.eu.org>, linux-kernel@vger.kernel.org
Cc: linux-security-module@wirex.com
Subject: Re: [PATCH] builtin stack support
Message-ID: <20030620233606.GA14869@kroah.com>
References: <20030620195051.GA28020@wavehammer.waldi.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030620195051.GA28020@wavehammer.waldi.eu.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 20, 2003 at 09:50:51PM +0200, Bastian Blank wrote:
> hi folks

I'd suggest CC: the lsm mailing list, they might have some comments
about this.

> the following patch

Please don't compress patches, it's a pain to read them.

> - modifies the security modules registering code to built a stack of
>   modules themself
> - changes the internal interface of the security functions to get a
>   pointer to that stack
> - the dummy functions always traverse through the stack
> - register the dummy functions as a special security module
> - drop the cap_* declaration
> - drop mod_(un)reg_security
> - add a name parameter to (un)register_security
> 
> missing things
> - register_security isn't called, it may decide if it allowes the other
>   module to be stacked together.
> 
> advantages
> - it is possible to stack modules together without special support by
>   the modules
> - add functions which will be handled by a non standard module without
>   need to modify the standard one
> 
> problems
> - abi change, change of the security inline functions
> - root_plug is currently unbuildable because the exports of the cap_*
>   functions are dropped, it don't need to use them directly

Why not fix this, as you just broke it :)

> - if the modules don't define a function, the call always travers
>   through the stack until it hits the dummy module
> - more pointer needs to be dereferences, more parameter

How does the performance of this work out, if you only have 1 security
module?  In my opinion, preformance should not drop, unless you want to
stack modules.

And did you see the previous stacker lsm module?  What advantage does
this patch over that one?

thanks,

greg k-h
