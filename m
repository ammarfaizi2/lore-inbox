Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262842AbVAQT1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262842AbVAQT1T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 14:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262847AbVAQT1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 14:27:19 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:14518 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262842AbVAQT1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 14:27:12 -0500
From: Russ Anderson <rja@sgi.com>
Message-Id: <200501171927.j0HJRAmE3010159@clink.americas.sgi.com>
Subject: Re: [patch] Remove limit on MCA recoveries
To: mfl@kernel.paris.sgi.com (Matthias Fouquet-Lapar)
Date: Mon, 17 Jan 2005 13:27:10 -0600 (CST)
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <200501160901.j0G91h8G001716@mtv-vpn-hw-mfl-1.corp.sgi.com> from "Matthias Fouquet-Lapar" at Jan 16, 2005 10:01:43 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Fouquet-Lapar wrote:
> Keith Owens wrote:
> > Russ Anderson <rja@sgi.com> wrote:
> > >The MCA recovery driver saves the addresses of memory errors
> > >in an array.  The array has 32 entries.  The effect is 
> > >that after 32 recoveries, the driver stops recovering.
> > >
> > >This patch removes the page_isolate array.  Since the array
> > >was only used to see if the page is already marked reserved,
> > >check the reserved bit instead of the array.
> > 
> > lkcd dumps kernel pages marked reserved, so lkcd will try to process
> > isolated pages.  We will eventually need to add a new page flag to mark
> > faulty pages.
> 
> Probably any other dump mechanism should be aware of bad HW pages as well,
> so we might be better off to add a flag right away.  While we are at it I
> would propose to have actually two flags :
> 
>   - hard error (which will cause a MCA and should be skipped when taking
>                 a system dump)
>   - soft error (page has encountered SBE, so we might want to avoid future
>                 allocation, but it can be dumped without causing an MCA)

Yes, there should be page->flags to indicate hard and soft memory errors,
such as PG_hard_error and PG_soft_error.  The dump code could look at those 
flags.

include/linux/page-flags.h has PG_error for indicating I/O errors, which 
is close but not quite what we need, given the way it is used.  

CCing linux-kernel since the flags are not ia64 specific.

-- 
Russ Anderson, OS RAS/Partitioning Project Lead  
SGI - Silicon Graphics Inc          rja@sgi.com
