Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbVLNMjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbVLNMjq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 07:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbVLNMjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 07:39:46 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:10204 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932283AbVLNMjp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 07:39:45 -0500
Subject: Re: [PATCH 2/3] add ->compat_ioctl to dasd
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
In-Reply-To: <20051214122405.GA1556@lst.de>
References: <20051213172320.GB16392@lst.de>
	 <1134562034.5496.3.camel@localhost.localdomain>
	 <20051214122405.GA1556@lst.de>
Content-Type: text/plain
Date: Wed, 14 Dec 2005 13:38:58 +0100
Message-Id: <1134563938.5496.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-14 at 13:24 +0100, Christoph Hellwig wrote:
> On Wed, Dec 14, 2005 at 01:07:14PM +0100, Martin Schwidefsky wrote:
> > On Tue, 2005-12-13 at 18:23 +0100, Christoph Hellwig wrote:
> > > Add a compat_ioctl method to the dasd driver so the last entries in
> > > arch/s390/kernel/compat_ioctl.c can go away.  Unlike the previous
> > > attempt this one does not replace the ioctl method with an
> > > unlocked_ioctl method so that the ioctl_by_bdev calls in s390 partition
> > > code continue to work.
> > 
> > Looks better but still doesn't work. The dasd driver specific ioctls do
> > work but there are some generic ones that are only available on the
> > normal ioctl path, including BLKFLSBUF, BLKROSET and HDIO_GETGEO. That
> > makes e.g. the 32 bit version of fdasd fail with "IOCTL error".
> 
> Sorry, that's the ENOIOCTLCMD thing again, I forgot it in the first
> revision of the last patch aswell.

Oh yes, I should have remember that fix. It works fine now. 

-- 
blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH


