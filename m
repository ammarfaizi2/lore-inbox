Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262344AbVDFWnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbVDFWnM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 18:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262346AbVDFWnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 18:43:11 -0400
Received: from gate.crashing.org ([63.228.1.57]:24018 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262344AbVDFWnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 18:43:06 -0400
Subject: Re: Linux 2.6.12-rc2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Moritz Muehlenhoff <jmm@inutil.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <E1DJE6t-0001T5-UD@localhost.localdomain>
References: <Pine.LNX.4.58.0504040945100.32180@ppc970.osdl.org>
	 <Pine.LNX.4.58.0504041430070.2215@ppc970.osdl.org>
	 <E1DJE6t-0001T5-UD@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 07 Apr 2005 08:42:22 +1000
Message-Id: <1112827342.9567.189.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-06 at 19:14 +0200, Moritz Muehlenhoff wrote:
> Linus Torvalds wrote:
> > Benjamin Herrenschmidt:
> >   o radeonfb: Implement proper workarounds for PLL accesses
> >   o radeonfb: DDC i2c fix
> >   o radeonfb: Fix mode setting on CRT monitors
> >   o radeonfb: Preserve TMDS setting
> 
> One of these patches introduced two regressions on my Thinkpad X31 with
> "ATI Technologies Inc Radeon Mobility M6 LY (prog-if 00 [VGA])":
> 
> 1. When resuming from S3 suspend and having switched off the backlight
> with radeontool the backlight isn't switched back on any more.

I'm not sure what's up here, it's a nasty issue with backlight. Can
radeontool bring it back ?

> 2. I'm using fbcon as my primary work environment, but tty switching has
> become _very_ sloppy, it's at least a second now, while with 2.6.11 it
> was as fast as a few ms. Is this caused by the "proper PLL accesses"?

Yes. Unfortunately. It's surprised it is that slow though, there
shouldn't be more than 5 or 6 PLL accesses on a normal mode switch, with
5ms pause for each, that should still be very reasonable. It looks like
we are doing a lot more accesses which I don't completely understand.

Ben.


