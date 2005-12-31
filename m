Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbVLaNFD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbVLaNFD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 08:05:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbVLaNFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 08:05:03 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:13068 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751078AbVLaNFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 08:05:01 -0500
Date: Sat, 31 Dec 2005 14:01:52 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chris Stromsoe <cbs@cts.ucla.edu>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: bad pmd filemap.c, oops; 2.4.30 and 2.4.32
Message-ID: <20051231130151.GA15993@alpha.home.local>
References: <Pine.LNX.4.64.0512270844080.14284@potato.cts.ucla.edu> <20051228001047.GA3607@dmt.cnet> <Pine.LNX.4.64.0512281806450.10419@potato.cts.ucla.edu> <Pine.LNX.4.64.0512301610320.13624@potato.cts.ucla.edu> <Pine.LNX.4.64.0512301732170.21145@potato.cts.ucla.edu> <1136030901.28365.51.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136030901.28365.51.camel@localhost.localdomain>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Sat, Dec 31, 2005 at 12:08:21PM +0000, Alan Cox wrote:
> On Gwe, 2005-12-30 at 17:48 -0800, Chris Stromsoe wrote:
> > scsi0:0:0:0: Attempting to queue an ABORT message
> > CDB: 0x12 0x0 0x0 0x0 0xff 0x0
> > scsi0:0:0:0: Command already completed
> > aic7xxx_abort returns 0x2002
> 
> IRQ routing by the look of that trace. Make sure that if you are using
> 2.4.x you have ACPI disabled and see it looks any better

Correct, and I came to the same conclusion ; Chris told us he booted with
the "nosmp" option. I've checked his config, and he has CONFIG_ACPI_BOOT=y.
I've just tried the same here, and I confirm that my machine (dual athlon)
does not boot with "nosmp" unless I also add "acpi=off". Mine even stops
ealier, while scanning IDE devices.

So now we're back to the original problem, i.e. why does he get bad pmd
that often on 2.4. It leaves us with the following possible next steps
after the problem occurs again (if it still happens with 2.6.14 or if
Chris is OK for a few more tests) :
  - 2.4.32 nosmp acpi=off       => the easiest one
  - 2.4.32 + aic7xxx+20040522   => the more interesting one

Regards,
Willy

