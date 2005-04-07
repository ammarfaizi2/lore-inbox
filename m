Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262276AbVDGWpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262276AbVDGWpQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 18:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262268AbVDGWpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 18:45:15 -0400
Received: from gate.crashing.org ([63.228.1.57]:45534 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262276AbVDGWoR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 18:44:17 -0400
Subject: Re: Linux 2.6.12-rc2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Moritz Muehlenhoff <jmm@inutil.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050407175026.GA5872@informatik.uni-bremen.de>
References: <Pine.LNX.4.58.0504040945100.32180@ppc970.osdl.org>
	 <Pine.LNX.4.58.0504041430070.2215@ppc970.osdl.org>
	 <E1DJE6t-0001T5-UD@localhost.localdomain>
	 <1112827342.9567.189.camel@gaston>
	 <20050407175026.GA5872@informatik.uni-bremen.de>
Content-Type: text/plain
Date: Fri, 08 Apr 2005 08:43:10 +1000
Message-Id: <1112913790.9567.302.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-07 at 19:50 +0200, Moritz Muehlenhoff wrote:
> Benjamin Herrenschmidt wrote:
> > > 1. When resuming from S3 suspend and having switched off the backlight
> > > with radeontool the backlight isn't switched back on any more.
> > 
> > I'm not sure what's up here, it's a nasty issue with backlight. Can
> > radeontool bring it back ?
> 
> Before suspending I power down the backlight with "radeontool light off"
> and with 2.6.11 the display is properly restored. With 2.6.12rc2 the
> backlight remains switched off and if I switch it on with radeontool it
> becomes lighter, but there's still no text from the fbcon, just the blank
> screen.
> 
> > > 2. I'm using fbcon as my primary work environment, but tty switching has
> > > become _very_ sloppy, it's at least a second now, while with 2.6.11 it
> > > was as fast as a few ms. Is this caused by the "proper PLL accesses"?
> > 
> > Yes. Unfortunately. It's surprised it is that slow though, there
> > shouldn't be more than 5 or 6 PLL accesses on a normal mode switch, with
> > 5ms pause for each, that should still be very reasonable. It looks like
> > we are doing a lot more accesses which I don't completely understand.
> 
> Can you tell me which function you have in mind, so that I can insert
> some printks to see how often it's called?

radeon_pll_errata_after_data() calls radeon_msleep() (it's in
radeonfb.h)

Ben.


