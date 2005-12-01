Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbVLAPiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbVLAPiE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 10:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbVLAPiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 10:38:04 -0500
Received: from noname.neutralserver.com ([70.84.186.210]:26582 "EHLO
	noname.neutralserver.com") by vger.kernel.org with ESMTP
	id S932273AbVLAPiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 10:38:02 -0500
Date: Thu, 1 Dec 2005 17:39:28 +0200
From: Dan Aloni <da-x@monatomic.org>
To: Christoph Hellwig <hch@infradead.org>, Luke-Jr <luke-jr@utopios.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.x] prevent emulated SCSI hosts from wasting DMA memory
Message-ID: <20051201153928.GA21753@localdomain>
References: <20051130171520.GB15505@localdomain> <200511301933.48668.luke-jr@utopios.org> <20051130210222.GA32431@localdomain> <20051201113610.GG3958@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051201113610.GG3958@infradead.org>
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

On Thu, Dec 01, 2005 at 11:36:10AM +0000, Christoph Hellwig wrote:
> On Wed, Nov 30, 2005 at 11:02:23PM +0200, Dan Aloni wrote:
> > On Wed, Nov 30, 2005 at 07:33:47PM +0000, Luke-Jr wrote:
> > > On Wednesday 30 November 2005 17:15, Dan Aloni wrote:
> > > > Emulated scsi hosts don't do DMA, so don't unnecessarily increase
> > > > the SCSI DMA pool.
> > > 
> > > They don't? Recently I learned(?) that apparently using hdparm -d on the 
> > > old /dev/hdX device still worked/applied when using ide-scsi... or do 
> > > "emulated scsi hosts" refer to something else?
> > 
> > Actually by 'do DMA' I meant use the scsi_malloc() interface - which 
> > is mostly used by low level drivers. The IDE drivers allocate their
> > DMA memory outside the SCSI layer. iSCSI hosts for instance, don't 
> > need to cause unnecessary DMA allocations.
> 
> (1) there's no guranteee a driver setting ->emulated can't use scsi_malloc
> (2) 2.4.x is very late in the cycle so there's just no point in putting this
>     in (and in 2.6.x scsi_malloc is gone fortunately)

(1) you're right, the SCSI subsystem itself uses scsi_malloc(). But I 
wonder, would it be okay to simply replace scsi_malloc() invocations 
with kmalloc of GFP_ATOMIC and GFP_DMA? I mean, to take the relevant
bits out of the 2.5.1-pre11 patch and give it a shot?

(2) you are right again, but fact is that 2.4.x is still being used 
on some production systems for stability reasons (and also because 
the SCSI kernel interfaces in 2.6.x weren't stabilized yet).

More specifically, I've made that patch to be able to connect to 
a large number of iSCSI targets without problems. I wonder if 
there's another way for doing that instead of upgrading to 2.6.x.

-- 
Dan Aloni
da-x@monatomic.org, da-x@colinux.org, da-x@gmx.net
