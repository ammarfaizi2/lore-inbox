Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265154AbUGJQEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265154AbUGJQEF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 12:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265692AbUGJQEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 12:04:04 -0400
Received: from cm217.omega59.maxonline.com.sg ([218.186.59.217]:16259 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265154AbUGJQEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 12:04:00 -0400
Date: Sun, 11 Jul 2004 00:04:09 +0800
From: David Teigland <teigland@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
Message-ID: <20040710160409.GA19471@redhat.com>
References: <1089471483.1750.31.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089471483.1750.31.camel@mulgrave>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2004 at 09:58:02AM -0500, James Bottomley wrote:
>     gfs needs to run in the kernel.  dlm should run in the kernel since gfs
>     uses it so heavily.  cman is the clustering subsystem on top of which
>     both of those are built and on which both depend quite critically.  It
>     simply makes most sense to put cman in the kernel for what we're doing
>     with it.  That's not a dogmatic position, just a practical one based on
>     our experience.
>     
> This isn't really acceptable.  We've spent a long time throwing things out of
> the kernel so you really need a good justification for putting things in
> again.  "it makes sense" and "its just practical" aren't sufficient.

The "it" refers to gfs.  This means gfs doesn't make a lot of sense and isn't
very practical without it.  I'm not the one to speculate on what gfs would
become otherwise, others would do that better.


> You also face two other additional hurdles:
> 
> 1) GFS today uses a user space DLM.  What critical problems does this have
> that you suddenly need to move it all into the kernel?

GFS does not use a user space dlm today.  GFS uses the client-server gulm lock
manager for which the client (gfs) side runs in the kernel and the gulm server
runs in userspace on some other node.  People have naturally been averse to
using servers like this with gfs for a long time and we've finally created the
serverless dlm (a la VMS clusters).  For many people this is the only option
that makes gfs interesting; it's also what the opengfs group was doing.

This is a revealing discussion.  We've worked hard to make gfs's lock manager
independent from gfs itself so it could be useful to others and make gfs less
monolithic.  We could have left it embedded within the file system itself --
that's what most other cluster file systems do.  If we'd done that we would
have avoided this objection altogether but with an inferior design.  The fact
that there's an independent lock manager to point at and question illustrates
our success.  The same goes for the cluster manager.  (We could, of course, do
some simple glueing together and make a monlithic system again :-)


> 2) We have numerous other clustering products for Linux, none of which (well
> except the Veritas one) has any requirement at all on having pieces in the
> kernel.  If all the others operate in user space, why does yours need to be
> in the kernel?

If you want gfs in user space you don't want gfs; you want something different.

-- 
Dave Teigland  <teigland@redhat.com>
