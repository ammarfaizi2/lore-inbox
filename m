Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269474AbUINRh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269474AbUINRh6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 13:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269532AbUINRfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 13:35:51 -0400
Received: from [69.28.190.101] ([69.28.190.101]:13789 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S269483AbUINRdu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 13:33:50 -0400
Date: Tue, 14 Sep 2004 13:33:45 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Mark Lord <lkml@rtr.ca>
Cc: linux-kernel@vger.kernel.org,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] New QStor SATA/RAID Driver for 2.6.9-rc2
Message-ID: <20040914173345.GA16946@havoc.gtf.org>
References: <41471163.10709@rtr.ca> <414723B0.1090600@pobox.com> <41472A1A.6020105@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41472A1A.6020105@rtr.ca>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 01:27:54PM -0400, Mark Lord wrote:
> Here's a question for you:  like all of the other RAID drivers,
> this one needs an interface to a userland RAID management GUI.
> 
> The usual method for this is to create a fake character device driver,
> and use that as the interface to userland.  This is commonly done,
> but is it the best way to handle such?  A /proc/ or /sys/ interface
> could achieve similar goals, but without the need of a fake device.
> 
> We can go either way with this one, so lets hear some opinions on it.

Well,

* if the userland interface is 100% sending cdbs or taskfiles, then I
would prefer that Jens Axboe's "bsg" be used.  Its a chardev interface
for sending/receiving commands to a request queue.

* otherwise, I would pick either chrdev or sysfs.  if you gotta support
2.4, I guess that means chrdev.


> For the rest, this driver has been around (vendor driver) since before
> libata became usable, and certainly before libata existed in 2.4.xx.
> The driver will eventuall need to compile and run in 2.4.20,
> for customers using old Redhat kernels.   It's not there yet,
> but if it were to lean more heavily on 2.6.xx stuff,
> then that will be more difficult to achieve.

libata and all its drivers work on RHEL2.1 (2.4.9), and someone is
even crazy enough to be porting libata to 2.2.x ;-)

	Jeff



