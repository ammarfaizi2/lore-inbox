Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265847AbUFOTAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265847AbUFOTAy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 15:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265845AbUFOTAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 15:00:54 -0400
Received: from crianza.bmb.uga.edu ([128.192.34.109]:641 "EHLO crianza")
	by vger.kernel.org with ESMTP id S265871AbUFOTAu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 15:00:50 -0400
Date: Tue, 15 Jun 2004 15:00:50 -0400
To: linux-kernel@vger.kernel.org
Cc: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: more about serial console
Message-ID: <20040615190050.GB13604@porto.bmb.uga.edu>
Reply-To: foo@porto.bmb.uga.edu
References: <20040615000436.GA12516@porto.bmb.uga.edu> <20040615184229.GA13604@porto.bmb.uga.edu> <20040615195205.D7666@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040615195205.D7666@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: foo@porto.bmb.uga.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 07:52:05PM +0100, Russell King wrote:
> On Tue, Jun 15, 2004 at 02:42:29PM -0400, foo@porto.bmb.uga.edu wrote:
> > On Mon, Jun 14, 2004 at 08:04:36PM -0400, foo@porto.bmb.uga.edu wrote:
> > > The other weird thing I have seen is with the serial console.  After
> > > init loads the net bonding module and the network comes up, the serial
> > > console output stops, as though I had typed ^s.  If I type a character
> > > (doesn't seem to matter what), instead of that character printing I see
> > > the next character of console output.  I have to hold down a key for a
> > > few seconds to get the next few lines of output, then it starts printing
> > > on its own again.  I've seen this with 2.6.7-rc3-bk4 and 2.6.6, not with
> > > 2.6.5 (I booted 2.6.6 by accident yesterday, I don't know how it does
> > > with NFS).
> > 
> > More experience with 2.6.7-rc3-bk6: this is basically the same, although
> > the console stalled twice during one boot, once after mounting all the
> > filesystems and then again after the ethernet comes up (as always).
> > 
> > Also, I was wrong about getting one character of output for each that I
> > type - it looks like I get 16 characters (if that many are available to
> > be printed, seemingly).
> 
> So it only happens when userspace is using the serial port and a few
> other things are in use.
> 
> Is anything sharing the serial port's interrupt?

Nope.

$ cat /proc/interrupts 
           CPU0       CPU1       
  0:    3287097   11178094    IO-APIC-edge  timer
  3:      71993      20488    IO-APIC-edge  serial
  4:        544         14    IO-APIC-edge  serial
  8:          3          0    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 16:        121         32   IO-APIC-level  sym53c8xx
 24:       6370     371797   IO-APIC-level  ioc0, eth0
 25:     324116          0   IO-APIC-level  ioc1, eth1
NMI:         88        157 
LOC:   14461411   14461930 
ERR:          0
MIS:          0

-ryan
