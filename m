Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268021AbUI1SbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268021AbUI1SbO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 14:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268028AbUI1SbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 14:31:14 -0400
Received: from bender.bawue.de ([193.7.176.20]:42124 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S268021AbUI1SbK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 14:31:10 -0400
Date: Tue, 28 Sep 2004 20:31:03 +0200
From: Joerg Sommrey <jo175@sommrey.de>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: nmi watchdog failure on dual Athlon box
Message-ID: <20040928183103.GA10593@sommrey.de>
Mail-Followup-To: Joerg Sommrey <jo175@sommrey.de>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040928163324.GA5759@sommrey.de> <Pine.LNX.4.58L.0409281802270.32231@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0409281802270.32231@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2004 at 06:08:37PM +0100, Maciej W. Rozycki wrote:
> On Tue, 28 Sep 2004, Joerg Sommrey wrote:
> 
> > just tried Ingo's "lockupcli" nmi watchdog test - it fails to unlock the
> > box.
> > 
> > boot-parm:
> > ...nmi_watchdog=2...
> 
>  The local APIC NMI watchdog has limited capabilities.  It may fail to 
> trigger for certain lockups because there is no available event that would 
> happen periodically regardless of the CPU state.  I can only suspect what 
> "lockupcli" does (where is it available from, anyway?), but if it runs 
> "cli; hlt", then the watchdog *will* fail.

Here's the quote from Ingo's mail:
In <2Jo20-7ry-33@gated-at.bofh.it> Ingo Molnar <mingo@elte.hu> writes:
|once the NMI watchdog is up and running it should catch all hard lockups
|and print backtraces to the serial console - even if you are within X
|while the lockup happens. You can test hard lockups by running the
|attached 'lockupcli' userspace code as root - it turns off interrupts
|and goes into an infinite loop => instant lockup. The NMI watchdog
|should notice this condition after a couple of seconds and should abort
|the task, printing a kernel trace as well. Your box should be back in
|working order after that point.

[...]

|--- lockupcli.c
|
|main ()
|{
|	iopl(3);
|	for (;;) asm("cli");
|}

Does this mean there is a good reason for further investigations on why
the IO-APIC NMI watchdog doesn't work? Until now I thought it would
be ok as long as the local APIC NMI watchdog is set up.

-jo

-- 
-rw-r--r--  1 jo users 63 2004-09-28 18:42 /home/jo/.signature
