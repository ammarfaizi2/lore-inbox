Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277348AbRJELI0>; Fri, 5 Oct 2001 07:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277349AbRJELII>; Fri, 5 Oct 2001 07:08:08 -0400
Received: from main.braxis.co.uk ([213.77.40.29]:33030 "EHLO main.braxis.co.uk")
	by vger.kernel.org with ESMTP id <S277348AbRJELIA>;
	Fri, 5 Oct 2001 07:08:00 -0400
Date: Fri, 5 Oct 2001 13:07:22 +0200
From: Krzysztof Rusocki <kszysiu@main.braxis.co.uk>
To: linux-xfs@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: %u-order allocation failed
Message-ID: <20011005130722.A6570@main.braxis.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

After simple bash fork bombing (about 200 forks) on my UP Celeron/96MB
I get quite a lot %u-allocations failed, but only when swap is
turned off.

When it's turned on, processes are still forking for some time
until i get messages like 'fork: Resource temporarily unavailable' or
'cannot redirect /dev/null: too many open files in system' (or similar)
and also 'cannot load libdl.so blah blah return code 23' (don't remember
exact message)... load goes up to about 700 but _none_ of processess
get killed. Machine is almost unresponsible that time... i hardly managed
to Alt+SysRQ+UB ...

As mentioned in some other mail - no highmem, no lvm, md as module (unused).
2.4.10-xfs cvs co 25th September (not 12th :/ - info in previous mail was
incorrect)

When swap was off first i got some of
0-order (gfp=0x1d2/0) from c012ac08  (_alloc_pages+24)
beside it, in a few seconds also noticed
0-order (gfp=0x1f0/0) from c012ac08
0-order (gfp=0xf0/0) from c012ac08
at random order....
I also saw a really small number of
1-order (gfp=0x1f0/0) from c012ac08

During that time almost all processess were killed by VM, machine
was more responsible so i could freely do Alt+SysRQ+K and everything
went back to normal...

I'm not familiar with LinuxVM.. so... is it normal behaviour ? or (if not)
what's happening when such messages are printed my kernel ?

Cheers,
Krzysztof

PS
lkml people - please CC, ain't subscribing.
