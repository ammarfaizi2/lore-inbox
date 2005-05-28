Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262668AbVE1CQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262668AbVE1CQu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 22:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbVE1CQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 22:16:49 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:15520 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262669AbVE1CQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 22:16:45 -0400
Subject: Re: kernel memory usage any restrictions?
From: Steven Rostedt <rostedt@goodmis.org>
To: cranium2003 <cranium2003@yahoo.com>
Cc: linux-kernel@vger.kernel.org, Chris Friesen <cfriesen@nortel.com>
In-Reply-To: <20050528015650.75229.qmail@web33001.mail.mud.yahoo.com>
References: <20050528015650.75229.qmail@web33001.mail.mud.yahoo.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 27 May 2005 22:16:33 -0400
Message-Id: <1117246593.6477.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-27 at 18:56 -0700, cranium2003 wrote:

> > Your call will almost certainly fail.  I think
> > kmalloc will only give 
> > you up to 128KB, and even that might be tricky to do
> > with GFP_ATOMIC.
> > 
>          NO I mean the source code total require 625kB
> not i require a single call of kmalloc with GFP_ATOMIC
> but many calls whose total sum will be around 625kB.

Matters what you system is.  I have a gig of RAM and can easily allocate
a meg by 32 32K chunks.  I haven't tried it with ATOMIC, but that just
means it will fail if it can't get you something right away and it needs
to sleep.  But if you keep trying, that is, don't allocate then
(assuming you're in an interrupt) and try again another time (in another
interrupt), you should eventually get the 625kB.  But as this answer is,
you need to supply more context.  If you can't fail any of those tries,
then it probably won't work.  You're system may be cached out, and would
need to write pages to the disk before it can give you the memory you
need, and then it would have to sleep.

-- Steve


