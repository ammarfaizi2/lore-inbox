Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264315AbUDTWuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264315AbUDTWuW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 18:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264543AbUDTWod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 18:44:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:29658 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264315AbUDTUCm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 16:02:42 -0400
Date: Tue, 20 Apr 2004 13:04:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: jakub@redhat.com, drepper@redhat.com, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] per-user signal pending and message queue limits
Message-Id: <20040420130439.23fae566.akpm@osdl.org>
In-Reply-To: <20040420141319.GB13259@logos.cnet>
References: <20040419212810.GB10956@logos.cnet>
	<20040419224940.GY31589@devserv.devel.redhat.com>
	<20040420141319.GB13259@logos.cnet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
>  I wonder if it is a good idea to base mqueue limitation on the number of
> > message queues and not take into account how big they are.
> > 64 message queues with 1 byte msgsize and 1 maxmsg is certainly quite
> > harmless and the system could have even more queues for such a user,
> > while 64 message queues with 16K msgsize (current default) and 40 maxmsg
> > (also default) eats ~ 40M of kernel memory.
> 
> Indeed, it seems more correct to account for something else than "nr of message queues".
> 
> Memory occupied sounds better, yeap?
> 
> I'm sending the patch anyway, we can use the same RLIMIT_MSGQUEUE and user->msg_queues later 
> on with another meaning. 
> 
> Here it goes the update version, Andrew:

But we still have the global mq and signal limits?  These permit local
denials of service attacks.  See
http://seclists.org/lists/linux-kernel/2004/Apr/2065.html

The major advantage of your work is that we can now remove those limits. 
You'll be needing a 2.4 backport ;)

