Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263820AbUGFNZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263820AbUGFNZd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 09:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbUGFNZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 09:25:32 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:16783 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263820AbUGFNZa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 09:25:30 -0400
Date: Tue, 6 Jul 2004 08:24:52 -0500
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: nfont@austin.ibm.com, paulus@samba.org, linas@austin.ibm.com,
       linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org,
       strosake@us.ibm.com
Subject: Re: [PATCH] [2.6] PPC64: log firmware errors during boot.
Message-Id: <20040706082452.5b338da3.moilanen@austin.ibm.com>
In-Reply-To: <1088789345.26946.9.camel@localhost>
References: <20040629191046.Q21634@forte.austin.ibm.com>
	<16610.39955.554139.858593@cargo.ozlabs.ibm.com>
	<20040701160614.I21634@forte.austin.ibm.com>
	<16613.15510.325099.273419@cargo.ozlabs.ibm.com>
	<3EC84E0C-CC32-11D8-BDBD-000A95A0560C@us.ibm.com>
	<40E58AE9.6050009@austin.ibm.com>
	<1088789345.26946.9.camel@localhost>
Organization: LTC
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Fri, 2004-07-02 at 11:18, Nathan Fontenot wrote:
> > > I asked about this before, and was told that there is no way to
> > > determine the severity of an event without doing full parsing of the
> > > binary data. I'd be thrilled to be wrong...
> >
> > Gettting the severity of an RTAS event is possible, and not too
> > difficult.  Check out asm-ppc64/rtas.h for a definition of the
> > RTAS event header (struct rtas_error_log).  All RTAS events have the
> > same initial header containing the severity of the event.
> 
> Great! Of course that won't help much if we get repeating "important"
> events that aren't even interesting much less important, but it's worth
> trying to printk only the important ones and leave the rest to netlink.
> 
> Note that currently we printk them all as KERN_DEBUG messages. Although
> they aren't spewed to console, they still take up (lots of) space in the
> printk buffer, and dmesg is still afflicted too...
> 

The original "plan" for error logging was to eventually take out the
printk's all together once we could get ela (the userspace daemon
responsible for parsing error messages and routing them appropriately)
into all distros. We didn't want the possibility of a customer losing a
vital message by not having ela installed.  

I would propose the making the printk's of the messages a kernel config
option.  Then the distros could turn it on or off depending on if they
are packaging ela.  All messages should still go to userspace though.
This will alleviate the spamming of the printk buffer.

I have no problems in moving communication between kernel and userspace
to netlink.  Whomever makes the change needs to keep Mike Strosaker and
Nathan Fontenot informed since they are maintaining the user space
counterpart. 

Thanks,
Jake
