Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262068AbVBUScN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbVBUScN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 13:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbVBUScM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 13:32:12 -0500
Received: from atlmail.prod.rxgsys.com ([64.74.124.160]:27611 "EHLO
	bastet.signetmail.com") by vger.kernel.org with ESMTP
	id S262068AbVBUSbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 13:31:51 -0500
Date: Mon, 21 Feb 2005 13:31:39 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Merging fails reading /dev/uba1
Message-ID: <20050221183139.GA5020@havoc.gtf.org>
References: <20050220200059.53db7b1e@localhost.localdomain> <20050221075131.GT4056@suse.de> <20050221102431.64de6c6c@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050221102431.64de6c6c@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2005 at 10:24:31AM -0800, Pete Zaitcev wrote:
> On Mon, 21 Feb 2005 08:51:32 +0100, Jens Axboe <axboe@suse.de> wrote:
> 
> > > [root@lembas ~]# time dd if=/dev/uba of=/dev/null bs=10k count=10240
> > > real    0m22.731s
> 
> > > [root@lembas ~]# time dd if=/dev/uba1 of=/dev/null bs=10k count=10240
> > > real    1m42.622s
> 
> > > So, reading from a partition of the same device is 5 times slower than
> > > reading from the device itself. The question is, why?
> 
> > I can't explain why the replugging slows it down, maybe you were lucky
> > to get contigious pages in the first case? As far as I can see, ub
> > effectively disables merging by setting max hw/phys segment limit of 1.
> 
> If you mean physical replugging, it has nothing to do with the issue.
> I only mentioned it to show that old pages were purged.
> 
> Contiguous pages have nothing to do with it either. I forgot to mention
> that in the first case (whole device), all reads are done with length of
> 4KB, while in the second case (partition), all reads are 512 bytes long.
> 
> Basically, the key is reading from a partition or not. It causes the
> sub-page sized merging to fail.

Does setting the blkdev's block size change things?

	Jeff



