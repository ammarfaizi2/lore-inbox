Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263734AbTLYUXV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 15:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263800AbTLYUXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 15:23:20 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:38641 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S263734AbTLYUXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 15:23:09 -0500
Subject: Re: 2.6.0 "Losing too many ticks!"
From: Albert Cahalan <albert@users.sf.net>
To: Giacomo Di Ciocco <admin@nectarine.info>
Cc: joe.korty@ccur.com, Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       wli@holomorphy.com
In-Reply-To: <3FEB28F1.80305@nectarine.info>
References: <1072321519.1742.328.camel@cube>
	 <20031225161748.GA31564@tsunami.ccur.com>  <3FEB28F1.80305@nectarine.info>
Content-Type: text/plain
Organization: 
Message-Id: <1072375533.1743.344.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 25 Dec 2003 13:05:34 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-12-25 at 13:14, Giacomo Di Ciocco wrote:
> Joe Korty wrote:
> 
>  > Or maybe IDE DMA is disabled. That would account for lost
>  > ticks during period of heavy disk IO.  Giacomo, type
>  >
>  >   hdparm /dev/hda
>  >
>  > If it shows 'using DMA' off, try
>  >
>  >   hdparm -d1 /dev/hda
>  >
>  > If that fails then the IDE driver you need is not
>  > configured in your kernel.
>  >
>  > Joe
> 
> Hi Joe,
> enabling the dma mode has resolved the "Losing too many ticks" thing, now the
> system seems running fine,

OK. So DMA must be on when HZ is 1000. Let's have
the kernel refuse to load the IDE driver w/o DMA
if HZ is over 100. Ha, ha, only serious... :-(

>  the unique strange thing is the "Unknown HZ value!
> (92) Assume 100." message, that appears before the output of any program launched.

Your clock is screwed. Reboot, or upgrade procps
to a version that can compensate. Version 3.1.15
from http://procps.sf.net/ is best.

Here's the release notes:

------------------------------------------------
[ANNOUNCE] procps 3.1.15

This release supports the NSA's high-security SELinux
on the 2.6.0 kernel, without any additional libraries
required. Thread support no longer sets off chkrootkit
on buggy 2.4.xx kernels. (the PID 0 problem) Now "top"
works on terminals with auto-margin problems.

For those of you still upgrading from procps 2.0.xx releases,
you can expect:

* ps fully supports thread display (H, -L, m, -m, and -T)
* ps can display NSA SELinux security contexts
* top can show CPU usage for IO-wait, IRQ, and softirq
* can set $PS_FORMAT to choose your own default ps format
* better width control ("ps -o pid,wchan:42,args")
* width of ps PID column adjusts to your system
* vmstat lets you choose units you like: 1000, 1024, 1000000...
* top can sort by any column (old sort keys available too)
* top can select a single user to display
* top can be put in multi-window mode and/or color mode
* vmstat has the -s option, as found on UNIX and BSD systems
* vmstat has the -f option, as found on UNIX and BSD systems
* watch doesn't eat the first blank line by mistake
* vmstat uses a fast O(1) algorithm on 2.5.xx kernels
* pmap command is SunOS-compatible
* vmstat shows IO-wait time
* pgrep and pkill can find the oldest matching process
* sysctl handles the Linux 2.5.xx VLAN interfaces
* ps has a new "-F" format (very nice, like DYNIX/ptx has)
* ps with proper BSD process selection
* better handling of very long uptimes

There's a procps-feedback@lists.sf.net mailing list you can
use for feature requests, bug reports, and so on. Use it!
Feedback makes things happen.

http://procps.sf.net/
http://procps.sf.net/procps-3.1.15.tar.gz

------------- recent changes -------------

procps-3.1.14 --> procps-3.1.15

hide kernel PID bug (Linux 2.4.13-pre1 to 2.4.MAX)   #217278 #219730 #217525 #224470
ps: faster threaded display
top: auto-margin problem                           #217559
ps: support NSA SELinux, all builds, Linux 2.6+    #193648
sysctl: tweak man page for ESR's broken parser

procps-3.1.13 --> procps-3.1.14

top: displays on more genuine serial terminals
handle 32-bit dev_t of Linux 2.6
ps: finally, m and -m satisfy the original design
ps: distinct per-thread and whole-process pending signals

procps-3.1.12 --> procps-3.1.13

ps: can display NPTL threads w/ kernel patch
no seLinux for now (new kernel interface)   

procps-3.1.11 --> procps-3.1.12

ps: explicit width ("ps -o pid,wchan:42,args")
ps: $PS_FORMAT works properly                    #201575
top: new Linux 2.6.0-test4 CPU stats shown
top: multiple -p options work again
top: fixed 4 GB wrap-around
ps: has a set of tests to ensure correctness
man page: /var/run/utmp, not /etc/utmp           #206583
required flags moved out of CFLAGS               #205429
RPM generation handles /lib64
WCHAN skips leading '.'
vmstat: numerous new features

procps-3.1.10 --> procps-3.1.11

compile with gcc 2.95 again (C99 issue)

procps-3.1.9 --> procps-3.1.10

handle GPLONLY_ symbols                       #143549 #188374
kill: better man page
skill: better man page
ps: PID-like columns change width as needed
top: COMMAND instead of Command
vmstat: -m displays slabinfo
vmstat: -d displays disk stats

------------------------------------------------------------


