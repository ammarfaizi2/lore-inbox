Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbWENRdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWENRdE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 13:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWENRdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 13:33:03 -0400
Received: from [63.81.120.158] ([63.81.120.158]:50403 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751348AbWENRdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 13:33:02 -0400
Subject: Re: [PATCH -rt] scheduling while atomic in fs/file.c
From: Daniel Walker <dwalker@mvista.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0605141241320.25158@gandalf.stny.rr.com>
References: <200605141545.k4EFj6Cv001901@dwalker1.mvista.com>
	 <Pine.LNX.4.58.0605141241320.25158@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Sun, 14 May 2006 10:32:55 -0700
Message-Id: <1147627976.15392.39.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-05-14 at 12:44 -0400, Steven Rostedt wrote:
> On Sun, 14 May 2006, Daniel Walker wrote:
> 
> > Quite the smp_processor_id() wanrings. I don't see any SMP
> > concerns here . It just adds to a percpu list, so it shouldn't
> > matter if it switches after sampling fdtable_defer_list .
> 
> I'm not so sure that there isn't SMP concerns here. I have to catch a
> train in a few minutes, otherwise I would look deeper into this. But this
> might be a candidate to turn fdtable_defer_list into a per_cpu_locked.

I reviewed it again, and it looks like these percpu structures have a
spinlock to protect the list from being emptied by a work queue while
things are being added to the list . The lock appears to be used
properly .  The work queue frees struct fdtable pointers added to the
list , the only place these structures are added is in the block I've
modified .

I think making this a locked percpu would just be overkill ..

Daniel

