Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbTKMG6t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 01:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbTKMG6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 01:58:48 -0500
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:40453 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261784AbTKMG6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 01:58:46 -0500
Date: Thu, 13 Nov 2003 06:58:44 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Pat Gefre <pfg@sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       davidm@napali.hpl.hp.com
Subject: Re: [PATCH] Updating our sn code in 2.6
Message-ID: <20031113065844.A16234@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pat Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org,
	davidm@napali.hpl.hp.com
References: <20031107102514.A2437@infradead.org> <Pine.SGI.3.96.1031112174709.40512D-100000@fsgi900.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.SGI.3.96.1031112174709.40512D-100000@fsgi900.americas.sgi.com>; from pfg@sgi.com on Wed, Nov 12, 2003 at 06:26:02PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> + In fact that SGI let code slip in that clearly wasn't theirs I think you should
> + really identidy who changed what instead of a hude 1.4MB patch.
> 
> I'm not sure what you mean here. Was there something specific ?

ate_malloc & co..

> One of
> the reasons this is so large is because we hadn't sent any updates in
> months, so we are in a bit of a catch-up mode. In the months since our
> last updates, we have had several rounds of code clean up, fixed a
> number of bugs and re-organized our code - something we feel we will
> need down the road.

It needs to be split into piecees anyway.  The patch is a big mess and by
splitting it into smaller parts you can describe what each patch does,
maybe notice the problems with it yourself or at least give us a better
opportunity to review it properly.  Really, it is a lot of work but it will
pay off.

> + 	- the ioc4 driver is a mess, please rewrite it as a proper linux
> + 	driver using serial_core, etc.. instead of glueing an irix driver
> + 	through a midlyer directly to the tty interface.
> 
> I took this out.  Is the only complaint that I didn't use the serial
> core interface ?

No.  The complaint is that the driver is an utteer mess.  It's basically
a badly written IRIX driver glued into a copy of the Linux serial driver
that doesn't even compile on 2.6.  Get real, and take a look at it..

> + 	- please don't kill xbridge support from pcibr, we want to reuse
> + 	it for the ip27 port soon
> 
> Not sure what you mean here. I'm pretty sure if this code is needed for
> a non-ia64 system it won't be in the sn2 code.

Well, given that the ip27 is basically the same system architecture as 
sn2 we want to resuse that code.  Whether it stays in arch/ia64/ or goes
to drivers/xtalk is a different question.  Also note that you can just
make the IS_PIC calls evulate to 1 always in your build, any recent gcc
will optimize away the xbridge codepathes then

> 
> + 	- __HAVE_NEW_SCHEDULER is always true for 2.6, but you don't appear
> + 	to actually use it..
> 
> What did you mean here ?

grep for __HAVE_NEW_SCHEDULER over your tree :)

