Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbWFFPn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbWFFPn2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 11:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbWFFPn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 11:43:28 -0400
Received: from rtr.ca ([64.26.128.89]:18098 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751316AbWFFPn1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 11:43:27 -0400
Message-ID: <4485A299.7070007@rtr.ca>
Date: Tue, 06 Jun 2006 11:43:21 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: usb device problem
References: <44859A9B.6080202@gmail.com>
In-Reply-To: <44859A9B.6080202@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> Hello,
> 
> I get this with 2.6.17-rc5-mm3 kernel:
..
> usb-storage: device found at 10
> usb-storage: waiting for device to settle before scanning
>   Vendor:           Model:                   Rev:
>   Type:   Direct-Access                      ANSI SCSI revision: 00
> SCSI device sdb: 245920 512-byte hdwr sectors (126 MB)
..
> now read and write and sync or umount, then:
> ---
> sd 10:0:0:0: SCSI error: return code = 0x10070000
> end_request: I/O error, dev sdb, sector 1575
> sd 10:0:0:0: SCSI error: return code = 0x10070000
> end_request: I/O error, dev sdb, sector 1583
> sd 10:0:0:0: SCSI error: return code = 0x10070000
> end_request: I/O error, dev sdb, sector 1591
> sd 10:0:0:0: SCSI error: return code = 0x10070000
> end_request: I/O error, dev sdb, sector 1599
> sd 10:0:0:0: SCSI error: return code = 0x10070000
> end_request: I/O error, dev sdb, sector 1607
> sd 10:0:0:0: SCSI error: return code = 0x10070000
> end_request: I/O error, dev sdb, sector 1615
> ... and so on. data are maybe there, but it takes so long to write a meg file.
> sometimes
..

This *looks* like maybe the drive reported a sector read error,
and the standard "fail the whole request one block at a time"
error mechanism from sd.c has kicked in.

I have a patch to fix this behaviour (in sd.c), but it has not yet
been decided whether to go upstream with it or not.

The same behaviour bites anything from libata as well,
and possibly also (not verified) firewire drives.

Cheers
