Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbUK0QL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbUK0QL6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 11:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbUK0QL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 11:11:57 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:21229 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261244AbUK0QLw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 11:11:52 -0500
Subject: Re: Suspend 2 merge: 43/51: Utility functions.
From: Dave Hansen <haveblue@us.ibm.com>
To: ncunningham@linuxmail.org
Cc: Pavel Machek <pavel@ucw.cz>, Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101427475.27250.170.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101299832.5805.371.camel@desktop.cunninghams>
	 <20041125234635.GF2909@elf.ucw.cz>
	 <1101427475.27250.170.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101571874.8940.4383.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 27 Nov 2004 08:11:14 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-25 at 16:04, Nigel Cunningham wrote:
> On Fri, 2004-11-26 at 10:46, Pavel Machek wrote:
> > How many bits do you need? Two? I'd rather use thow two bits than have
> > yet another abstraction. Also note that it is doing big order
> > allocation.
> 
> Three if checksumming is enabled IIRC. I'll happily use normal page
> flags, but we only need them when suspending, and I understood they were
> rarer than hen's teeth :>
> 
> MM guys copied so they can tell me I'm wrong :>

Please remember that, in almost all cases, any use of page->flags can be
replaced by a simple list.  Is a page marked foo?  Well, just traverse
this data structure and see if the page is in there.  It might be a
stinking slow check, but it will *work*.

I think we're up to using 1 bit in the memory hotplug code, but we don't
even need that if some operations can be implemented more slowly.  

An extreme example:

struct list_head foo;

int PageSuspendFoo(page)
{
	ret = 0;
	lock();
	list_for_each(foo, bar) {
		if (page == bar)
			ret = 1;
	}
	unlock();
	return ret;
}

-- Dave

