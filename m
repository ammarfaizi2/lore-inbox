Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbVCFMSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVCFMSr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 07:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVCFMSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 07:18:47 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:32981 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S261389AbVCFMSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 07:18:43 -0500
Date: Sun, 06 Mar 2005 07:18:41 -0500
From: Jim Nelson <james4765@cwazy.co.uk>
Subject: Re: [PATCH 1/13] speedtch: Clean up printk()'s in
 drivers/usb/atm/speedtch.c
In-reply-to: <20050306055635.GA12662@kroah.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <422AF521.6010609@cwazy.co.uk>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <20050305233712.7648.24364.93822@localhost.localdomain>
 <20050306055635.GA12662@kroah.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Greg KH wrote:
| On Sat, Mar 05, 2005 at 05:37:13PM -0600, James Nelson wrote:
|
|>Add a KERN_WARNING constant to a printk() that is missing it, and add a driver
|>prefix to another two in drivers/usb/atm/speedtch.c
|
|
| Please CC: usb patches to the usb maintainer, it makes it a bit hard for
| him to apply them otherwise :)
|

Sorry, screwed up with my patchbomb script...

|
|>Signed-off-by: James Nelson <james4765@gmail.com>
|>
|>diff -Nurp -x dontdiff-osdl --exclude='*~'
linux-2.6.11-mm1-original/drivers/usb/atm/speedtch.c
linux-2.6.11-mm1/drivers/usb/atm/speedtch.c
|>--- linux-2.6.11-mm1-original/drivers/usb/atm/speedtch.c	2005-03-05
13:29:48.000000000 -0500
|>+++ linux-2.6.11-mm1/drivers/usb/atm/speedtch.c	2005-03-05 13:36:44.000000000 -0500
|>@@ -192,8 +192,8 @@ static int speedtch_set_swbuff(struct sp
|> 			      0x32, 0x40, state ? 0x01 : 0x00,
|> 			      0x00, NULL, 0, 100);
|> 	if (ret < 0) {
|>-		printk("Warning: %sabling SW buffering: usb_control_msg returned %d\n",
|>-		     state ? "En" : "Dis", ret);
|>+		printk(KERN_WARNING "%s: %sabling SW buffering: usb_control_msg returned %d\n",
|>+		     speedtch_driver_name, state ? "En" : "Dis", ret);
|
|
| No, please, if you are going to convert anything like this, use the
| dev_dbg(), dev_warn(), and assorted macros instead.  Or if nothing else,
| the usb subsystem has it's own dbg(), err() and warn() macros that
| should be gotten rid of, but that's a lot of changes...
|

Okay.  A bit more work, but it makes sense.

| These comments pretty much go for all of your patches in this series,
| please rework them all.
|

Any other tips on how the usb printk()s should be formatted to maintain
consistency?  Or some driver that I could use as an example?

| thanks,
|
| greg k-h
|

Jim

- --
GPG Public key at pgp.mit.edu

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFCKvUhevfmjTWdv3MRAnkvAJ99aKDoqxVsblwktEyrAm26fymAogCfXhkm
7zsxDwAjbqEZZksxgfJKg1k=
=m+mZ
-----END PGP SIGNATURE-----
