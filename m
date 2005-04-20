Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbVDTVPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbVDTVPq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 17:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbVDTVPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 17:15:45 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:19622 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261816AbVDTVPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 17:15:34 -0400
Subject: Re: writev to scsi disks
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Dheeraj Pandey <dheeraj@gmail.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <363f92a8050420080112dec5db@mail.gmail.com>
References: <363f92a8050420080112dec5db@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 20 Apr 2005 17:15:31 -0400
Message-Id: <1114031732.5933.7.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-20 at 08:01 -0700, Dheeraj Pandey wrote:
> I was wondering if I did a simple writev to a SCSI disk, does it take
> the sg path to the device? I am guessing sg (REQ_SPECIAL) is only
> true for character devices (and ioctl's) and not block devices.

?  I think you misunderstand how writev works.  It's design is to take a
list of scattered buffers in a user program and consolidate them into a
single write.  This (in the current implementation) is a separate entity
from the block level Scatter Gather.

If by sg write path, if you mean scatter-gather write path, then yes,
that single write would be split up again into a sg list based on the
device parameters if you mean does the writev sg list control where on
the disk the data ends up, then no, if you use a disk device as a simple
file, writev consolidates all writes to the current file position.

James




