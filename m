Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbULTU5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbULTU5t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 15:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbULTU5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 15:57:49 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:44693 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261638AbULTU5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 15:57:45 -0500
Subject: Re: Scheduling while atomic (2.6.10-rc3-bk13)
From: Lee Revell <rlrevell@joe-job.com>
To: David Brownell <david-b@pacbell.net>
Cc: Greg KH <greg@kroah.com>, Lukas Hejtmanek <xhejtman@mail.muni.cz>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <200412201152.16329.david-b@pacbell.net>
References: <20041219231015.GB4166@mail.muni.cz>
	 <20041220184814.GA21215@kroah.com> <200412201152.16329.david-b@pacbell.net>
Content-Type: text/plain
Date: Mon, 20 Dec 2004 15:57:43 -0500
Message-Id: <1103576264.1252.87.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-20 at 11:52 -0800, David Brownell wrote:
> On Monday 20 December 2004 10:48 am, Greg KH wrote:
> 
> > 
> > David, it looks like you grab a spinlock, and then call msleep(20);
> > which causes this warning.
> > 
> > Care to fix it?
> 
> How bizarre ... I must have been tested that without spinlock
> debugging, for some reason.  Grr.  I usually leave that on,
> just to prevent stuff like this.
> 
> Here's a quick'n'dirty patch, msleep --> mdelay.  I'd rather
> not mdelay for that long, but this late in 2.6.10 it's safer.
> (And this is also what OHCI does in that same code path.)

Ugh.  20ms is WAY too long to hold a spinlock.  That's guaranteed to
cause audio skips.  Isn't there another way?

If OHCI calls mdelay(20) while holding a spinlock that needs to be
fixed.

Lee

