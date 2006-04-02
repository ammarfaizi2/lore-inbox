Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751485AbWDBTEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbWDBTEE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 15:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWDBTED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 15:04:03 -0400
Received: from noname.neutralserver.com ([70.84.186.210]:39326 "EHLO
	noname.neutralserver.com") by vger.kernel.org with ESMTP
	id S1751445AbWDBTEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 15:04:01 -0400
Date: Sun, 2 Apr 2006 22:05:20 +0300
From: Dan Aloni <da-x@monatomic.org>
To: Mark Lord <lkml@rtr.ca>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       IDE/ATA development list <linux-ide@vger.kernel.org>
Subject: Re: sata_mv: module reloading doesn't work
Message-ID: <20060402190520.GA29946@localdomain>
References: <20060402155647.GB20270@localdomain> <442FF65A.6020209@rtr.ca> <20060402161449.GA21822@localdomain> <442FFA0E.4070101@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442FFA0E.4070101@rtr.ca>
User-Agent: Mutt/1.5.11+cvs20060126
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - noname.neutralserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - monatomic.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2006 at 12:21:34PM -0400, Mark Lord wrote:
> Dan Aloni wrote:
> >On Sun, Apr 02, 2006 at 12:05:46PM -0400, Mark Lord wrote:
> >
> >>What kernel?  Any patches applied to sata_mv.c ??
> >
> >2.6.16 + ncq branch. sata_mv.c was modified by me - I'll retry
> >with a cleaner configuration, sorry.
> 
> The NCQ stuff is *unsafe* with the existing sata_mv.c,
> as there are known (to me, at least) bugs that prevent it
> from working reliably after the first I/O error of any kind.

Thanks for alerting me about that, I'll take that into consideration.
 
> The 2.6.16.1 branch is slightly better,
> and there is also the "three bug fixes" update
> that's in upstream to help things further.
>
> With all of those fixes, the module loads/unloads/reloads fine for me.

The fixes you've posted in the last weeks are merged in my tree.

However, I don't think that this particular problem has anything
to do with NCQ. In the last 2 hours I've tested a few different 
versions:

 * 2.6.16.1 with its sata_mv and the "three bug fixes" update. 
 * 2.6.16.1 + sata_mv 0.6 from 2.6.16-git back-ported.
 * 2.6.16 + ncq + modified sata_mv 0.6 (includes some changes
   I've posted before along with your fixes).

All versions show the same problem. The system in question has
two 6081 controllers and 14 disks.

My guess it that sata_mv leaves the controllers in a unclean
state and I'm now looking into this problem to see how it can
be fixed.

> If you want to use NCQ more safely, then you'll need to modify
> the mv_start_dma() routine to reinitialize the queue pointers
> each time, as they can get out of sync after an error.
> 
> There are still other bugs to be worked out and fixed, though.
> 
> I'll have a patch or two this week for the ones I know about.

I'll look forward to these patches, thanks.

-- 
Dan Aloni, Linux specialist
XIV LTD, http://www.xivstorage.com
da-x@monatomic.org, da-x@colinux.org, da-x@gmx.net, dan@xiv.co.il
