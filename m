Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267250AbUJRSAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267250AbUJRSAl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 14:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267259AbUJRSAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 14:00:38 -0400
Received: from cantor.suse.de ([195.135.220.2]:47810 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267250AbUJRSAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 14:00:30 -0400
Date: Mon, 18 Oct 2004 20:00:17 +0200
From: Andi Kleen <ak@suse.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: bevand_m@epita.fr, linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: NMI watchdog detected lockup
Message-Id: <20041018200017.0098710d.ak@suse.de>
In-Reply-To: <4173F9A7.2090504@osdl.org>
References: <4172F91D.8090109@osdl.org>
	<ckv123$pcs$1@sea.gmane.org>
	<4173F9A7.2090504@osdl.org>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2004 10:13:11 -0700
"Randy.Dunlap" <rddunlap@osdl.org> wrote:

> Marc Bevand wrote:
> > On 2004-10-17, Randy.Dunlap <rddunlap@osdl.org> wrote:
> > | 
> > |  I'm seeing this often during a kernel build on AIC79xx.
> > |  I did one kernel build on SATA without seeing this.
> > |  This is on a dual-Opteron IBM Workstation A with
> > |  2 GB RAM, SATA, & SCSI.
> > |  [...]
> > |  NMI Watchdog detected LOCKUP on CPU0, registers:
> > |  [...]
> > 
> > You are not the first one to observe frequent watchdog timeout
> > lockup on dual Opteron systems during intense I/O operations,
> > see this thread:
> > 
> >   http://thread.gmane.org/gmane.linux.ide/1933
> > 
> > Note: this does *not* seem to be SATA-related.
> 
> Hi,
> 
> Zwane suspected NMI spikes and advised me to disable nmi_watchdog
> (nmi_watchdog=0).  After doing that, a kernel build completes
> successfully, although with many messages like these:
> 
> Uhhuh. NMI received for unknown reason 21.

Something on your system creates bogus NMI interrupts. What chipset
are you using exactly?

Sometimes chipsets can be programmed to raise NMIs when an PCI bus
error occurs. 

21 is the normal state (PIT timer running, but no errors logged) 

If you have an AMD 8131 it could be in theory erratum 54, but then
normally one of the error bits in reason should be set.

-Andi

