Return-Path: <linux-kernel-owner+w=401wt.eu-S1755366AbXABQjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755366AbXABQjb (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 11:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755373AbXABQjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 11:39:31 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2988 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755366AbXABQja (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 11:39:30 -0500
Date: Tue, 2 Jan 2007 16:39:23 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [ARM] Regression somewhere between 2.6.19 and 2.6.19-rc1
Message-ID: <20070102163923.GB12902@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing utterly random behaviour from kernels on ARM SMP hardware
built after 2.6.19.  I won't bother trying to paste the kernel output;
sometimes the kernel locks solid (no IRQs, no output to say what's wrong).
Other times I get the first line of an oops repeating but with random
addresses.  Othertimes the oops doesn't complete.

2.6.19 runs fine.

So I just tried using git bisect to track down the problem.  First issue
that presky cmpxchg() causing a build error.  Ok, so I provide a version
to get around that.

Next problem:

fs/proc/proc_misc.c: In function `version_read_proc':
fs/proc/proc_misc.c:256: warning: implicit declaration of function `utsname'
fs/proc/proc_misc.c:256: error: invalid type argument of `->'
fs/proc/proc_misc.c:256: error: invalid type argument of `->'
make[3]: *** [fs/proc/proc_misc.o] Error 1
make[2]: *** [fs/proc] Error 2
make[1]: *** [fs] Error 2
make: *** [uImage] Error 2

It seems this breakage seems to have been introduced some 260-odd commits
prior to the point which git bisect wants me to test.

How do I tell git bisect "I can't test this, this is neither good nor bad,
please choose another to try" ?  Or is git bisect hopeless given the large
amount of unbuildable commits thanks to our weekly merges?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
