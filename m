Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318768AbSHBJrE>; Fri, 2 Aug 2002 05:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318771AbSHBJrE>; Fri, 2 Aug 2002 05:47:04 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:8608 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S318768AbSHBJrD>; Fri, 2 Aug 2002 05:47:03 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200208020950.g729o3K28069@devserv.devel.redhat.com>
Subject: Re: Accelerating user mode linux
To: jdike@karaya.com (Jeff Dike)
Date: Fri, 2 Aug 2002 05:50:03 -0400 (EDT)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <200208020440.XAA04793@ccure.karaya.com> from "Jeff Dike" at Aug 01, 2002 11:40:28 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> can't be an interrupt in the middle of that sequence.  So, sys_switchmm
> would also have to restore the old signal mask, which you'd have to pass
> in unless you're going to read it off the signal frame.  Also, it would
> have to be open coded because you've already restored the stack pointer.

Uggh.. you are right. You end up needing sigreturn handling

> Your objection to returning through sigreturn was performance.  Is performance
> a veto of adding an mm switch to sigreturn, or it is possible to make it
> acceptible?

Its not a veto. I was trying to avoid having to add any more branches to
the fast paths in the kernel.  The remaining sigreturn question is 
"how do you get into 'user' mode the first time"
