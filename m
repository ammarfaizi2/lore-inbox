Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265557AbUEZMtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265557AbUEZMtz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 08:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265568AbUEZMtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 08:49:55 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:21670 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265557AbUEZMtv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 08:49:51 -0400
Date: Wed, 26 May 2004 14:49:44 +0200
From: Jens Axboe <axboe@suse.de>
To: Anders Gustafsson <andersg@0x63.nu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm5
Message-ID: <20040526124944.GQ5322@suse.de>
References: <20040522013636.61efef73.akpm@osdl.org> <20040526124158.GA3679@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040526124158.GA3679@h55p111.delphi.afb.lu.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26 2004, Anders Gustafsson wrote:
> On Sat, May 22, 2004 at 01:36:36AM -0700, Andrew Morton wrote:
> > 
> > - Implementation of request barriers for IDE and SCSI.  The idea here is
> >   that a filesystem can tag an IO request as a barrier and the disk will not
> >   reorder writes across the barrier.  It provides additional integrity
> >   guarantees for the journalling filesystems.  The feature is enabled for
> >   reiserfs and ext3.
> 
> I get: this error message when using barriers on a scsi disk:
> 
> lost page write due to I/O error on sdb1
> JBD: barrier-based sync failed on sdb1 - bisabling barriers
> 
> and I don't want them barriers bisabled :)
> 
> ext3 filesystem. reiser also disables barriers.
> 
> I have a "Adaptec AIC-7902 U320 (rev 3)" SCSI controller and the disk is a
> SEAGATE ST373307LW.

But they need to be bisabled, since -o barrier doesn't work on SCSI yet.
Only non-data tagged flushes are supported, those from
blkdev_issue_flush().

-- 
Jens Axboe

