Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261678AbSJDNJm>; Fri, 4 Oct 2002 09:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261669AbSJDNJl>; Fri, 4 Oct 2002 09:09:41 -0400
Received: from ns.suse.de ([213.95.15.193]:49937 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261678AbSJDNJl>;
	Fri, 4 Oct 2002 09:09:41 -0400
Date: Fri, 4 Oct 2002 15:15:12 +0200
From: Andi Kleen <ak@suse.de>
To: linux-kernel@vger.kernel.org
Cc: bidulock@openss7.org
Subject: Re: export of sys_call_table
Message-ID: <20021004151512.B10387@wotan.suse.de>
References: <20021003153943.E22418@openss7.org.suse.lists.linux.kernel> <1033682560.28850.32.camel@irongate.swansea.linux.org.uk.suse.lists.linux.kernel> <20021003170608.A30759@openss7.org.suse.lists.linux.kernel> <1033722612.1853.1.camel@localhost.localdomain.suse.lists.linux.kernel> <20021004051932.A13743@openss7.org.suse.lists.linux.kernel> <p73k7kyqrx6.fsf@oldwotan.suse.de> <20021004071106.A18191@openss7.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021004071106.A18191@openss7.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2002 at 07:11:06AM -0600, Brian F. G. Bidulock wrote:
> read_lock and write_lock are a rw semaphores, aren't they?

No, they are read/write spinlocks and you are not allowed to sleep
in their critical section In general you should limit them
because they can get very costly, e.g. when you're taking interrupts
with one taken or doing something else which takes a long time
and another CPU has to spin for them. 

rw semaphores are down_read()/down_write() etc.

-Andi
