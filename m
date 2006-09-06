Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbWIFPTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbWIFPTf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 11:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWIFPTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 11:19:35 -0400
Received: from alnrmhc11.comcast.net ([204.127.225.91]:38025 "EHLO
	alnrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751408AbWIFPTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 11:19:33 -0400
Subject: Re: [OLPC-devel] Re: [RFC][PATCH 1/2] ACPI: Idle Processor PM
	Improvements
From: Jim Gettys <jg@laptop.org>
Reply-To: jg@laptop.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       "Brown, Len" <len.brown@intel.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       ACPI ML <linux-acpi@vger.kernel.org>, Adam Belay <abelay@novell.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Arjan van de Ven <arjan@linux.intel.com>, devel@laptop.org
In-Reply-To: <20060906103725.GA4987@atrey.karlin.mff.cuni.cz>
References: <EB12A50964762B4D8111D55B764A845484D316@scsmsx413.amr.corp.intel.com>
	 <20060830194317.GA9116@srcf.ucam.org>
	 <200608311713.21618.bjorn.helgaas@hp.com>
	 <1157070616.7974.232.camel@localhost.localdomain>
	 <20060904130933.GC6279@ucw.cz>
	 <1157466710.6011.262.camel@localhost.localdomain>
	 <20060906103725.GA4987@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Organization: OLPC
Date: Wed, 06 Sep 2006 11:19:09 -0400
Message-Id: <1157555949.6011.516.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-06 at 12:37 +0200, Pavel Machek wrote:
> Hi!
> 
> > > 2.4 and 2.6 are *very* different here. You'll probably need to optimize freezer
> > > in 2.6 a bit...
> > > 						
> > 
> > Among other problems: e.g. 2.4 did not automatically do a VT switch; 2.6
> > does; we'll have to have a way to signal "we're a sane display driver;
> > don't switch away from me on suspend".
> 
> Not like that, please.
> 
> You are using X running over framebuffer, right? So that kernel is
> controlling the graphics hardware. In such case it is safe to avoid VT
> switch.

It should be perfectly safe.

The Geode has significantly more than dumb frame buffer support, even
though it can't support 3D in hardware (we do get blit and alpha
blending, and YUV->RGB support in hardware).

We have an fbdev driver for the hardware (in fact, have to finally have
a decent driver in general, as the transfer to and from DCON controlled
display has to happen at interrupt time).  We won't be doing thing evil
in X behind the operating system's back the way most XF86 drivers do,
but very much the way display drivers supported X before the strange
notion of completely OS independent drivers without any kernel support
twisted the way XF86 drivers usually work.  Ah, back to the future
(past)....
                                        - Jim


-- 
Jim Gettys
One Laptop Per Child


