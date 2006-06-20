Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965120AbWFTLtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965120AbWFTLtE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 07:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965121AbWFTLtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 07:49:03 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:16257 "EHLO
	sequoia.sous-sol.org") by vger.kernel.org with ESMTP
	id S965120AbWFTLs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 07:48:59 -0400
Message-Id: <20060620114615.337607000@sous-sol.org>
References: <20060620114527.934114000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 20 Jun 2006 00:00:01 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, <greg@kroah.com>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "Stuart MacDonald" <stuartm@connecttech.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 01/13] USB: Whiteheat: fix firmware spurious errors
Content-Disposition: inline; filename=usb-whiteheat-fix-firmware-spurious-errors.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From:  <stuartm@connecttech.com>

Attached patch fixes spurious errors during firmware load.

Signed-off-by: Stuart MacDonald <stuartm@connecttech.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 drivers/usb/serial/whiteheat.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.16.21.orig/drivers/usb/serial/whiteheat.c
+++ linux-2.6.16.21/drivers/usb/serial/whiteheat.c
@@ -388,7 +388,7 @@ static int whiteheat_attach (struct usb_
 	if (ret) {
 		err("%s: Couldn't send command [%d]", serial->type->description, ret);
 		goto no_firmware;
-	} else if (alen != sizeof(command)) {
+	} else if (alen != 2) {
 		err("%s: Send command incomplete [%d]", serial->type->description, alen);
 		goto no_firmware;
 	}
@@ -400,7 +400,7 @@ static int whiteheat_attach (struct usb_
 	if (ret) {
 		err("%s: Couldn't get results [%d]", serial->type->description, ret);
 		goto no_firmware;
-	} else if (alen != sizeof(result)) {
+	} else if (alen != sizeof(*hw_info) + 1) {
 		err("%s: Get results incomplete [%d]", serial->type->description, alen);
 		goto no_firmware;
 	} else if (result[0] != command[0]) {

--
