Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262777AbTKVWQl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 17:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbTKVWQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 17:16:41 -0500
Received: from ozlabs.org ([203.10.76.45]:59308 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262777AbTKVWQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 17:16:40 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16319.57610.204577.206796@cargo.ozlabs.ibm.com>
Date: Sun, 23 Nov 2003 09:19:54 +1100
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86: SIGTRAP handling differences from 2.4 to 2.6
In-Reply-To: <Pine.LNX.4.44.0311221044480.2379-100000@home.osdl.org>
References: <87k75ss1eb.fsf@noetbook.telent.net>
	<Pine.LNX.4.44.0311221044480.2379-100000@home.osdl.org>
X-Mailer: VM 7.17 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

>    ... In 2.6.x, trying to block 
>    a thread-synchronous signal will just cause the process to be killed 
>    with that signal ("it can't be delivered, it can't be ignored, let's 
>    just tell the user")

Occasionally I have had a situation where the init process hits an
instruction fault (often because of a kernel bug, actually), such as
an access to a bad address.  On embedded platforms we sometimes get
the situation where init uses floating-point instructions but the CPU
doesn't have floating point and the kernel has been compiled without
FP emulation.  In these situations the system looks like it just
hangs, since init is doing nothing but take the same signal over and
over again.

In this case the signal would not actually be set to be blocked or
ignored but would end up being ignored because of the rule that "init
gets no signals it doesn't want".  I would prefer to see
thread-synchronous signals kill init if they are not handled, so that
at least we get a panic with a message that says what went wrong
rather than the system just spinning its wheels uselessly.

Regards,
Paul.
