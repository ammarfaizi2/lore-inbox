Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262657AbTE0C6J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 22:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbTE0C6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 22:58:08 -0400
Received: from zok.sgi.com ([204.94.215.101]:26327 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S262657AbTE0C6H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 22:58:07 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Corey Minyard <minyard@acm.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc3 - ipmi unresolved 
In-reply-to: Your message of "Mon, 26 May 2003 19:30:04 EST."
             <3ED2B18C.20705@acm.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 27 May 2003 13:09:09 +1000
Message-ID: <18292.1054004949@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 May 2003 19:30:04 -0500, 
Corey Minyard <minyard@acm.org> wrote:
>Keith Owens wrote:
>>I considered making notifier_chain_register() a macro which called
>>notifier_chain_register_module() with __THIS_MODULE, but that assumes
>>that all calls to notifier_chain_register() are local, i.e. from the
>>top level functions.  Alas there are any service routines that call
>>notifier_chain_register() on behalf of their caller, so the macro
>>approach will result in the wrong value for __THIS_MODULE.
>>
>Why can't you have a module id in the notifier chain, and use a boolean
>to tell if it is set, or something similar to that?  That way you could
>mix them, if the bool is set then do the try_in_module_count thing, if
>not then just call the function.  It does add some components to the
>register structure, but that shouldn't hurt anything besides taking a
>little more memory.

It is a change of API in a 2.4 kernel.  Not a good idea.

>>notifier_chain_unregister() is not a problem, that is a downcall from
>>the module into the kernel when the module is going away, downcalls are
>>"always" safe.  The race is a module that has started to unload, and
>>another cpu (or even the same cpu under some circumstances) runs the
>>notifier chain, doing an upcall from the kernel into a module without
>>locking or refcounts.  Given the right timing, the notifier code could
>>even branch to a module that has been completely removed.  Note that
>>notifier_call_chain() has no locking, so it is also racy against
>>notifier_chain_unregister().
>>  
>>
>You don't understand how the RCU code works.

(a) I understand how RCU works, I was working on lock free code for
    years before RCU appeared in the kernel.

(b) This is 2.4, not 2.5, there is no RCU.

