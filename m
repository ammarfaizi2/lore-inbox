Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263064AbUDRJ3w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 05:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbUDRJ3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 05:29:52 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:35340 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263064AbUDRJ3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 05:29:51 -0400
Date: Sun, 18 Apr 2004 10:29:47 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Marc Singer <elf@buici.com>
Cc: Andrew Morton <akpm@osdl.org>, wli@holomorphy.com,
       linux-kernel@vger.kernel.org
Subject: Re: vmscan.c heuristic adjustment for smaller systems
Message-ID: <20040418102947.A5745@flint.arm.linux.org.uk>
Mail-Followup-To: Marc Singer <elf@buici.com>,
	Andrew Morton <akpm@osdl.org>, wli@holomorphy.com,
	linux-kernel@vger.kernel.org
References: <20040417193855.GP743@holomorphy.com> <20040417212958.GA8722@flea> <20040417162125.3296430a.akpm@osdl.org> <20040417233037.GA15576@flea> <20040417165151.24b1fed5.akpm@osdl.org> <20040418002343.GA16025@flea>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040418002343.GA16025@flea>; from elf@buici.com on Sat, Apr 17, 2004 at 05:23:43PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2004 at 05:23:43PM -0700, Marc Singer wrote:
> All of these tests are performed at the console, one command at a
> time.  I have a telnet daemon available, so I open a second connection
> to the target system.  I run a continuous loop of file copies on the
> console and I execute 'ls -l /proc' in the telnet window.  It's a
> little slow, but it isn't unreasonable.  Hmm.  I then run the copy
> command in the telnet window followed by the 'ls -l /proc'.  It works
> fine.  I logout of the console session and perform the telnet window
> test again.  The 'ls -l /proc takes 30 seconds.
> 
> When there is more than one process running, everything is peachy.
> When there is only one process (no context switching) I see the slow
> performance.  I had a hypothesis, but my test of that hypothesis
> failed.

Guys, this tends to indicate that we _must_ have up to date aging
information from the PTE - if not, we're liable to miss out on the
pressure from user applications.  The "lazy" method which 2.4 will
allow is not possible with 2.6.

This means we must flush the TLB when we mark the PTE old.

Might be worth reading my thread on linux-mm about this and commenting?
(hint hint)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
