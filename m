Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbTHYSIf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 14:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbTHYSIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 14:08:16 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:61386 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262074AbTHYSIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 14:08:06 -0400
Subject: Re: [PATCH] Pentium Pro - sysenter - doublefault
From: Jim Houston <jim.houston@comcast.net>
Reply-To: jim.houston@comcast.net
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030825062905.GA21262@mail.jlokier.co.uk>
References: <1061498486.3072.308.camel@new.localdomain>
	 <20030825040514.GA20529@mail.jlokier.co.uk>
	 <20030825041423.GB29987@unthought.net>
	 <20030825055028.GE20529@mail.jlokier.co.uk>
	 <20030825062905.GA21262@mail.jlokier.co.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1061835311.12585.46.camel@new.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 25 Aug 2003 14:15:12 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-08-25 at 02:29, Jamie Lokier wrote:
> Jamie Lokier wrote:
> > So that means the sysenter instruction _does_ exist on the PPro and
> > early Pentium II, but it isn't usable.
> 
> If anyone has information on what the SYSENTER and SYSEXIT
> instructions actually do on Intel Pentium Pro or stepping<3 Pentium II
> processors, I am very interested.
> 
> I'm intrigued to know if the buggy behaviour of these instructions is
> really unsafe, or simply hard to use so Intel changed the behaviour.
> (An example of hard to use would be SYSENTER not disabling
> interrupts).  If they are safe but hard to use, perhaps the ingenuity
> of kernel hackers can work around the hardness >:)

Hi Jamie,

I tried your test on my machine.  It fails with a segmentation
fault.  I noticed that the Pentium II specifications update manual
starts with rev C0 stepping (ignoring mask rev < 3).
I'm inclined to forgive Intel for not publishing the scary errata that
goes with the first few mask revs, particularly for an old product.

When I was chasing the original problem, I added tracing code 
(compiling the kernel with finstrument-functions) so that when I
got into kgdb after the double-fault I could see that it had just
completed a umask system call.  I'm assuming that it failed on
the sysexit.

I keep the old Pentium Pro around because it has an NMI interrupt
button.

I'm happy that Linus has merged the fix to disable correctly
disable sysenter for these machines.

Jim Houston - Concurrent Computer Corp

