Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272569AbTGZRGa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 13:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272572AbTGZRG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 13:06:29 -0400
Received: from dp.samba.org ([66.70.73.150]:11157 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S272569AbTGZRG0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 13:06:26 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: davem@redhat.com, arjanv@redhat.com, torvalds@transmeta.com,
       greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove module reference counting. 
In-reply-to: Your message of "Fri, 25 Jul 2003 12:26:51 MST."
             <20030725122651.4aedc768.shemminger@osdl.org> 
Date: Sat, 26 Jul 2003 08:26:11 +1000
Message-Id: <20030726172139.348342C24B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030725122651.4aedc768.shemminger@osdl.org> you write:
> On Fri, 25 Jul 2003 04:00:18 +1000
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> > 	If module removal is to be a rare and unusual event, it
> > doesn't seem so sensible to go to great lengths in the code to handle
> > just that case.  In fact, it's easier to leave the module memory in
> > place, and not have the concept of parts of the kernel text (and some
> > types of kernel data) vanishing.
> > 
> > Polite feedback welcome,
> > Rusty.
> > --
> 
> There are two possible objections to this:
>  * Some developers keep the same kernel running and load/unload then reload
>    a new driver when debugging. This would break probably or at least cause
>    a large amount of kernel growth. Not that big an issue for me personally
>    but driver writers seem to get hit with all the changes.

No, it would just leak memory.  Not really a concern for developers.
It's fairly trivial to hack up a backdoor "remove all freed modules
and be damned" thing for developers if there's real demand.

>  * Drivers might get sloppy about not cleaning up timers and data
>  structures -- more than they are already.  You might want to have a
>  kernel debug option that overwrite's the unloaded text with
>  something guaranteed to cause an oops.

I already have a poisoning patch for init code, when some modules
seemed to suffer from this being discarded.  I can extend it.

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
