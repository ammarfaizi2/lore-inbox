Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278090AbRJPE6a>; Tue, 16 Oct 2001 00:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278524AbRJPE6V>; Tue, 16 Oct 2001 00:58:21 -0400
Received: from rj.sgi.com ([204.94.215.100]:30935 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S278090AbRJPE6M>;
	Tue, 16 Oct 2001 00:58:12 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Ryan Sweet <rsweet@atos-group.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: random reboots of diskless nodes - 2.4.7 (fwd) 
In-Reply-To: Your message of "Tue, 16 Oct 2001 02:28:46 +0200."
             <Pine.LNX.4.30.0110160228000.18043-100000@core-0> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 16 Oct 2001 14:58:37 +1000
Message-ID: <20123.1003208317@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2001 02:28:46 +0200 (CEST), 
Ryan Sweet <rsweet@atos-group.nl> wrote:
>Questions:
>- what the heck can I do to isolate the problem?

Debugger over a serial console.

>- why would the system re-boot instead of hanging on whatever caused it to
>crash (ie, why don't I see an oops message?)

Probably triple fault on ix86, which forces a reboot.  That is, a fault
was detected, trying to report the fault caused an error which caused a
third error.  Say goodnight, Dick.  The other main possibility is a
hardware or software watchdog that thinks the system has hung and is
forcing a reboot, do you have one of those?

>- how can I tell the system not to re-boot when it crashes (or is it
>crashing at all???)

If it is a triple fault, you have to catch the error before the third
fault.  Tricky.

>- is it worth trying all the newer kernel versions (this does not sound
>very appealing, especially given the troubles reported with 2.4.10 and
>also the split over which vm to use, etc..., also the changelogs don't
>really point to anything that appears to precisely describe my problem)?

Maybe.  OTOH if you wait until you capture some diagnostics it will
give you a better indication if the later kernels actually fix the
problem.

>- if I patch with kgdb and use a null modem connection from the gateway to
>run gdb can I expect to gain any useful info from a backtrace?

It is definitely worth trying kgdb or kdb[1] over a serial console.  I
am biased towards kdb (I maintain it) but either are worth a go.

Unfortunately the most common triple fault is a kernel stack overflow
and the ix86 kernel design has no way to recover from that error, the
error handler needs stack space to report anything, both kgdb and kdb
need stack space as well.  If you suspect stack overflow, look at the
IKD patch[2], it has code to warn about potential stack overflows
before they are completely out of hand.

[1] ftp://oss.sgi.com/projects/kdb/download/ix86, old for 2.4.7.
[2] ftp://ftp.kernel.org/pub/linux/kernel/people/andrea/ikd/

