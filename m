Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932572AbWF0UKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572AbWF0UKz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 16:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbWF0UKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 16:10:55 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:44163 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932567AbWF0UKx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 16:10:53 -0400
Message-Id: <20060627200831.308779000@sous-sol.org>
References: <20060627200745.771284000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 27 Jun 2006 00:00:01 -0700
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
Subject: [PATCH 01/25] USB: Whiteheat: fix firmware spurious errors
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

--- linux-2.6.17.1.orig/drivers/usb/serial/whiteheat.c
+++ linux-2.6.17.1/drivers/usb/serial/whiteheat.c
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
