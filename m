Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUCKLNq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 06:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbUCKLNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 06:13:46 -0500
Received: from aun.it.uu.se ([130.238.12.36]:51654 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261184AbUCKLNp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 06:13:45 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16464.18916.155063.971896@alkaid.it.uu.se>
Date: Thu, 11 Mar 2004 12:13:40 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Jonathan Lundell <jlundell@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nmi oddity
In-Reply-To: <p0610038abc75b353d82c@[192.168.0.3]>
References: <p0610038abc75b353d82c@[192.168.0.3]>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Lundell writes:
 > Running smp 2.4.9 (don't ask) with updated nmi logic on a Dell 650 
 > (UP P4), I notice that NMI is running at about 1.08 Hz. Per the 
 > kernel logic, it should be running at HZ (100) Hz.
 > 
 > I'm using NMI_LOCAL_APIC. check_nmi_watchdog() never gets called in 
 > this mode in an smp kernel, near as I can tell, so nmi_hz never gets 
 > set to 1.
 > 
 > What's going on? Or does anyone else see it?

This is a normal. The NMIs are generated from an in-CPU performance
counter configured to increment once per CPU core clock cycle.
(There is no wallclock-like event available, alas.)

Whenever the kernel is idle, "hlt" is normally executed which
stops the CPU until the next external interrupt (typically the
timer). Hence, an idle machine will see a much lower NMI frequence
than a non-idle one.

This behaviour is not universal. Server Tualatins seem to run at
full speed all the time; perhaps they ignore hlt?

If you want NMI_LOCAL_APIC to be clock-like, upgrade your cooling
solution and disable hlt.

/Mikael
