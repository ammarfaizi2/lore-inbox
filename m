Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269457AbUJSPcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269457AbUJSPcl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 11:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269467AbUJSPcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 11:32:41 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:12866 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S269457AbUJSPcj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 11:32:39 -0400
Subject: Re: Fwd: [Bug 3592] New: pppd "IPCP: timeout sending
	Config-Requests"
From: Paul Fulghum <paulkf@microgate.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@redhat.com>
In-Reply-To: <1098195468.8467.7.camel@deimos.microgate.com>
References: <20041019131240.A20243@flint.arm.linux.org.uk>
	 <1098195468.8467.7.camel@deimos.microgate.com>
Content-Type: text/plain
Message-Id: <1098199942.2857.7.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 19 Oct 2004 10:32:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-19 at 09:17, Paul Fulghum wrote:
> This looks like the tty locking changes from Alan Cox.
> 
> The tty_io.c do_tty_hangup() no longer switches
> the line discipline back to N_TTY, so ppp_async.c
> is not aware of the hangup (ldisc->close not called).
> 
> The following is a snippet from tty_io.c:
> 
> 	/* Defer ldisc switch */
> 	/* tty_deferred_ldisc_switch(N_TTY);
> 	
> 	  This should get done automatically when the port closes and
> 	  tty_release is called */
> 
> I'll setup a test connection and verify this.

I have verified the problem as described above.

PPP line disciplines rely on the previous behavior
of calling ldisc->close on hangup as a method for
indicating hangup to the line discipline.
This is explicitly called out in the PPP ldisc comments.
Other line disciplines may also rely on this behavior.

Alan's changes also added the ldisc->hangup() method
to indicate hangup, but all the line disciplines
must be modified to implement this method.

-- 
Paul Fulghum
paulkf@microgate.com

