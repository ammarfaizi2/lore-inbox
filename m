Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264729AbSLPFNG>; Mon, 16 Dec 2002 00:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264755AbSLPFNG>; Mon, 16 Dec 2002 00:13:06 -0500
Received: from mrmorr.lnk.telstra.net ([139.130.12.153]:52997 "EHLO
	cheesypoof.guarana.org") by vger.kernel.org with ESMTP
	id <S264729AbSLPFNF>; Mon, 16 Dec 2002 00:13:05 -0500
Date: Mon, 16 Dec 2002 16:21:00 +1100
From: Kevin Easton <kevin@sylandro.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 st + aic7xxx (Adaptec 19160B) + VIA KT333 repeatable freeze
Message-ID: <20021216052100.GC30613@guarana.org>
References: <20021216035226.GA30613@guarana.org> <8477.1040014052@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8477.1040014052@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2002 at 03:47:32PM +1100, Keith Owens wrote:
> On Mon, 16 Dec 2002 14:52:26 +1100, 
> caf@guarana.org wrote:
> >Running with nmi_watchdog=2 has made the problem a bit harder to
> >reproduce[1], but when it does hang it doesn't produce a trace (I left it
> >for several minutes just in case..).  Checking /proc/interrupts after 
> >boot shows around 16 NMIs, which I presume means that it's being used? -
> >although it didn't seem to be going up at anything like once every 5
> >seconds.
> 
> nmi_watchdog=2 should pop once per second, nmi_watchdog=1 pops HZ
> (usually 100) times per second.  Anything less than once a second is
> not working.  One possibility is CONFIG_X86_UP_APIC, it should be y for
> UP to use nmi_watchdog.

Interesting - I do have CONFIG_X86_UP_APIC set, and the nmi_watchdog is
doing _something_, because without it on the kernel commandline I get 0
NMIs.

> >Is it possible that I'm not seeing the trace because I'm using a VGA
> >virtual console rather than a real serial console?
> 
> Depends on your boot parameters for console and the levels of console
> printk.  Console output to X is unlikely to work, output to VGA
> (including virtual consoles) should work.  Except that some
> distributions change printk levels and even redirect output to a
> different virtual console.
> 
> cat /proc/cmdline should have no console setting or 'console=tty0'.
> Change boot options and reboot if necessary.
> 
> cat /proc/sys/kernel/printk should report 6 4 1 7, if not then
> echo "6 4 1 7" > /proc/sys/kernel/printk

Ahh, that could be a problem, my system's default is "7 4 1 7".

	- Kevin.
