Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275092AbTHMOYp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 10:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275201AbTHMOYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 10:24:45 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:40622 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S275092AbTHMOYm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 10:24:42 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16186.18984.335521.224346@gargle.gargle.HOWL>
Date: Wed, 13 Aug 2003 16:24:40 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Ruben Puettmann <ruben@puettmann.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 APM problems with IBM Thinkpad's
In-Reply-To: <20030813133126.GA26337@puettmann.net>
References: <20030813123119.GA25111@puettmann.net>
	<16186.14686.455795.927909@gargle.gargle.HOWL>
	<20030813133126.GA26337@puettmann.net>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ruben Puettmann writes:
 > On Wed, Aug 13, 2003 at 03:13:02PM +0200, Mikael Pettersson wrote:
 > > 
 > > This sounds like a well-known APM/local-APIC clash.
 > 
 > nice to know ... 
 > > 
 > > Never ever use DISPLAY_BLANK if you also have SMP or UP_APIC.
 > 
 > not nice so ;-( how is it with acpi? Same problem?
 > 
 > > With APIC support enabled (SMP or UP_APIC), APM must be constrained:
 > > DISPLAY_BLANK off
 > > CPU_IDLE off
 > > built-in driver, not module
 > 
 > Why will this not be disabled in make *config so that nobody will run in
 > this problem?
 > 
 > > This is because the apm driver does BIOS calls, and many BIOSen
 > > (including the code in graphics cards, e.g. all Radeons it seems)
 > > like to hang if a local APIC timer interrupt arrives.

Several reasons:
- The interaction wasn't understood initially, and some problems
  didn't start appearing until late last year. The problems are
  also system & configuration dependent.
  Case in point #1: my P3B-F and P4T-E ASUS mainboards never had
  problems until they started running 2.5 kernels, where HZ==1000
  greatly increased the likelihood of a local APIC timer interrupt
  while in BIOS screen blanking code.
  Case in point #2: my TUSL2-C ASUS mobo (RIP) worked great until
  I switched from a Millenium to a Radeon 8500, and found that it
  hung because of local APIC timer interrupts while in BIOS screen
  blanking code, even in 2.4 kernels.
- Fixing the APM driver would require that someone who understands
  it modifies it to avoid BIOS calls (other than suspend/resume) when
  UP_APIC is active. I'm not that person.
- The problems can be worked around by avoiding misconfigurations.
