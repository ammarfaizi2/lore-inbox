Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266417AbTAOOGj>; Wed, 15 Jan 2003 09:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266425AbTAOOGj>; Wed, 15 Jan 2003 09:06:39 -0500
Received: from [65.193.106.66] ([65.193.106.66]:65048 "EHLO
	xchangeserver2.storigen.com") by vger.kernel.org with ESMTP
	id <S266417AbTAOOGi> convert rfc822-to-8bit; Wed, 15 Jan 2003 09:06:38 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: VIA C3 and random SIGTRAP or segfault
Date: Wed, 15 Jan 2003 09:15:29 -0500
Message-ID: <7BFCE5F1EF28D64198522688F5449D5AC63352@xchangeserver2.storigen.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: VIA C3 and random SIGTRAP or segfault
Thread-Index: AcK8kamBl5aKQjVHS96sjeIrnKt7hwADm9xA
From: "Larry Sendlosky" <Larry.Sendlosky@storigen.com>
To: "Dave Jones" <davej@codemonkey.org.uk>,
       "Miklos Szeredi" <Miklos.Szeredi@eth.ericsson.se>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We're seeing the same thing on a mini-ITX based system.
init is segfaulting :(( .  We've never seen this on our
other non-C3 systems running the same codebase. We've instrumented
the kernel to help catch the initial problem, hopefully it will
trigger soon.

Dave, will the cmov generate a segfault or illegal instr trap (SIGILL?) ?

thanks
larry



-----Original Message-----
From: Dave Jones [mailto:davej@codemonkey.org.uk]
Sent: Wednesday, January 15, 2003 7:23 AM
To: Miklos Szeredi
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA C3 and random SIGTRAP or segfault


On Wed, Jan 15, 2003 at 10:29:01AM +0100, Miklos Szeredi wrote:
 > 
 > I just bought a VIA C3 866 processor, and under very special
 > circumstances some programs (e.g. mplayer, xmms) randomly crash with
 > trace/breakpoint trap or segmentation fault.  Otherwise the system
 > seems stable even under high load.

Be sure that those programs aren't compiled for 686. The C3 lacks
cmov, so it'll segfault when it hits that opcode. You can confirm
this by running it under gdb, and disassembling where it segv's to.
This is still a common problem thats biting some people. The debian
folks had a broken libssl for months up until recently.

Note to userspace developers: If you're compiling something as
a 686 binary, you *NEED* to check the feature flags (in an i386
compiled program) to see if the CPU has cmov before you load 686
optimised parts of your app.  This is *NOT* a kernel problem,
it is *NOT* a CPU bug. The cmov extension is optional.
VIA chose to save silicon space by not implementing it. 
Gcc unfortunatly always uses cmov when compiling for 686.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

