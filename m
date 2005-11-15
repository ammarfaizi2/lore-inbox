Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751438AbVKOOvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbVKOOvb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 09:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbVKOOvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 09:51:31 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:62652 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751438AbVKOOva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 09:51:30 -0500
Subject: Re: [PATCH 1/4] add compat_ioctl methods to dasd
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20051112093340.GA15702@lst.de>
References: <20051104221652.GB9384@lst.de>  <20051112093340.GA15702@lst.de>
Content-Type: text/plain
Date: Tue, 15 Nov 2005 15:51:17 +0100
Message-Id: <1132066277.6014.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-11-12 at 10:33 +0100, Christoph Hellwig wrote:
> On Fri, Nov 04, 2005 at 11:16:52PM +0100, Christoph Hellwig wrote:
> > all dasd ioctls are directly useable from 32bit process, thus switch
> > the dasd driver to unlocked_ioctl/compat_ioctl and get rid of the
> > translations in the global table.
> 
> ping on all the four s390 compat_ioctl patches.  These are few of the
> remaining arch compat_ioctl bits and I'd really really like to get rid
> of them soonish.

Current status on the four patches:
1) dasd ioctl patch didn't compile (missing semicolon after
lock_kernel()) and doesn't work after fixing the compile problem. It's a
problem with the bdev->bd_disk->private_data which is NULL at the time
the partition detection code calls the BIODASDINFO and HDIO_GETGEO ioctl
with ioctl_by_bdev. I don't see an easy way to fix this right now.
2) fs3270 ioctl patch is fine. Fullscreen test works after fixing the
independent class_device_create problem (NULL argument missing, patch
will follow).
3) remove TIOCGSERIAL/TIOCSSERIAL patch. Fine with me. 
4) tape ioctl patch. Not yet sure about this one. Need to ask Stefan
Bader.

-- 
blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH


