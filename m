Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317592AbSIBGyC>; Mon, 2 Sep 2002 02:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318027AbSIBGyC>; Mon, 2 Sep 2002 02:54:02 -0400
Received: from dp.samba.org ([66.70.73.150]:31147 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S317592AbSIBGyB>;
	Mon, 2 Sep 2002 02:54:01 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Robert Love <rml@tech9.net>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [TRIVIAL PATCH] Remove list_t infection. 
In-reply-to: Your message of "02 Sep 2002 01:51:54 -0400."
             <1030945918.939.3143.camel@phantasy> 
Date: Mon, 02 Sep 2002 16:17:32 +1000
Message-Id: <20020902065831.DB8502C1A7@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1030945918.939.3143.camel@phantasy> you write:
> On Mon, 2002-09-02 at 01:23, Rusty Russell wrote:
> 
> > This week, it spread to SCTP.
> > 
> > "struct list_head" isn't a great name, but having two names for
> > everything is yet another bar to reading kernel source.
> 
> I am all for your cleanup here, but two nits:
> 
> Why not rename list_head while at it?  I would vote for just "struct
> list" ... the name is long, and I like my lines to fit 80 columns.

Because renaming breaks things for no good reason.  "list_head is
ugly" is insufficient cause: it doesn't cause bugs (cf. skb_realloc).

You want to clean up some ugliness?  Find every
list_for_each/list_entry pair and substitute list_for_each_entry().

> Second, if we want to force people to change, we should remove "list_t"
> too to prevent new uses creeping in.  Plus, like Linus says, it is often
> to break stuff and cleanup the mess...

I did: see the patch.

Really, I don't care whether it's "struct list_head" or "list_t", but
both is stupid.  And since struct list_head is backwards compatible,
that's the winner here.

As someone who has been slowly feeding ISO-C declarated initializers
into 2.5, I am acutely aware of the cost of widespread change.

Hope that clarifies,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
