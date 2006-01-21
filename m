Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbWAUT5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWAUT5O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 14:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWAUT5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 14:57:14 -0500
Received: from noname.neutralserver.com ([70.84.186.210]:39385 "EHLO
	noname.neutralserver.com") by vger.kernel.org with ESMTP
	id S932303AbWAUT5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 14:57:14 -0500
Date: Sat, 21 Jan 2006 22:00:17 +0200
From: Dan Aloni <da-x@monatomic.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Jones <davej@redhat.com>, AChittenden@bluearc.com,
       linux-kernel@vger.kernel.org, lwoodman@redhat.com,
       Jens Axboe <axboe@suse.de>
Subject: Re: Out of Memory: Killed process 16498 (java).
Message-ID: <20060121200016.GA32197@localdomain>
References: <89E85E0168AD994693B574C80EDB9C270355601F@uk-email.terastack.bluearc.com> <20060119194836.GM21663@redhat.com> <20060119170305.2e8ae353.akpm@osdl.org> <20060120012844.GE3798@redhat.com> <20060119174920.4a842f03.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060119174920.4a842f03.akpm@osdl.org>
User-Agent: Mutt/1.5.11
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

On Thu, Jan 19, 2006 at 05:49:20PM -0800, Andrew Morton wrote:
> Dave Jones <davej@redhat.com> wrote:
> >
> > The Fedora user in the bug report
> > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=175173
> > who on x86-64 with 5GB saw zone_dma exhausted saw a similar result,
> > delays the kill, but it does still happen.
> 
> Again, that person's ZONE_DMA has *zero* pages on the LRU.  Something has
> consumed all of the piddling little zone for kernel data structures.  It is
> a true oom.
> 
> We need to work out who is using all this ZONE_DMA memory and make them
> stop it.

It reminds me, we had a similar problem in the 2.4.x kernel with 
many SCSI hosts loaded - that caused scsi_malloc (which uses DMA) 
to consume a lot of DMA memory and trigger the OOM. I know that code 
was much rewritten for 2.6.x, through DMA allocations in the SCSI 
subsystem (regardless of drivers) still exist here and there.

-- 
Dan Aloni
da-x@monatomic.org, da-x@colinux.org, da-x@gmx.net, dan@xiv.co.il
