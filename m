Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbTHSUG6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 16:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbTHSUGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 16:06:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:27620 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261353AbTHSUF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 16:05:59 -0400
Date: Tue, 19 Aug 2003 13:06:25 -0700
From: Dave Olien <dmo@osdl.org>
To: Ricky Beam <jfbeam@bluetronic.net>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] move DAC960 GAM IOCTLs into a new device
Message-ID: <20030819200625.GA12439@osdl.org>
References: <20030819181801.GA11704@osdl.org> <Pine.GSO.4.33.0308191542450.7750-100000@sweetums.bluetronic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.33.0308191542450.7750-100000@sweetums.bluetronic.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The interface to the original ioctl() was strange.  One of the
arguments to the ioctl() was the controller number you wanted to operate
on.  So, opening /dev/rd/c0d0 with O_NONBLOCK flag gave you a fd to
operate on ANY of the controllers.

One of the operations you can perform is to ask how many controllers
there are, and what their types are.

I've kept the original ioctl() argument structure. So you still pass
in the controller number you want to work with. But at least now the
file name the RAID control application opens is divorced from any
controller number.

There are lots of ways this could be made nicer.  I've just
tried to get rid of the single ugliest part without changing it so much that
it would be difficult to get the older applications to work again.

On Tue, Aug 19, 2003 at 03:57:56PM -0400, Ricky Beam wrote:
> On Tue, 19 Aug 2003, Dave Olien wrote:
> >...  It introduces a new "miscellaneous" device
> >named /dev/dac960_gam.  It uses minor device number 252 of the miscellaneous
> >character devices.
> 
> And what happens when there are more than one DAC in the system?  Why not
> put it where the rest of the DAC devices are? (/dev/rd/gam/c0 or something)
> 
> --Ricky
> 
> 
