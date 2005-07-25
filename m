Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261754AbVGYIEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbVGYIEU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 04:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbVGYIEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 04:04:20 -0400
Received: from ms005msg.fastwebnet.it ([213.140.2.50]:11661 "EHLO
	ms005msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S261754AbVGYIES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 04:04:18 -0400
Date: Mon, 25 Jul 2005 10:02:54 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Lack of Documentation about SA_RESTART...
Message-ID: <20050725100254.4b27279e@localhost>
In-Reply-To: <20050724145608.GA6132@thunk.org>
References: <20050711123237.787dfcde@localhost>
	<20050711143427.GC14529@thunk.org>
	<Pine.LNX.4.58.0507231723270.6074@g5.osdl.org>
	<20050724145608.GA6132@thunk.org>
X-Mailer: Sylpheed-Claws 1.0.4a (GTK+ 1.2.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jul 2005 10:56:08 -0400
Theodore Ts'o <tytso@mit.edu> wrote:

> The spect says "unless otherwise specified".  The description for
> pause() states that the process will sleep until receiving a signal
> that terminates the process or causes it to call signal-handling
> function.  That would presumably count as an "otherwise specified".

I don't think that way for at least 2 reasons:


1) SA_RESTART is an XSI extension, so every exception to the rule
"everything automatically restarted" should be under an XSI section
(like it is on the "select()" page).


2) The same thing that you claim for "pause()" (that isn't restarted)
can be claimed for other syscalls that _ARE_ restarted.

Example: wait()

SUSV3 DOC: "... The wait() function shall suspend execution of the
calling thread until status information for one of the terminated child
processes of the calling process is available, or until delivery of a
signal whose action is either to execute a signal-catching function or
to terminate the process ..."

And wait() is actually RESTARTED because:

	- it makes sense
	- FreeBSD sigaction() mapage says it is retarted

	- Linux does it (see kernel/exit.c)

	...
                retval = -ERESTARTSYS;
                if (signal_pending(current))
                        goto end;
	...


See?

-- 
	Paolo Ornati
	Linux 2.6.13-rc3 on x86_64
