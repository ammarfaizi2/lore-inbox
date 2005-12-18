Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932692AbVLRJ01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932692AbVLRJ01 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 04:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932693AbVLRJ00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 04:26:26 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:18698 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932692AbVLRJ00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 04:26:26 -0500
Date: Sun, 18 Dec 2005 09:26:16 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nicolas Pitre <nico@cam.org>, David Howells <dhowells@redhat.com>,
       Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org,
       lkml <linux-kernel@vger.kernel.org>, mingo@redhat.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/12]: MUTEX: Implement mutexes
Message-ID: <20051218092616.GA17308@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Nicolas Pitre <nico@cam.org>, David Howells <dhowells@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org,
	lkml <linux-kernel@vger.kernel.org>, mingo@redhat.com,
	Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.64.0512162334440.3698@g5.osdl.org> <dhowells1134774786@warthog.cambridge.redhat.com> <200512162313.jBGND7g4019623@warthog.cambridge.redhat.com> <1134791914.13138.167.camel@localhost.localdomain> <14917.1134847311@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0512171201200.3698@g5.osdl.org> <Pine.LNX.4.64.0512172018410.26663@localhost.localdomain> <Pine.LNX.4.64.0512171803580.3698@g5.osdl.org> <Pine.LNX.4.64.0512172150260.26663@localhost.localdomain> <Pine.LNX.4.64.0512172227280.3698@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512172227280.3698@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2005 at 10:30:41PM -0800, Linus Torvalds wrote:
> An interrupt can never change the value without changing it back, except 
> for the old-fashioned use of "up()" as a completion (which I don't think 
> we do any more - we used to do it for IO completion a looong time ago).

I doubt you can guarantee that statement, or has the kernel source
been audited for this recently?

However, the real consideration is stability - if a semaphore was
used for a completion and it was merged, would it be found and
fixed?  Probably not, because it won't cause any problems on
architectures where semaphores have atomic properties.  Unless
of course sparse can be extended to detect the use of unbalanced
semaphores in interrupt contexts.

> (Of course, maybe it's not worth it. It might not be a big performance 
> issue).

Balancing the elimination of 4 instructions per semaphore operation,
totalling about 4 to 6 cycles, vs stability I'd go for stability
unless we can prove the above assertion via (eg) sparse.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
