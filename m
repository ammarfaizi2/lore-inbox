Return-Path: <linux-kernel-owner+w=401wt.eu-S1161184AbXAMB4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161184AbXAMB4H (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 20:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161182AbXAMB4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 20:56:07 -0500
Received: from wx-out-0506.google.com ([66.249.82.231]:29406 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161184AbXAMB4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 20:56:04 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=GHirPMzfyDjGneB1KPVf0Pvp+eepVAJd8jOvd2S3S55i2LQiY6RA0JaBC56/eJXurt1B+g+eTJlQyk35BKg2aFl4XM7yXvGIk8dEWbJWSZI0455u+MxAEGSFQ+z44ZJ+IUwM2tafjpQJ8/fkAFz9lReOIEsBHup67Wi0ZcnDxzk=
Message-ID: <45A83C22.6050409@gmail.com>
Date: Sat, 13 Jan 2007 10:55:46 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Soeren Sonnenburg <kernel@nn7.de>
CC: Jeff Garzik <jeff@garzik.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: SATA hotplug from the user side ?
References: <1168588629.5403.7.camel@localhost>	 <45A7BFB0.9090308@garzik.org> <1168639639.3707.6.camel@localhost>
In-Reply-To: <1168639639.3707.6.camel@localhost>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Soeren Sonnenburg wrote:
> It is true it detects a removal and newly plugged devices immediately...
> However it still prints warnings and errors that it could not
> synchronize SCSI cache for the disks. Then it prints regular 'rejects
> I/O to dead device' warning messages and on replugging the disks puts
> them to the next free sd device (e.g. sdc -> sdd).

You need to stop using the devices before unplugging.  If you have no
pending IO to the device, there won't be 'rejects IO to dead device'
messages.  You can ignore the SCSI cache sync failure if the device is
properly closed before being unplugged.

> These messages sound eval - so now the question is should I care ?
> ( On the other hand it did not crash the machine )

So, no, you don't really have to care.  Just make sure the device is
unmounted prior to unplugging.

-- 
tejun
