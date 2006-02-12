Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbWBLC2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWBLC2L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 21:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbWBLC2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 21:28:11 -0500
Received: from xenotime.net ([66.160.160.81]:55776 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932192AbWBLC2K (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 21:28:10 -0500
Date: Sat, 11 Feb 2006 18:28:53 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: David Mansfield <lkml@dm.cobite.com>
Cc: Linux-kernel@vger.kernel.org
Subject: Re: question about values in /sys/block/???/device/type
Message-Id: <20060211182853.070d5ed4.rdunlap@xenotime.net>
In-Reply-To: <1139677626.18414.26.camel@gandalf.cobite.com>
References: <1139677626.18414.26.camel@gandalf.cobite.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Feb 2006 12:07:06 -0500 David Mansfield wrote:

> Hi, 
> 
> I'm trying to debug why my firewire harddrive is no longer handled by
> 'hald', and it seems that the value in /sys/block/sdb/device/type is 14
> (0x0e) and this is not a value handled by the program.  It is expecting
> 0x00 for disk and 0x05 for cdrom. 
> 
> In the hald source (blockdev.c), there is a comment:
> 
>     /* These magic values are documented in the kernel source */
> 
> and for the life of me I cannot find out where.  You can't exactly grep
> for 0x0e and get anything meaningful! 
> 
> Does anyone know?
> 
> BTW, I'm running the FC4 kernel: 2.6.15-1.1830_FC4 on ia32, if that
> matters.
> 
> David Mansfieldq

include/scsi/scsi.h (hint: grepping in include/scsi for /type/ -i,
this took about 5 seconds to find)

/*
 *  DEVICE TYPES
 */

#define TYPE_DISK           0x00
#define TYPE_TAPE           0x01
#define TYPE_PRINTER        0x02
#define TYPE_PROCESSOR      0x03    /* HP scanners use this */
#define TYPE_WORM           0x04    /* Treated as ROM by our system */
#define TYPE_ROM            0x05
#define TYPE_SCANNER        0x06
#define TYPE_MOD            0x07    /* Magneto-optical disk - 
				     * - treated as TYPE_DISK */
#define TYPE_MEDIUM_CHANGER 0x08
#define TYPE_COMM           0x09    /* Communications device */
#define TYPE_RAID           0x0c
#define TYPE_ENCLOSURE      0x0d    /* Enclosure Services Device */
#define TYPE_RBC	    0x0e
#define TYPE_NO_LUN         0x7f


---
~Randy
