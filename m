Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265098AbUITALd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265098AbUITALd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 20:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265144AbUITALd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 20:11:33 -0400
Received: from gate.crashing.org ([63.228.1.57]:36796 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265098AbUITALR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 20:11:17 -0400
Subject: Re: Design for setting video modes, ownership of sysfs attributes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Keith Packard <keithp@keithp.com>,
       dri-devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9e47339104091909465c9a483f@mail.gmail.com>
References: <9e47339104091811431fb44254@mail.gmail.com>
	 <1095569137.6580.23.camel@gaston>
	 <9e47339104091909465c9a483f@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1095639002.23182.24.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 20 Sep 2004 10:10:02 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-20 at 02:46, Jon Smirl wrote:

> This is going to require some more thought. Mode setting needs two
> things, a description of the mode timings and a location of the scan
> out buffer.  With multiple heads you can't just assume that the buffer
> starts at zero.  There also the problem of the buffer increasing in
> size and needing to be moved since it won't fit where it is.
> 
> Keith, how should this work for X? We have to make sure all DRI users
> of the buffer are halted, get a new location for the buffer, set the
> mode, free the old buffer, notify all of the DRI clients that their
> target has been wiped and has a new size.
> 
> I was wanting to switch mode setting into an atomic operation where
> you passed in both the mode timings and buffer location.

It's more than just a problem of buffer allocation. I doubt some of the
engine operations can go undisturbed accross a mode switch (the driver
currently resets the 2D engine for example). So there is some state loss
and the need to stop rendering pipes before and restart them after.

With DRI, that means OpenGL users... not simple.

Ben.


