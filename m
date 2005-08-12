Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbVHLKee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbVHLKee (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 06:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbVHLKee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 06:34:34 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:15819 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932130AbVHLKee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 06:34:34 -0400
Subject: Re: Need help in understanding x86 syscall
From: Steven Rostedt <rostedt@goodmis.org>
To: Jeff Carr <jcarr@linuxmachines.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42FC2DE4.4010608@linuxmachines.com>
References: <4Ae73-6Mm-5@gated-at.bofh.it> <E1E3DJm-0000jy-0B@be1.lrz>
	 <Pine.LNX.4.61.0508110954360.14541@chaos.analogic.com>
	 <1123770661.17269.59.camel@localhost.localdomain>
	 <2cd57c90050811081374d7c4ef@mail.gmail.com>
	 <Pine.LNX.4.61.0508111124530.14789@chaos.analogic.com>
	 <1123775508.17269.64.camel@localhost.localdomain>
	 <1123777184.17269.67.camel@localhost.localdomain>
	 <2cd57c90050811093112a57982@mail.gmail.com>
	 <2cd57c9005081109597b18cc54@mail.gmail.com>
	 <1123780681.17269.71.camel@localhost.localdomain>
	 <42FC2DE4.4010608@linuxmachines.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 12 Aug 2005 06:34:24 -0400
Message-Id: <1123842864.17269.153.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-11 at 22:04 -0700, Jeff Carr wrote:

> But are you using libc6-i686? That enables NPTL. Perhaps the behavior
> difference is there? I'm surprised int 80 doesn't really cause an
> interrupt; it doesn't jump to the appropriate place in the x86 vector
> table? Interesting.

int 80 does jump to the appropriate place in the vector table. In
arch/i386/kernel/traps.c: init_traps we have the line:

        set_system_gate(SYSCALL_VECTOR,&system_call);

Which sets up a trap gate in the vector table to jump to system_call
upon an "int 80", and this is exactly what I see.  It does not, however,
jump to sysenter_entry.  That would happen when sysenter is used instead
of "int 80".

When I use to work with a bunch of hardware folks, they would get mad at
me when I said a system call was initiated with an interrupt.  They
always told me that an interrupt was from an external source.  Anything
that the CPU causes itself (system call, page fault, etc) is called an
exception, or trap.  So I would try to use those definitions from then
on.  As a software guy though, I thought of them as the same thing.

-- Steve


