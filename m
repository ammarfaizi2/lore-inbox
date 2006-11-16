Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162246AbWKPCpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162246AbWKPCpz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162248AbWKPCp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:45:29 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:46991 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1162243AbWKPCpM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:45:12 -0500
Message-Id: <20061116024602.250030000@sous-sol.org>
References: <20061116024332.124753000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 15 Nov 2006 18:43:43 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, maks@sternwelten.at
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Oliver Neukum <oliver@neukum.name>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 11/30] USB: failure in usblps error path
Content-Disposition: inline; filename=usb-failure-in-usblp-s-error-path.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Oliver Neukum <oliver@neukum.name>

if urb submission fails due to a transient error here eg. ENOMEM
, the driver is dead. This fixes it.

	Regards
		Oliver

Signed-off-by: Oliver Neukum <oliver@neukum.name>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/usb/class/usblp.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.18.2.orig/drivers/usb/class/usblp.c
+++ linux-2.6.18.2/drivers/usb/class/usblp.c
@@ -701,6 +701,7 @@ static ssize_t usblp_write(struct file *
 		usblp->wcomplete = 0;
 		err = usb_submit_urb(usblp->writeurb, GFP_KERNEL);
 		if (err) {
+			usblp->wcomplete = 1;
 			if (err != -ENOMEM)
 				count = -EIO;
 			else

--
