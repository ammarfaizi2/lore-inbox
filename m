Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbTJMLh2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 07:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbTJMLh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 07:37:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:12471 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261683AbTJMLh1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 07:37:27 -0400
Date: Mon, 13 Oct 2003 04:40:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Kernel thread signal handling.
Message-Id: <20031013044042.23ab7f69.akpm@osdl.org>
In-Reply-To: <1066044079.24015.442.camel@hades.cambridge.redhat.com>
References: <1066041096.24015.431.camel@hades.cambridge.redhat.com>
	<20031013040219.6ad71a57.akpm@osdl.org>
	<1066044079.24015.442.camel@hades.cambridge.redhat.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Mon, 2003-10-13 at 04:02 -0700, Andrew Morton wrote:
> > Sigh.  Using signals to communicate with kernel threads is evil.  It keeps
> > on breaking and each site does it differently and we've had plenty of bugs
> > due to this practice.
> 
> The point in cleaning up allow_signal() et al. is that it gets simple
> and it stops breaking.

It will encourage kernel developers to use signals-to-kernel threads more,
and we don't *need* this capability.

People think "I need to send a message to a kernel thread" and then,
immediately, "ah-hah!  I'll use a signal!"

> ...
> This garbage collection involves reading, writing and erasing the flash.
> It takes CPU time and power. Sometimes userspace wants it to stop
> happening in the background; sometimes userspace wants it to resume
> again.
> 
> So userspace sends SIGSTOP, SIGCONT and SIGKILL to the garbage
> collection thread and all of them have the expected effect. 

Sounds like the GC should have been performed by a userspace process in the
first place?

How does userspace identify the JFFS2 process to which to send the signal?

> I don't any the benefit in changing this practice.

Well I know I'm going to lose this one, but at least I get to bitch about
stuff.

sysfs would be appropriate, as would a sysctl handler.  An ioctl might even
work, although it gets a visit from the ioctl police and sometimes it is
hard to obtain an fd on the appropriate filesystem.  If the call rate is
low, `mount -o remount,...' can be used to send a message to a filesystem.


