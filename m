Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751467AbWGYGuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbWGYGuO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 02:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbWGYGuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 02:50:14 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:51139 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751467AbWGYGuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 02:50:12 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc2 Intermittent failures to detect sata disks 
In-reply-to: Your message of "Tue, 25 Jul 2006 16:27:34 +1000."
             <9927.1153808854@kao2.melbourne.sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 25 Jul 2006 16:49:01 +1000
Message-ID: <10560.1153810141@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens (on Tue, 25 Jul 2006 16:27:34 +1000) wrote:
>Jeff Garzik (on Tue, 25 Jul 2006 01:57:08 -0400) wrote:
>>Keith Owens wrote:
>>> Keith Owens (on Fri, 21 Jul 2006 16:18:47 +1000) wrote:
>>>> I am seeing an intermittent failures to detect sata disks on
>>>> 2.6.18-rc2.  Dell SC1425, PIIX chipset, gcc 4.1.0 (opensuse 10.1).
>>>> Sometimes it will detect both disks, sometimes only one, sometimes none
>>>> at all.  AFAICT it only occurs after a soft reboot, and possibly only
>>>> after an emergency reboot.  Alas the problem is so intermittent that it
>>>> is hard to tell what conditions will trigger it.
>>> 
>>> I applied the debug patch below, turn on prink timing and set
>>> initdefault to 6 so the machine was in a continual soft reboot cycle.
>>> After multiple cycles I got this trace.  piix_sata_prereset() reads a
>>> zero config byte for almost 15 seconds then it changes to 0x11,
>>> followed by a hang.  Why is the config byte initially zero, and what
>>> makes it change?  The normal value for pcs is 0x33.
>>
>>Can you try 2.6.18-rc2-git3?
>>
>>	Jeff
>
>Running now, with the trivial bug fix below plus my debug patch.  I
>will leave it running overnight, this problem is very intermittent.

Failed again on 2.6.18-rc2-git3.  80+ seconds of this before I killed
the power.  No sign of it getting any data from the sata PCI config.

[    8.689136] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[    8.755861] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
[    8.827741] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[    8.894446] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0

