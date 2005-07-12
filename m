Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbVGLNEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVGLNEN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 09:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVGLNEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 09:04:13 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:64174 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261199AbVGLNEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 09:04:11 -0400
Subject: Re: Merging relayfs?
From: Steven Rostedt <rostedt@goodmis.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Tom Zanussi <zanussi@us.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, karim@opersys.com, varap@us.ibm.com,
       richardj_moore@uk.ibm.com
In-Reply-To: <20050712022537.GA26128@infradead.org>
References: <17107.6290.734560.231978@tut.ibm.com>
	 <20050712022537.GA26128@infradead.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 12 Jul 2005 09:03:24 -0400
Message-Id: <1121173404.6917.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-12 at 03:25 +0100, Christoph Hellwig wrote:
> On Mon, Jul 11, 2005 at 08:10:42PM -0500, Tom Zanussi wrote:
> > 
> > Hi Andrew, can you please merge relayfs?  It provides a low-overhead
> > logging and buffering capability, which does not currently exist in
> > the kernel.
> 
> While the code is pretty nicely in shape it seems rather pointless to
> merge until an actual user goes with it.
> 

I have to also say that this is an exception.  How many people out there
have written a variant of relayfs to do debugging?  It is about time
that there's a buffer in the kernel that can be written to and later
retrieved to debug things like the scheduler that printk in all its
forms just doesn't cut it.

I've been working with Tom to get my logdev debugging tool to use
relayfs as a back end.  This allows for showing output that shows
exactly what's going on inside the kernel. It keeps the latest data
around and when/if the kernel crashes, it shows all the events that lead
up to the crash.  Well, it doesn't automatically show what has happened,
but you can put print like statements anywhere in any context and the
latest will be dumped on command or a NMI/panic/oops or whatever.

Once relayfs is added, we need to make a buffer that can be written to
from multiple CPUS.  I understand that Tom got complaints that the
buffers were not orignally lockless, and different CPUs would have their
own buffers.  But this really hurts trying to debug race conditions on
SMP machines, since you don't get the interleaved output of what's going
on.  God I need to get KCSP working, and not worry about race conditions
anymore! :-)

-- Steve


