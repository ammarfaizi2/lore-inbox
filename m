Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266147AbUAVD33 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 22:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266172AbUAVD33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 22:29:29 -0500
Received: from dp.samba.org ([66.70.73.150]:7404 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266147AbUAVD30 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 22:29:26 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] v4l-05 add infrared remote support 
In-reply-to: Your message of "Wed, 21 Jan 2004 10:59:36 BST."
             <20040121095935.GA31624@bytesex.org> 
Date: Thu, 22 Jan 2004 12:05:00 +1100
Message-Id: <20040122032941.262AD2C229@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040121095935.GA31624@bytesex.org> you write:
> > This provides simple forwards compat for 2.4.  It doesn't do arrays or
> > strings, but they can be added if required (this will cover the easy
> > 90%).
> 
> At least the array stuff I'm using in my drivers, to handle the
> "multiple tv cards in one box" case, like this:
> 
>   static unsigned int card[] = {[0 ... (SAA7134_MAXBOARDS - 1)] = UNSET };
>   MODULE_PARM(card,"1-" __stringify(SAA7134_MAXBOARDS) "i");
>   MODULE_PARM_DESC(card,"card type");
> 
> So having that in 2.4 too would be nice.

Unfortunately the module_param_array() macro is not really fungible
into the old MODULE_PARM() macro: in particular the array size is now
implicit.

I could introduce another macro which could be #defined to both, but
for the moment I thought I'd see we get without one.

> I have also two more questions:  How can I specify default values != 0
> for insmod options using the new macros?

Not sure I understand?  You'd presumably do it like so:

int foo = 7;
MODULE_PARM(foo, "i"); / module_param(foo, int, 0600)

>  How specify help/description
> texts?  Using the MODULE_PARM_DESC() macro or is there something new too?

I didn't change it.  I thought about it, but I think that would just
be neatening for the sake of neatening, which I dislike.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
