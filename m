Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbTLBG6u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 01:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbTLBG6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 01:58:50 -0500
Received: from dp.samba.org ([66.70.73.150]:22488 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261294AbTLBG6t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 01:58:49 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Patrick McHardy <kaber@trash.net>
Cc: James Bourne <jbourne@hardrock.org>, linux-kernel@vger.kernel.org,
       coreteam@netfilter.org
Subject: Re: [netfilter-core] 2.4.23/others and ip_conntrack causing hangs 
In-reply-to: Your message of "Tue, 02 Dec 2003 01:20:15 BST."
             <3FCBDABF.6080804@trash.net> 
Date: Tue, 02 Dec 2003 17:33:26 +1100
Message-Id: <20031202065849.779362C085@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3FCBDABF.6080804@trash.net> you write:
> Rusty Russell wrote:
> 
> >Unfortunately, some packets are still referencing connections, so the
> >module *cannot* go away.  Figuring out exactly where the packets are
> >referenced from is the fun part.  We explicitly drop the reference in
> >ip_local_deliver_finish() for exactly this reason.  Perhaps there is
> >somewhere else we should be doing the same thing.
> >  
> >
> Perhaps in dev_queue_xmit ? Otherwise packets stuck in queues hold
> references to conntracks. Loopback traffic might cause some trouble
> because the "previously seen?" expection in ip_conntrack_core wouldn't
> work anymore.

But I wouldn't expect packets there to be held indefinitely, so I
never worried about it.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
