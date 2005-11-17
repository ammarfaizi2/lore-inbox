Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161116AbVKQCe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161116AbVKQCe3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 21:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161117AbVKQCe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 21:34:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:10884 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161116AbVKQCe3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 21:34:29 -0500
Date: Wed, 16 Nov 2005 18:34:24 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: David =?UTF-8?B?SMOkcmRlbWFu?= <david@2gen.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB key generates ioctl_internal_command errors
Message-Id: <20051116183424.5f1ebeac.zaitcev@redhat.com>
In-Reply-To: <mailman.1132184643.7273.linux-kernel2news@redhat.com>
References: <mailman.1132184643.7273.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Nov 2005 23:52:32 +0100, David Härdeman <david@2gen.com> wrote:

> usb-storage: waiting for device to settle before scanning
>   Vendor: I0MEGA    Model: UMni1GB*IOM2K4    Rev: 1.01
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> SCSI device sda: 2048000 512-byte hdwr sectors (1049 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 00 00 00
> sda: assuming drive cache: write through
> ioctl_internal_command: <8 0 0 0> return code = 8000002
>    : Current: sense key=0x0
>     ASC=0x0 ASCQ=0x0
> SCSI device sda: 2048000 512-byte hdwr sectors (1049 MB)

I think it's harmless. I saw things like that, and initially I plugged
them with workarounds like this:

/*
 * Pete Zaitcev <zaitcev@yahoo.com>, from Patrick C. F. Ernzer, bz#162559.
 * The key does not actually break, but it returns zero sense which
 * makes our SCSI stack to print confusing messages.
 */
UNUSUAL_DEV(  0x0457, 0x0150, 0x0100, 0x0100,
		"USBest Technology",	/* sold by Transcend */
		"USB Mass Storage Device",
		US_SC_DEVICE, US_PR_DEVICE, NULL, US_FL_NOT_LOCKABLE ),

But perhaps we want the SCSI stack to do something about it, dunno.

If you're nervous about messages, use ub, it's mostly silent :-)

-- Pete
