Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751955AbWAEFoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751955AbWAEFoU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 00:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751956AbWAEFoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 00:44:19 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:30988 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751955AbWAEFoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 00:44:19 -0500
Date: Thu, 5 Jan 2006 06:43:48 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Chris Stromsoe <cbs@cts.ucla.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: bad pmd filemap.c, oops; 2.4.30 and 2.4.32
Message-ID: <20060105054348.GA28125@w.ods.org>
References: <Pine.LNX.4.64.0512270844080.14284@potato.cts.ucla.edu> <20051228001047.GA3607@dmt.cnet> <Pine.LNX.4.64.0512281806450.10419@potato.cts.ucla.edu> <Pine.LNX.4.64.0512301610320.13624@potato.cts.ucla.edu> <Pine.LNX.4.64.0512301732170.21145@potato.cts.ucla.edu> <1136030901.28365.51.camel@localhost.localdomain> <20051231130151.GA15993@alpha.home.local> <Pine.LNX.4.64.0601041402340.28134@potato.cts.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601041402340.28134@potato.cts.ucla.edu>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 07:52:36PM -0800, Chris Stromsoe wrote:
> On Sat, 31 Dec 2005, Willy Tarreau wrote:
> >On Sat, Dec 31, 2005 at 12:08:21PM +0000, Alan Cox wrote:
> >>On Gwe, 2005-12-30 at 17:48 -0800, Chris Stromsoe wrote:
> >>>scsi0:0:0:0: Attempting to queue an ABORT message CDB: 0x12 0x0 0x0 
> >>>0x0 0xff 0x0 scsi0:0:0:0: Command already completed aic7xxx_abort 
> >>>returns 0x2002
> >>
> >>IRQ routing by the look of that trace. Make sure that if you are using 
> >>2.4.x you have ACPI disabled and see it looks any better
> >
> >Correct, and I came to the same conclusion ; Chris told us he booted 
> >with the "nosmp" option. I've checked his config, and he has 
> >CONFIG_ACPI_BOOT=y. I've just tried the same here, and I confirm that my 
> >machine (dual athlon) does not boot with "nosmp" unless I also add 
> >"acpi=off". Mine even stops ealier, while scanning IDE devices.
> 
> 2.6.14.4 has been running stable for 4 days.  For the long term, I'll 
> probably migrate the box to 2.6 and leave it there.
> 
> >So now we're back to the original problem, i.e. why does he get bad pmd
> >that often on 2.4. It leaves us with the following possible next steps
> >after the problem occurs again (if it still happens with 2.6.14 or if
> >Chris is OK for a few more tests) :
> > - 2.4.32 nosmp acpi=off       => the easiest one
> > - 2.4.32 + aic7xxx+20040522   => the more interesting one
> 
> I booted 2.4.32 with the aic7xxx patch you pointed me at last week.  It's 
> been up for a few hours.  I'll let it run for at least a week or two and 
> will report back positive or negative results.  After that, I'll try 
> 2.4.32 with nosmp and acpi=off.

Thanks for your continued feedback, Chris. Your reports are very helpful,
they tend to prove that your hardware is OK and that there's a bug in
mainline 2.4.32 with SMP+ACPI+aic7xxx enabled. That's already a good
piece of information.

> -Chris

Regards,
Willy

