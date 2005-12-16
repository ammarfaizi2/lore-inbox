Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbVLPOdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbVLPOdP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 09:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbVLPOdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 09:33:15 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:54930 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932306AbVLPOdO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 09:33:14 -0500
Subject: Re: [patch 3/3] s390: dasd extended error reporting module.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@osdl.org, wein@de.ibm.com, Horst.Hummel@de.ibm.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051216134754.GA23964@infradead.org>
References: <20051216132953.GD8877@skybase.boeblingen.de.ibm.com>
	 <20051216134754.GA23964@infradead.org>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 15:33:09 +0100
Message-Id: <1134743589.5495.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-16 at 13:47 +0000, Christoph Hellwig wrote:
> On Fri, Dec 16, 2005 at 02:29:53PM +0100, Martin Schwidefsky wrote:
> > From: Stefan Weinhuber <wein@de.ibm.com>
> > 
> > [patch 3/3] s390: dasd extended error reporting module.
> > 
> Nack, now new ioctls in compat_ioctl.c, please.  In fact that file is
> gone in -mm, so please submit this patch ontop of the -mm tree.

Hmm, that's true. In that case it's probably best to wait until the
first wave of patches out of -mm have hit the git tree and then I
recreate the patch from our internal tree. The current patch dependecies
are starting to make my head ache.

> And is there a chance for a better interface than the notifier lists?
> The code looks rather awkward because of it.

Older versions of the code had an own registration function for a
callback pointer for the events. It only accepted one user and sort of
reinvented the notify functionality. I'd prefer notifiers compare to the
old solution. If you have a clever idea, we are listening.

On a side not, Arnd just told my about the bug in the dasd_eckd
discipline. We need to check the discipline in the eckd specific ioctls.
I'll tell the appropriate people (well in fact I already did because
they are on CC:). As for adding a per discipline .ioctl function, that
won't work because of cmb and eer. These modules do not implement a
discipline but still have to add ioctls.

-- 
blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH


