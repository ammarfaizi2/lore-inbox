Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265792AbUAKILB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 03:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265794AbUAKILB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 03:11:01 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:2999 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265792AbUAKIK7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 03:10:59 -0500
Date: Sun, 11 Jan 2004 09:10:46 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Peter Berg Larsen <pebl@math.ku.dk>
Cc: Gunter =?iso-8859-1?Q?K=F6nigsmann?= <gunter.koenigsmann@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Synaptics Touchpad workaround for strange behavior after Sync loss (With Patch).
Message-ID: <20040111081046.GA25497@ucw.cz>
References: <20040109105855.GB9479@ucw.cz> <Pine.LNX.4.40.0401102336450.588-100000@shannon.math.ku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.40.0401102336450.588-100000@shannon.math.ku.dk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 10, 2004 at 11:50:02PM +0100, Peter Berg Larsen wrote:

> On Fri, 9 Jan 2004, Vojtech Pavlik wrote:
> 
> > The sync problems have so far been found to be caused by two possible
> > causes:
> >
> > 	1) Too long disabled interrupts. This is usually caused by ACPI
> > 	   BIOS, when some application is polling for battery status
> > 	   too often.
> >
> > 	2) Incorrectly working timer (jiffies). This maybe caused by
> > 	   using the ACPI timer instead of the regular PIT one. Check
> > 	   the config.
> >
> > Both these causes break the lost bytes detection mechanism in the ps/2
> > code. It then thinks that a byte was lost (and thus the sync, too), but
> > in reality everything is OK. This in turn causes two consecutive
> > incorrectly parsed packets.
> 
> I also believe some of the troubles comes from that we never check all
> error codes from the mux: If mux is disabled for some reason all bytes are
> stamped as timed out.  The only way to recover is to reboot.  And (I am
> speculating here) if for some reason the mux believe the touchpad is
> removed and connected the touchpad sends 2 bytes ack.
> 
> I dont have a machine with active multiplexing so the the patch is
> untested. It warns when the mouse is removed, and tries to recover
> if multiplexing is disabled.

It's nice, but er definitely shouldn't call i8042_enable_mux() from the
interrupt handler, because i8042_command() waits for characters arriving
in the interrupt handler, so we could get into rather nasty recursions.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
