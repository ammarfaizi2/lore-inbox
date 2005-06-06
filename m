Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbVFFWes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbVFFWes (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 18:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbVFFWWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 18:22:53 -0400
Received: from hell.org.pl ([62.233.239.4]:56836 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S261739AbVFFWV5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 18:21:57 -0400
Date: Tue, 7 Jun 2005 00:21:51 +0200
From: Karol Kozimor <sziwan@hell.org.pl>
To: Hanno =?iso-8859-2?Q?B=F6ck?= <mail@hboeck.de>
Cc: randy_dunlap <rdunlap@xenotime.net>, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, julien.lerouge@free.fr
Subject: Re: [ACPI] Re: Kernel oops with asus_acpi module
Message-ID: <20050606222151.GB65@hell.org.pl>
Mail-Followup-To: Hanno =?iso-8859-2?Q?B=F6ck?= <mail@hboeck.de>,
	randy_dunlap <rdunlap@xenotime.net>,
	acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	julien.lerouge@free.fr
References: <200506052340.41074.mail@hboeck.de> <20050606135459.7ad699ae.rdunlap@xenotime.net> <20050606213248.GA22238@hell.org.pl> <200506062347.10582.mail@hboeck.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200506062347.10582.mail@hboeck.de>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Hanno Böck:
> Am Montag, 6. Juni 2005 23:32 schrieb Karol Kozimor:
> > May I see the DSDT? The Samsung P30 INIT method referenced in
> > asus_hotk_get_info() is not supposed to return anything, not even an empty
> > string. I believe the new ACPICA implicit return might be interfering.
> > Here's the relevant part of what I based the code on:

Thanks. This might also help:

--- a/drivers/acpi/asus_acpi.c	2005-04-26 00:38:20.000000000 +0200
+++ b/drivers/acpi/asus_acpi.c	2005-06-07 00:18:17.000000000 +0200
@@ -992,7 +992,7 @@
 
 	/* Samsung P30 has a device with a valid _HID whose INIT does not 
 	 * return anything. Catch this one and any similar here */
-	if (buffer.pointer == NULL) {
+	if (buffer.pointer == NULL || buffer.length == 0) {
 		if (asus_info && /* Samsung P30 */
 		    strncmp(asus_info->oem_table_id, "ODEM", 4) == 0) {
 			hotk->model = P30;

But I'd like to get the full oops with the matching asus_acpi.o file also
(might be off the list).

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
