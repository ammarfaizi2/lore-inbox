Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263792AbTEYX2x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 19:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263798AbTEYX2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 19:28:53 -0400
Received: from waste.org ([209.173.204.2]:31927 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263792AbTEYX2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 19:28:52 -0400
Date: Sun, 25 May 2003 18:42:02 -0500
From: Matt Mackall <mpm@selenic.com>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: Resend [PATCH] Make KOBJ_NAME_LEN match BUS_ID_SIZE
Message-ID: <20030525234202.GO23715@waste.org>
References: <20030525000701.GG504@phunnypharm.org> <Pine.LNX.4.44.0305242045050.1666-100000@home.transmeta.com> <20030525155102.GN23715@waste.org> <200305251813.h4PID2oH021773@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305251813.h4PID2oH021773@turing-police.cc.vt.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 25, 2003 at 02:13:02PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Sun, 25 May 2003 10:51:02 CDT, Matt Mackall said:
> 
> > The return value here isn't particularly useful. The OpenBSD
> > strlcpy/strlcat variant tell you how big the result should have been
> > so that you can realloc if need be.
> 
> A quick grep of the current source tree seems to indicate that there aren't
> any uses of 'strncpy' that actually save or check the return value.
> 
> As such, actually *using*  the return value would make for a job for the
> kernel janitors, to actually do something useful at all 650 or so uses.

The kernel, fortunately, isn't Perl or the like and really isn't
interested in strings outside the context of things like pathnames,
which realistically have to have finite limits. So while there
probably aren't a lot of uses for a return val, for the places where
there are, min(bufsize, optimalsize) is going to be less useful than
just optimalsize as you already know bufsize.
 
> Given that the kernel probably *shouldn't* be trying to strlcpy() into
> a destination that it won't fit, it may be more useful to do a BUG_ON()
> or similar (feel free to use a 'goto too_long;' if you prefer ;)

Outside of pathnames type things, where there's a well-defined return
code (ENAMETOOLONG), we probably end up not caring overmuch about
truncation..

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
