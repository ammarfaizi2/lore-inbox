Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbTHSUMV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 16:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbTHSUMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 16:12:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:47591 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261373AbTHSUK5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 16:10:57 -0400
Date: Tue, 19 Aug 2003 13:11:24 -0700
From: Dave Olien <dmo@osdl.org>
To: Ricky Beam <jfbeam@bluetronic.net>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] move DAC960 GAM IOCTLs into a new device
Message-ID: <20030819201124.GB12439@osdl.org>
References: <20030819181801.GA11704@osdl.org> <Pine.GSO.4.33.0308191542450.7750-100000@sweetums.bluetronic.net> <20030819200625.GA12439@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030819200625.GA12439@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A little more... regarding where this file actually lives....  Why not
put it in /dev/rd/dac960_gam?

I don't have a GOOD answer to that.  Since I'm using the miscellaneous
device registration, it happens that devfs puts the name in the
same directory with other such devices... nvram, etc.  So as a default
I decided to keep the name with the other miscellaneous devices.

If there's a good reason for moving it elsewhere, I'm open to that.

On Tue, Aug 19, 2003 at 01:06:25PM -0700, Dave Olien wrote:
> 
> The interface to the original ioctl() was strange.  One of the
> arguments to the ioctl() was the controller number you wanted to operate
> on.  So, opening /dev/rd/c0d0 with O_NONBLOCK flag gave you a fd to
> operate on ANY of the controllers.
> 
> One of the operations you can perform is to ask how many controllers
> there are, and what their types are.
> 
> I've kept the original ioctl() argument structure. So you still pass
> in the controller number you want to work with. But at least now the
> file name the RAID control application opens is divorced from any
> controller number.
> 
> There are lots of ways this could be made nicer.  I've just
> tried to get rid of the single ugliest part without changing it so much that
> it would be difficult to get the older applications to work again.
> 
> On Tue, Aug 19, 2003 at 03:57:56PM -0400, Ricky Beam wrote:
> > On Tue, 19 Aug 2003, Dave Olien wrote:
> > >...  It introduces a new "miscellaneous" device
> > >named /dev/dac960_gam.  It uses minor device number 252 of the miscellaneous
> > >character devices.
> > 
> > And what happens when there are more than one DAC in the system?  Why not
> > put it where the rest of the DAC devices are? (/dev/rd/gam/c0 or something)
> > 
> > --Ricky
> > 
> > 
