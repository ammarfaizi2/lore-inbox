Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbUK1Vjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbUK1Vjp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 16:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbUK1Vjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 16:39:44 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:43437 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261245AbUK1Vjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 16:39:42 -0500
Subject: Re: Suspend 2 merge: 43/51: Utility functions.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Pavel Machek <pavel@ucw.cz>, Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101571874.8940.4383.camel@localhost>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101299832.5805.371.camel@desktop.cunninghams>
	 <20041125234635.GF2909@elf.ucw.cz>
	 <1101427475.27250.170.camel@desktop.cunninghams>
	 <1101571874.8940.4383.camel@localhost>
Content-Type: text/plain
Message-Id: <1101677775.4343.262.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 29 Nov 2004 08:36:15 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sun, 2004-11-28 at 03:11, Dave Hansen wrote:
> On Thu, 2004-11-25 at 16:04, Nigel Cunningham wrote:
> > On Fri, 2004-11-26 at 10:46, Pavel Machek wrote:
> > > How many bits do you need? Two? I'd rather use thow two bits than have
> > > yet another abstraction. Also note that it is doing big order
> > > allocation.
> > 
> > Three if checksumming is enabled IIRC. I'll happily use normal page
> > flags, but we only need them when suspending, and I understood they were
> > rarer than hen's teeth :>
> > 
> > MM guys copied so they can tell me I'm wrong :>
> 
> Please remember that, in almost all cases, any use of page->flags can be
> replaced by a simple list.  Is a page marked foo?  Well, just traverse
> this data structure and see if the page is in there.  It might be a
> stinking slow check, but it will *work*.
> 
> I think we're up to using 1 bit in the memory hotplug code, but we don't
> even need that if some operations can be implemented more slowly.  

Yes. That's the way suspending did things initially like checking which
pages were free. The bitmap was added to turn O(n^2) into O(n). Since
the calculations can potentially be done a few times (as memory is freed
so we can suspend), it was a big gain to use a bitmap.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

