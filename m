Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965118AbWDOS6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965118AbWDOS6K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 14:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965154AbWDOS6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 14:58:09 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:36278 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965118AbWDOS6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 14:58:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=5xB/LXGcOqlmU7cxQqVDB2BvHv9bQNqBkpJzgwo6QEO6oiOKgrrzFoA9pylW7iF37saoVBaQxzzxort+U0SKu8buzkxu7DUqmGXWG7CsQ76Ua5lpcxxCOL/+OSEerqnavEXd54/3O4J3Ppw815kAWxhWltl6nXSEk02O0oN72lo=  ;
Message-ID: <4440855A.7040203@yahoo.com.au>
Date: Sat, 15 Apr 2006 15:32:10 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>,
       Martin Mares <mj@atrey.karlin.mff.cuni.cz>, bjornw@axis.com,
       schwidefsky@de.ibm.com, benedict.gaster@superh.com, lethal@linux-sh.org,
       Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@tensilica.com>,
       Joe Taylor <joe@tensilica.com>,
       David Mosberger-Tang <davidm@hpl.hp.com>, rth@twiddle.net,
       spyro@f2s.com, starvik@axis.com, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, ralf@linux-mips.org,
       linux-mips@linux-mips.org, grundler@parisc-linux.org,
       parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
       paulus@samba.org, linux390@de.ibm.com, davem@davemloft.net
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
References: <1145049535.1336.128.camel@localhost.localdomain>
In-Reply-To: <1145049535.1336.128.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:

>  would now create a variable called per_cpu_offset__myint in
> the .data.percpu_offset section.  This variable will point to the (if
> defined in the kernel) __per_cpu_offset[] array.  If this was a module
> variable, it would point to the module per_cpu_offset[] array which is
> created when the modules is loaded.

If I'm following you correctly, this adds another dependent load
to a per-CPU data access, and from memory that isn't node-affine.

If so, I think people with SMP and NUMA kernels would care more
about performance and scalability than the few k of memory this
saves.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
