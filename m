Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbTJIV6m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 17:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbTJIV6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 17:58:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:54735 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262609AbTJIV6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 17:58:40 -0400
Date: Thu, 9 Oct 2003 14:58:39 -0700
From: Chris Wright <chrisw@osdl.org>
To: Martin Aspeli <optilude@gmx.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Horrible ordeals with ACPI, APIC and HIGHMEM (2.6.0-test* and -ac kernels)
Message-ID: <20031009145839.A18072@build.pdx.osdl.net>
References: <oprwsg9wfc9y0cdf@mail.gmx.net> <20031009140523.A18065@build.pdx.osdl.net> <oprwsoirf09y0cdf@mail.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <oprwsoirf09y0cdf@mail.gmx.net>; from optilude@gmx.net on Thu, Oct 09, 2003 at 10:26:41PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Martin Aspeli (optilude@gmx.net) wrote:
> On Thu, 9 Oct 2003 14:05:23 -0700, Chris Wright <chrisw@osdl.org> wrote:
> 
> > Which 2.6.0-test kernels?  Have you tried 2.6.0-test7?  A fix for this
> > type of problem went into -test7.
> 
> Sadly, yes. My most recent and most comprehensive tests (today) were with 
> the -test7 kernel. Could you give me some details as to what the fix is 
> supposed to do and why it may not work?

fixes acpi pci link allocation which could pick a bad irq causing an
interrupt storm.  typical symptom was hang on boot.  

If you see:

ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 10 *11 12)
...
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 6

where the link is not enabled at the current setting (11 in this case,
marked by *), you might experience this kind of hang.

> Also, I'd still be interested to know - what is "events/0"?

events/0 is a kernel thread (keventd) used for scheduling work into process
context.  acpi uses keventd for handling acpi events, for example, so
runaway apci events will cause events/0 to chew up cpu.

> And why do 
> things run like a 286 when I enable HIGHMEM? 

I don't know, it shouldn't.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
