Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268329AbUIFQq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268329AbUIFQq6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 12:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268313AbUIFQq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 12:46:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:39395 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268351AbUIFQq3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 12:46:29 -0400
Date: Mon, 6 Sep 2004 09:46:22 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: James@superbug.demon.co.uk, dth@ncc1701.cistron.net,
       linux-kernel@vger.kernel.org
Subject: Re: Linux serial console patch
Message-Id: <20040906094622.6816784f.rddunlap@osdl.org>
In-Reply-To: <20040906165230.C30400@flint.arm.linux.org.uk>
References: <20040905175037.O58184@cus.org.uk>
	<413BA35C.8080705@superbug.demon.co.uk>
	<chhebr$pta$1@news.cistron.nl>
	<20040906114321.A26906@flint.arm.linux.org.uk>
	<413C8612.4010806@superbug.demon.co.uk>
	<20040906165230.C30400@flint.arm.linux.org.uk>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Sep 2004 16:52:30 +0100 Russell King wrote:

| On Mon, Sep 06, 2004 at 04:45:22PM +0100, James Courtier-Dutton wrote:
| > Russell King wrote:
| > > On Mon, Sep 06, 2004 at 10:32:27AM +0000, Danny ter Haar wrote:
| > > 
| > >>James Courtier-Dutton  <James@superbug.demon.co.uk> wrote:
| > >>
| > >>>>I have read your posts to lkml containing your serial console flow control
| > >>>>patches firstly for 2.4.x and then for 2.6.x kernels.
| > >>>
| > >>>Does this fix junk being output from the serial console?
| > >>>If one is using Pentium 4 HT, it seems that both CPU cores try to send 
| > >>>characters to the serial port at the same time, resulting in lost 
| > >>>characters as one CPU over writes the output from the other.
| > >>
| > >>We have multiple P4-HT enabled servers with debian installed & serial
| > >>console enabled (RPB++ ;-) and _i_ have never seen this behaviour.
| > > 
| > > 
| > > I don't think this is a serial problem as such, but a problem with the
| > > kernel console subsystem (printk) itself.  Maybe James can provide an
| > > example output to confirm exactly what he's seeing.
| > > 
| > 
| > http://www.superbug.demon.co.uk/latency/
| > 
| > There are 2 oops traces there. At about line 176, the corruption starts.
| 
| They both look like a two printk's overlapping each other, which isn't
| unreasonable since one is an oops.  We try real hard to get oopses
| out, which means "busting" the printk spinlocks.  The side effect of
| busting those spinlocks is of course no console locking.
| 
| It may be annoying, but unless some SMP person wants to fix the spinlock
| busting to be a little more inteligent, you can expect this situation
| to continue.

I've seen it enough times that I would like to see it fixed,
and David Howells (RH) has posted a patch for it several times.

I'm woondering if this:
http://linux.bkbits.net:8080/linux-2.5/diffs/kernel/printk.c@1.38?nav=index.html|src/|src/kernel|hist/kernel/printk.c
is supposed to be a patch for the problem in the 'latency' log above.
If so, it's not as good a solution as David Howells's patch is.
His latest (AFAIK) is:
http://marc.theaimsgroup.com/?l=linux-kernel&m=105730993512692&w=2

--
~Randy
