Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbTHZO25 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 10:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263999AbTHZOMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 10:12:38 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:42246 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263787AbTHZOKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 10:10:05 -0400
Subject: Re: [2.6.0-test4] blocking access to mounted scsi devices
From: James Bottomley <James.Bottomley@steeleye.com>
To: dougg@torque.net
Cc: Christoph Hellwig <hch@infradead.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       ballen@gravity.phys.uwm.edu
In-Reply-To: <3F4B3482.4060304@torque.net>
References: <3F49B515.6010107@torque.net>
	<20030825130822.A4258@infradead.org>  <3F4B3482.4060304@torque.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 26 Aug 2003 09:08:54 -0500
Message-Id: <1061906937.1830.11.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-26 at 05:20, Douglas Gilbert wrote:
> Christoph Hellwig wrote:
> > That's because both mount (or e.g. volume managers) claims
> > devices for exclusive use, as does drivers/block/scsi_ioctl.c
> 
> Well it is reasonable that mount should exclude other attempts
> to mount. However the device holding the root file system
> may be an ATA or SCSI disk and the ide-disk and sd drivers
> do not support SMART probing directly.

Hang on, that's not the way it's supposed to work.

Mount should be on partition devices (like /dev/sda1) whereas the tools
should be on whole disc devices (like /dev/sda).  I thought we'd agreed
that even opening a partition exclusively wouldn't affect the ability to
open the whole disc device (but opening the whole disc device
exclusively would block access to all partitions).

Therefore, the only issue we should have is with volume managers that
need to open whole disc devices exclusively, and possibly with the
device mapper.

James


