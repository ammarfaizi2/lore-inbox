Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbVLaHOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbVLaHOu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 02:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbVLaHOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 02:14:50 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:8716 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751315AbVLaHOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 02:14:50 -0500
Date: Sat, 31 Dec 2005 08:12:16 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Chris Stromsoe <cbs@cts.ucla.edu>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: bad pmd filemap.c, oops; 2.4.30 and 2.4.32
Message-ID: <20051231071215.GX15993@alpha.home.local>
References: <Pine.LNX.4.64.0512270844080.14284@potato.cts.ucla.edu> <20051228001047.GA3607@dmt.cnet> <Pine.LNX.4.64.0512281806450.10419@potato.cts.ucla.edu> <Pine.LNX.4.64.0512301610320.13624@potato.cts.ucla.edu> <Pine.LNX.4.64.0512301732170.21145@potato.cts.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512301732170.21145@potato.cts.ucla.edu>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Dec 30, 2005 at 05:48:15PM -0800, Chris Stromsoe wrote:
> I'm starting to suspect bad hardware.  Booting is now hanging (with 
> 2.4.27, 2.4.30 and 2.4.32) after scsi drivers load:

And nothing changed since previous boot, except UP ?

(...) 
> If I wait several minutes (around 10 or 15 minutes), I get:
> 
> scsi0:0:0:0: Attempting to queue an ABORT message
> CDB: 0x12 0x0 0x0 0x0 0xff 0x0
> scsi0:0:0:0: Command already completed
> aic7xxx_abort returns 0x2002
> scsi0:0:0:0: Attempting to queue an ABORT message
> CDB: 0x0 0x0 0x0 0x0 0x0 0x0
> scsi0:0:0:0: Command already completed
> aic7xxx_abort returns 0x2002
> scsi0:0:0:0: Attempting to queue a TARGET RESET message
> CDB: 0x12 0x0 0x0 0x0 0xff 0x0
> scsi0:0:0:0: Is not an active device
> aic7xxx_dev_reset returns 0x2002
> scsi0:0:0:0: Attempting to queue an ABORT message
> CDB: 0x0 0x0 0x0 0x0 0x0 0x0
> scsi0:0:0:0: Command already completed
> aic7xxx_abort returns 0x2002
> scsi0:0:0:0: Attempting to queue an ABORT message
> CDB: 0x0 0x0 0x0 0x0 0x0 0x0
> scsi0:0:0:0: Command already completed
> aic7xxx_abort returns 0x2002
> scsi: device set offline - not ready or command retry failed after bus 
> reset: host 0 channel 0 id 0 lun 0
> 
> 
> The messages repeated for all 15 targets on scsi0.  It's looking like it 
> will repeat for scsi1 as well.
(...)

it recalls me bad memories on my machine a very long time ago when the
driver was buggy :-(
It's not necessarily bad hardware. I also had trouble on one version
of the 29160 bios where it hanged during device scan if there were
too many terminations. Oh, BTW, please check that you have disabled
"automatic" termination in the BIOS. Manually set it either to ON or
OFF (low/high depending on your setup).

> How likely is it that a failing scsi controller contribute to the other 
> problems I was seeing?

Not much. Perhaps at worst, a failing controller could corrupt memory
by writing garbage at wrong locations, but you would not always get
the same messages. It seems to be a different problem here. To be
honnest, it's where I think you should try the new driver.

Regards,
Willy

