Return-Path: <linux-kernel-owner+w=401wt.eu-S1751106AbXAFCa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbXAFCa3 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbXAFCaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:30:15 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:36522 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751115AbXAFC3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:29:42 -0500
Message-Id: <20070106023327.206717000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:17 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Chuck Ebbert <76306.1226@compuserve.com>,
       Mike Miller <mike.miller@hp.com>
Subject: [patch 24/50] cciss: fix XFER_READ/XFER_WRITE in do_cciss_request
Content-Disposition: inline; filename=cciss-fix-xfer_read-xfer_write-in-do_cciss_request.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Mike Miller <mike.miller@hp.com>

This patch fixes a stupid bug. Sometime during the 2tb enhancement I ended up
replacing the macros XFER_READ and XFER_WRITE with h->cciss_read and
h->cciss_write respectively. It seemed to work somehow at least on x86_64 and
ia64. I don't know how. But people started complaining about command timeouts
on older controllers like the 64xx series and only on ia32. This resolves the
issue reproduced in our lab. Please consider this for inclusion. 

Signed-off-by: Mike Miller <mike.miller@hp.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 drivers/block/cciss.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19.1.orig/drivers/block/cciss.c
+++ linux-2.6.19.1/drivers/block/cciss.c
@@ -2530,7 +2530,7 @@ static void do_cciss_request(request_que
 	c->Request.Type.Type = TYPE_CMD;	// It is a command.
 	c->Request.Type.Attribute = ATTR_SIMPLE;
 	c->Request.Type.Direction =
-	    (rq_data_dir(creq) == READ) ? h->cciss_read : h->cciss_write;
+	    (rq_data_dir(creq) == READ) ? XFER_READ : XFER_WRITE;
 	c->Request.Timeout = 0;	// Don't time out
 	c->Request.CDB[0] =
 	    (rq_data_dir(creq) == READ) ? h->cciss_read : h->cciss_write;

--
