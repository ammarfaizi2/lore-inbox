Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271723AbTGXRBb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 13:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271724AbTGXRBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 13:01:31 -0400
Received: from magic-mail.adaptec.com ([208.236.45.100]:3727 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S271723AbTGXRA4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 13:00:56 -0400
Date: Thu, 24 Jul 2003 11:17:41 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Tugrul Galatali <tugrul@galatali.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 Adaptec aic7899 Ultra160 SCSI grief
Message-ID: <1369182704.1059067061@aslan.btc.adaptec.com>
In-Reply-To: <5F99705E-BDC8-11D7-9859-000A957CBE4C@galatali.com>
References: <5F99705E-BDC8-11D7-9859-000A957CBE4C@galatali.com>
X-Mailer: Mulberry/3.1.0b3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	After months of using 2.5.x with stability on my box, and using
> 2.6.0-test1 since the day after its release (with the 20030714 ACPI patch),
> I had two seemingly random SCSI hangs today. One shortly after I booted the
> box in the afternoon, and one after about 15 hours of uptime. I was busy the
> first time around, but the second time I managed to scp out a copy of the
> current dmesg to another box before a hard power down.
> 
> 	Can somebody translate the error in the dmesg into english and advise
> me on whether I want to change something in the software or the hardware?

What the controller is saying is that the drive attempted to complete
a command it knew nothing about.  At the time of the failure, the only
command outstanding on the device had tag identifier 0x3c.  The drive
came back with a tag identifier of 0x20.  This looks like a drive
firmware bug, but a bug in the aic7xxx driver cannot be completely
ruled out without a SCSI bus trace of the failure.  All of the state in the
aic7xxx driver is consistent (disconnected cache matches the pending list)
which leads me to conclude that a drive firmware bug is more likely.  Why
would this happen now?  Most drive firmware bugs are load dependent.  They
often will only occur when two commands with just the right characteristics
overlap.  It may well be that a recent change in the 2.5/2.6 kernel has
caused a subtle change in I/O behavior that exposes this issue.

--
Justin

