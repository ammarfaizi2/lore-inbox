Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269611AbUINRhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269611AbUINRhx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 13:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269474AbUINRcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 13:32:55 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:42904 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S269455AbUINR3c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 13:29:32 -0400
Message-ID: <41472A1A.6020105@rtr.ca>
Date: Tue, 14 Sep 2004 13:27:54 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] New QStor SATA/RAID Driver for 2.6.9-rc2
References: <41471163.10709@rtr.ca> <414723B0.1090600@pobox.com>
In-Reply-To: <414723B0.1090600@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Jeff,

I'll look into most of your points and give responses and changes
where required.  But first, a few overall notes on the approach.

This is a hardware RAID device, but it requires driver knowledge
of the RAID features.  It does not map to libata at all, unfortunately,
because all of the queuing features are completely non-SATA standard,
and the RAID stuff is (as normal) peculiar to the chip.

Here's a question for you:  like all of the other RAID drivers,
this one needs an interface to a userland RAID management GUI.

The usual method for this is to create a fake character device driver,
and use that as the interface to userland.  This is commonly done,
but is it the best way to handle such?  A /proc/ or /sys/ interface
could achieve similar goals, but without the need of a fake device.

We can go either way with this one, so lets hear some opinions on it.

For the rest, this driver has been around (vendor driver) since before
libata became usable, and certainly before libata existed in 2.4.xx.
The driver will eventuall need to compile and run in 2.4.20,
for customers using old Redhat kernels.   It's not there yet,
but if it were to lean more heavily on 2.6.xx stuff,
then that will be more difficult to achieve.

Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
