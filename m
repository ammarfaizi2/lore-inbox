Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVAWAqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVAWAqS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 19:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVAWAqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 19:46:18 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:5215
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261170AbVAWAqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 19:46:07 -0500
Date: Sun, 23 Jan 2005 01:46:07 +0100
From: Andrea Arcangeli <andrea@cpushare.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Ingo Molnar <mingo@elte.hu>, Chris Wright <chrisw@osdl.org>,
       Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: seccomp for 2.6.11-rc1-bk8
Message-ID: <20050123004607.GJ7587@dualathlon.random>
References: <20050121093902.O469@build.pdx.osdl.net> <Pine.LNX.4.61.0501211338190.15744@chimarrao.boston.redhat.com> <20050121105001.A24171@build.pdx.osdl.net> <20050121195522.GA14982@elte.hu> <20050121203425.GB11112@dualathlon.random> <20050122103242.GC9357@elf.ucw.cz> <20050122172542.GF7587@dualathlon.random> <20050122194242.GB21719@elf.ucw.cz> <20050122233418.GH7587@dualathlon.random> <20050123000703.GC21719@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050123000703.GC21719@elf.ucw.cz>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-AA-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2005 at 01:07:04AM +0100, Pavel Machek wrote:
> Adding code is easy, but in the long term would lead to maintainance
> nightmare. Adding seccomp code that does subset of ptrace, just
> because ptrace audit is lot of work, seems like a wrong thing to
> do. Sorry.

Even if I do the ptrace audit right now, within 6 months something can
change and the implications of the changes won't be as trivial to
evaluate as if entry.S or seccomp.c have changed.

The userland side will be a lot more complicated too to implement.

Do you want video compressed strems to be played securely and
efficiently? I can't see a better solution than seccomp. ptrace would be
slower and it'd require ugly code to be written in userland. Streams
are going to pump some stuff into the pipes and this will avoid
quite a number of schedules per second (regardless of buffering). The
seccomp API is just tricky enough without having to hardcoded into every
userland app the number of the syscalls. Seccomp at least gives a slight
chance to write arch indipendent code while still providing lowlevel
security from the OS, there's no way to use ptrace_syscall in a arch
indipendent manner.

In the last patch I sent privately to Andrew I made it a config option,
but I recommend not to disable it, or you won't be able to run the
Cpushare client. Andrew's right seccomp.o would waste precious bytes
(not kbytes) on embedded systems, so it has to be a config option for
that. You can still modify it to use ptrace freely, but then I will have
nothing to do with the problems that may arise over time by using ptrace
within the GPL'd Cpushare client code and I personally do not approve
the use of ptrace there (but it's GPL so you can modify it).  I'm doing
something that I can trust to run on my own desktop system, and
personally seccomp is the only thing I'm confortable to depend on. Plus
the userland gets so much simpler as well. It's not only a problem of
trusting the kernel space of ptrace.
