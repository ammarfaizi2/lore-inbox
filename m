Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272256AbTGYTLw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 15:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272258AbTGYTLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 15:11:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:51602 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272256AbTGYTLv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 15:11:51 -0400
Date: Fri, 25 Jul 2003 12:26:51 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: davem@redhat.com, arjanv@redhat.com, torvalds@transmeta.com,
       greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove module reference counting.
Message-Id: <20030725122651.4aedc768.shemminger@osdl.org>
In-Reply-To: <20030725173900.D7DE12C2A9@lists.samba.org>
References: <20030725173900.D7DE12C2A9@lists.samba.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.3claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jul 2003 04:00:18 +1000
Rusty Russell <rusty@rustcorp.com.au> wrote:

> Hi all,
> 
> 	When the initial module patch was submitted, it made modules
> start isolated, so they would not be accessible until (if)
> initialization had succeeded.  This broke partition scanning, and was
> immediately reverted, leaving us with a module reference count scheme
> identical to the previous one (just a faster implementation): we still
> have cases where modules can be access on failed load.
> 
> 	Then Dave decided that the work of reference counting network
> driver modules everywhere is too invasive, so network driver modules
> now have zero reference counts always.  The idea is that if you don't
> want the module removed, don't do it.  ie. only remove the module if
> there's a bug, or you want to replace it.
> 
> 	If module removal is to be a rare and unusual event, it
> doesn't seem so sensible to go to great lengths in the code to handle
> just that case.  In fact, it's easier to leave the module memory in
> place, and not have the concept of parts of the kernel text (and some
> types of kernel data) vanishing.
> 
> Polite feedback welcome,
> Rusty.
> --

There are two possible objections to this:
 * Some developers keep the same kernel running and load/unload then reload
   a new driver when debugging. This would break probably or at least cause
   a large amount of kernel growth. Not that big an issue for me personally
   but driver writers seem to get hit with all the changes.

 * Drivers might get sloppy about not cleaning up timers and data structures
   -- more than they are already.  You might want to have a kernel debug option
   that overwrite's the unloaded text with something guaranteed to cause an 
   oops.






