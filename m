Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272426AbTHOXyQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 19:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272464AbTHOXyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 19:54:16 -0400
Received: from mail.kroah.org ([65.200.24.183]:36814 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272426AbTHOXyL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 19:54:11 -0400
Date: Fri, 15 Aug 2003 16:51:29 -0700
From: Greg KH <greg@kroah.com>
To: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org, Jean Delvare <khali@linux-fr.org>,
       sensors@Stimpy.netroedge.com, vsu@altlinux.ru
Subject: Re: [PATCH 2.4] i2c-dev user/kernel bug and mem leak
Message-ID: <20030815235127.GA5697@kroah.com>
References: <20030803192312.68762d3c.khali@linux-fr.org> <20030804193212.11786d06.vsu@altlinux.ru> <20030805103240.02221bed.khali@linux-fr.org> <20030805210704.GA5452@kroah.com> <20030806100702.78298ffe.khali@linux-fr.org> <1060886657.1006.7121.camel@dooby.cs.berkeley.edu> <20030814190954.GA2492@kroah.com> <1060912895.1006.7160.camel@dooby.cs.berkeley.edu> <20030815211329.GB4920@kroah.com> <1060985846.302.17.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060985846.302.17.camel@dooby.cs.berkeley.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 03:17:25PM -0700, Robert T. Johnson wrote:
> On Fri, 2003-08-15 at 14:13, Greg KH wrote:
> > i2c-dev.c is annotated in 2.6.  Did I miss anything that needs to be
> > marked as such?
> 
> For this particular bug (before all the patches started flying around),
> you'd have to add a kernel annotation to the "struct i2c_msg" field
> buf.

Look at 2.6, that annotatation is already there.

> But you still have the problem that sparse silently ignores
> missing annotations, so you can never tell if you've missed something
> important.  Cqual infers the annotations on its own, so you never have
> to worry that some might be missing or wrong.

Nice, is cqual released somewhere so that we can compare it and start
using it, like we already use sparse?

> > Hm, how about just fixing the tty core to always pass in kernel buffers?
> > That would fix the "problem" in one place :)
> 
> That's a good idea, but is that possible?  In other words, can the tty
> core always tell how much to copy into kernel space?

Yes it is, one of the paramaters in those functions is the size of the
buffer :)

> The solution I propose is a very simple change that fits easily into
> the current architecture.

Not really, you still are saying that all tty drivers need to be
changed, and new logic added to handle the additional paramater.  With
my proposed change, all drivers also have to be changed, but logic and
paramaters gets to be removed, making it harder for tty driver authors
to get things wrong.

thanks,

greg k-h
