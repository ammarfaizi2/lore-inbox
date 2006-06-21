Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030271AbWFUUjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030271AbWFUUjG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 16:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbWFUUjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 16:39:06 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:24965 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S1030271AbWFUUjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 16:39:04 -0400
Date: Wed, 21 Jun 2006 22:38:34 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: andi@lisas.de
cc: Alan Stern <stern@rowland.harvard.edu>, Bodo Eggert <7eggert@gmx.de>,
       Andrew Morton <akpm@osdl.org>, linux-usb-devel@lists.sourceforge.net,
       gregkh@suse.de, linux-kernel@vger.kernel.org, hal@lists.freedesktop.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [linux-usb-devel] USB/hal: USB open() broken? (USB CD burner
 underruns, USB HDD hard resets)
In-Reply-To: <20060621191640.GA8596@rhlx01.fht-esslingen.de>
Message-ID: <Pine.LNX.4.58.0606212231400.4403@be1.lrz>
References: <20060621163410.GA22736@rhlx01.fht-esslingen.de>
 <Pine.LNX.4.44L0.0606211501290.8272-100000@iolanthe.rowland.org>
 <20060621191640.GA8596@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006, Andreas Mohr wrote:

[...]
> And the obvious question would be whether the sdkp->openers++ thingy
> could somehow be extended to enclose all hardware device users so that
> e.g. sr.c wouldn't send ALLOW_MEDIUM_REMOVAL on a device already locked
> by e.g. the sd.c driver.
> Difficult question, though, since the group of drivers possible to use
> with a certain device is not a static set:
> it could be via
> - sr.c
> - sd.c
> - IDE (in the case of ATA devices mapped via ide-scsi)

> Is it possible to have such a per-*hardware*-device instance in the kernel
> to keep track of various things such as number of device openers?
> I'll do some investigation myself, too...

The sg part should be implemented by each SCSI device, reducing the 
current sg device to a mostly empty shell. Then you can prevent that
empty shell from binding to devices having more specific drivers.
-- 
Top 100 things you don't want the sysadmin to say:
30. And what does it mean 'rm: .o: No such file or directory'?
