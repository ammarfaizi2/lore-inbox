Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbTDQOgx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 10:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbTDQOgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 10:36:53 -0400
Received: from havoc.daloft.com ([64.213.145.173]:50318 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261570AbTDQOgt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 10:36:49 -0400
Date: Thu, 17 Apr 2003 10:48:44 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Patrick Mochel <mochel@osdl.org>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Subtle semantic issue with sleep callbacks in drivers
Message-ID: <20030417144844.GC18749@gtf.org>
References: <Pine.LNX.4.44.0304161133110.912-100000@cherise> <1050586549.31414.41.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1050586549.31414.41.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 17, 2003 at 02:35:50PM +0100, Alan Cox wrote:
> On Mer, 2003-04-16 at 19:39, Patrick Mochel wrote:
> > I completely agree with Andy. We should not re-POST the video hardware, no
> > matter what. The idea behind ACPI is that the OS takes care of everything, 
> > including video save/restore. 
> 
> Outside of happyville ivory towers you probably have no choice. Only the
> BIOS knows stuff like the RAM timings, and some windows drivers just use
> the BIOS, others rely on being shipped compiled for the right variant of
> card they came with.

You are exactly right.

The video BIOS on a card often contains information that is found
-nowhere- else.  Not in the chip docs.  Not in a device driver.
Such information can and does vary from board-to-board, such as RAM
timings, while the chip remains unchanged.

You mention "windows drivers" above... even some Linux X drivers
depend on video BIOS.  The S3 Savage XFree86 driver, for example,
uses video BIOS quite heavily unless you tell it not to (or are on
a platform that prevents such).

WRT save and restore, it is certainly possible without video re-POST...

However, support such will require a monumental effort of testing and
debugging for each video board.  This monumental effort _will_ include
XFree86 hacking and possibly the additional of some save-n-restore
video drivers, if we do not wish to simply require CONFIG_FBDEV if
CONFIG_SUSPEND is set.

Video re-POST is simply a Real Life(tm) shortcut to that monumental effort.

	Jeff, originally an fbdev hacker back in the day...



