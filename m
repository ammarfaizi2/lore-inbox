Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbWIVFwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWIVFwn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 01:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751685AbWIVFwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 01:52:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59581 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751156AbWIVFwm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 01:52:42 -0400
Date: Fri, 22 Sep 2006 01:52:28 -0400
From: Dave Jones <davej@redhat.com>
To: Dave Airlie <airlied@gmail.com>
Cc: Ryan Richter <ryan@tau.solarneutrino.net>,
       Stephen Olander Waters <swaters@luy.info>, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
Subject: Re: R200 lockup (was Re: DRI/X error resolution)
Message-ID: <20060922055228.GA30835@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Dave Airlie <airlied@gmail.com>,
	Ryan Richter <ryan@tau.solarneutrino.net>,
	Stephen Olander Waters <swaters@luy.info>,
	linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
References: <1158898988.3280.8.camel@ix> <20060922043801.GE16939@tau.solarneutrino.net> <1158900841.3280.12.camel@ix> <20060922051622.GF16939@tau.solarneutrino.net> <21d7e9970609212229v1f8f490dx71c6d1abb104400c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d7e9970609212229v1f8f490dx71c6d1abb104400c@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2006 at 03:29:48PM +1000, Dave Airlie wrote:
 > On 9/22/06, Ryan Richter <ryan@tau.solarneutrino.net> wrote:
 > > On Thu, Sep 21, 2006 at 11:54:01PM -0500, Stephen Olander Waters wrote:
 > > > Here is the bug I'm working from (includes hardware, software, etc.):
 > > > https://bugs.freedesktop.org/show_bug.cgi?id=6111
 > > >
 > > > DRI will work if you set: Option "BusType" "PCI" ... but that's not a
 > > > real solution. :)
 > 
 > I really think this more AGP related a bug in the driver for the VIA
 > AGP chipsets what AGP chipset are you guys using?

Looking at that bug though, most of the reporters are on AMD64 systems,
which uses amd64-agp, not via-agp. (We leave the chipset GART alone,
and just use the on-CPU one).

This..

agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: X tried to set rate=x12. Setting to AGP3 x8 mode.
agpgart: X requested AGPx8 but bridge not capable.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 4x mode

should be fixed in recent Xorg/kernels.  There is a v3 8x->4x
fallback failure that some people trigger, but that manifests itself
in other ways with different messages (where it tries to fall
back to 0x mode, and madness ensues), there's a fix for that
in Andrews -mm tree that should be going to Linus RSN.

Other than that, I'm unaware of any outstanding nasties in the
AGP drivers. I'm not really sure what to suggest for further
debugging.

	Dave
