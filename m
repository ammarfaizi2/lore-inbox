Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbVCWPMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbVCWPMh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 10:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVCWPMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 10:12:36 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:46208 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261616AbVCWPMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 10:12:33 -0500
Subject: Re: [PATCH scsi-misc-2.6 08/08] scsi: fix hot unplug sequence
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Tejun Heo <htejun@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4240F5A9.80205@gmail.com>
References: <20050323021335.960F95F8@htj.dyndns.org>
	 <20050323021335.4682C732@htj.dyndns.org>
	 <1111550882.5520.93.camel@mulgrave>  <4240F5A9.80205@gmail.com>
Content-Type: text/plain
Date: Wed, 23 Mar 2005 09:12:16 -0600
Message-Id: <1111590736.5441.10.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-23 at 13:50 +0900, Tejun Heo wrote:
>   Well, but it's because scsi midlayer calls back into usb-storage eh 
> after the detaching process is complete.

Yes, but that's legitimate.  It's always been explicitly stated that we
can't ensure absolute synchronisation in the stack:  storage devices
must expect to have to reject I/O for devices they think have been
removed.

> > However, the current host code does need fixing, but the fix is to move
> > it over to a proper state model rather than the current bit twiddling we
> > do.
> 
>   I agree & am working on it.  This patch was mainly to verify Jens' oops.

Thanks!  You can look at the device state model as a guide ...
originally that was a bit mask too.

James

