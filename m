Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261980AbVDEXcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbVDEXcJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 19:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbVDEXcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 19:32:08 -0400
Received: from gate.crashing.org ([63.228.1.57]:39110 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261980AbVDEXcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 19:32:02 -0400
Subject: Re: [PATCH] radeonfb: (#2)  Implement proper workarounds for PLL
	accesses
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <je8y3wyk3g.fsf@sykes.suse.de>
References: <1110519743.5810.13.camel@gaston>
	 <1110672745.5787.60.camel@gaston>  <je8y3wyk3g.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Wed, 06 Apr 2005 09:31:41 +1000
Message-Id: <1112743901.9568.67.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-05 at 23:44 +0200, Andreas Schwab wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > After discussion with ATIs, it seems that the workarounds they initially
> > gave me were not completely correct.
> >
> > This patch implements the proper ones, which includes sleeping in PLL
> > accesses, and thus requires the previous patch to make sure we do not
> > call unblank at interrupt time (unless oops_in_progress is set, in which
> > case I use an mdelay).
> >
> > It also removes obsolete code that used to disable some power management
> > features in the accel init code.
> 
> This patch does no good on Radeon M6 (iBook G3).  It makes mode switching
> to take an extraordinary amount of time, ie. when switching away from X it
> takes about 2-3 seconds until the console is restored.

Hrm... it should only add a few ms, maybe about 20 ms to the mode
switching... If you remove the radeon_msleep(5) call from the
radeon_pll_errata_after_data() routine in radeonfb.h, does it make a
difference ?

Ben.


