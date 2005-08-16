Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965056AbVHPBIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965056AbVHPBIe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 21:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965059AbVHPBIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 21:08:34 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:55249 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S965056AbVHPBId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 21:08:33 -0400
Subject: RE: [PATCH] add transport class symlink to device object
From: James Bottomley <James.Bottomley@SteelEye.com>
To: James.Smart@Emulex.Com
Cc: matthew@wil.cx, Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <9BB4DECD4CFE6D43AA8EA8D768ED51C201AD39@xbl3.ma.emulex.com>
References: <9BB4DECD4CFE6D43AA8EA8D768ED51C201AD39@xbl3.ma.emulex.com>
Content-Type: text/plain
Date: Mon, 15 Aug 2005 20:08:14 -0500
Message-Id: <1124154494.5089.86.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-15 at 20:52 -0400, James.Smart@Emulex.Com wrote:
> What is "0000:00:04:0" in this case ? The "device" is not a serial
> port, which is what the ttyXX back link would lead you to believe.
> Thus, it's a serial port multiplexer that supports up to N ports,
> right ? and wouldn't the more correct representation have been to
> enumerate a device for each serial port ? (e.g. 0000:00:04.0/line0,
> 0000:00:04.0/line1, or similar)

It's PCI segment 0, bus 0, slot 4, function 0, which is apparently a 3
port serial card (probably the GSP function of a pa8800?)

> Think if SCSI used this same style of representation. For example,
> if there was no scsi target device entity, but class entities did
> exist and they just pointed back to the scsi host device entry.

Yes, it's theoretically possible to have had SCSI do this.  We didn't do
it at the time because class_devices didn't exist when the SCSI tree was
first put together.  It would, however, have rather put the mockers on
doing transport classes since class devices can't point at other class
devices.

> My vote is to make the multiplexor instantiate each serial line
> as a separate device.

That's a choice that's up to the maintainer of the serial driver ...

James


