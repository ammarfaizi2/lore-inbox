Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261839AbULOB2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbULOB2p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 20:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbULOB1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 20:27:47 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:61418 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261834AbULOBLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 20:11:50 -0500
Date: Tue, 14 Dec 2004 17:11:32 -0800
From: Greg KH <greg@kroah.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at mm/rmap.c:480 in 2.6.10-rc3-bk7
Message-ID: <20041215011132.GA16099@kroah.com>
References: <20041214164548.GA18817@kroah.com> <Pine.LNX.4.44.0412142304160.11826-100000@localhost.localdomain> <20041215001912.GA15575@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041215001912.GA15575@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2004 at 04:19:12PM -0800, Greg KH wrote:
> On Tue, Dec 14, 2004 at 11:26:48PM +0000, Hugh Dickins wrote:
> > One case that's easy to explain: if it was preceded (perhaps hours
> > earlier) by a "Bad page state" message and stacktrace, referring to
> > the same page (in ecx, edx, ebp in your dump), which showed non-zero
> > mapcount, then this is an after-effect of bad_page resetting mapcount.
> > And the real problem was probably a double free, which bad_page noted,
> > but carried on regardless.  Worth checking your logs for, let us know,
> > but there have been several reports where that's definitely not so.
> 
> Nope, nothing like that in my logs, sorry.
> 
> > I presume this was just a one-off?  If you can repeat it from time to
> > time, I'll try to devise some printk'ing to shed more light.
> 
> I'll try to see if I can reproduce it.  If so, I'll let you know.

Yes, I can duplicate it easily now:
	- running X with drm and the radeon driver
	- start a gish game up in 640x480 mode and start the initial
	  level.
	- as the laptop just can't handle the cpu demands of this
	  program, everything runs way too slow.
	- switch back to the console that I started X up on and hit
	  ctrl-C.
	- X dies, and the kernel oops happens.

And yes, it does only show up when I'm using drm/agp for me, as this is
the only way I've ever seen this error.  I can't really even get gish to
start up without drm, but I guess I could try to see if I can do that
later tonight.

Any testing you want me to do?

Oh, and this also happens on 2.6.10-rc3-bk8.

thanks,

greg k-h
