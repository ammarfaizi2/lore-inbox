Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286519AbSABBUP>; Tue, 1 Jan 2002 20:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286517AbSABBUC>; Tue, 1 Jan 2002 20:20:02 -0500
Received: from mail.actcom.co.il ([192.114.47.13]:53926 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S286491AbSABBTu>; Tue, 1 Jan 2002 20:19:50 -0500
Message-Id: <200201020119.g021JoK32730@lmail.actcom.co.il>
Content-Type: text/plain; charset=US-ASCII
From: Itai Nahshon <nahshon@actcom.co.il>
Reply-To: nahshon@actcom.co.il
To: linux-kernel@vger.kernel.org
Subject: SCSI host numbers?
Date: Wed, 2 Jan 2002 03:19:45 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Under some scenarios Linux assigns the same
host_no to more than one scsi device.

Can someone tell me what is the intended behavior?

The problem is that a newly registered device gets
its host_no from max_scsi_host. max_scsi_host is
decremented when a device driver is unregistered
(see drivers/scsi/host.c) allowing a second new
host to reuse the same host_no.
A device that was already in use (but the module
was unloaded and reloaded gets its old host_no that
was kept in scsi_host_no_list. host_id's in scsi_host_no_list
can also be reserved at boot time (though I never tried that).

This rarely happens except when there are two or more
dynamic scsi hosts (I had i with ide-scsi and usb-storage).

I could mount devices even when they were on conflicting
host numbers (/dev/sda on usb-storage and /dev/scd0
on ide-scsi). I could access only one of the devices
via the generic-scsi interface (/dev/sgX). I do not know
what other things can get broken if scsi host get conflicting
host id.

This was tried on linux-2.4.9 (RedHat). I looked at newer
kernels but did not see an obvious fix.

Similar bug reported also to redhat. See:
http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=55876

Thanks,
-- Itai
