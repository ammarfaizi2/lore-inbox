Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbTKOAbf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 19:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbTKOAbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 19:31:35 -0500
Received: from fw.osdl.org ([65.172.181.6]:39650 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261190AbTKOAbe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 19:31:34 -0500
Date: Fri, 14 Nov 2003 16:31:31 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
cc: trini@kernel.crashing.org, <benh@kernel.crashing.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PPC32: cancel syscall restart on signal delivery
In-Reply-To: <Pine.LNX.4.44.0311141612220.2214-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0311141624360.2214-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 14 Nov 2003, Linus Torvalds wrote:
> 
> On x86, for the old calling conventions (ie "int 0x80"), that meant that 
> the interrupt window was literally a single instruction. For the new one 
> ("sysenter") it was two instructions.

Actually, three instructions for "sysenter": the "movl %esp,%ebp" and the
actual "sysenter" instruction itself are the main restart sequence, but to 
make it look the same as the legacy code from a kernel restart standpoint 
there is also a short backwards jump there.

Anyway, you can't even trigger it with the single-step flag, since the
kernel will disable single-stepping in sysenter (and it only gets
re-enabled once the system call is done - including retries).

Since it literally requires an external interrupt to happen, it would be 
pretty hard to create a test-case for. Maybe a dual-CPU setup with the 
other CPU sending a signal (and the interrupt is the resultant IPI) at 
just the right moment..

		Linus

