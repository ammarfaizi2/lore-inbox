Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262880AbVBCQB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262880AbVBCQB5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 11:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263390AbVBCQB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 11:01:57 -0500
Received: from mail.suse.de ([195.135.220.2]:31390 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262880AbVBCQBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 11:01:44 -0500
Date: Thu, 3 Feb 2005 16:37:47 +0100
From: Karsten Keil <kkeil@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Oskar Senft <oskar.senft@gmx.de>
Subject: ISDN4Linux Bug in isdnhdlc.c
Message-ID: <20050203153747.GB6990@pingi3.kke.suse.de>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
	Oskar Senft <oskar.senft@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.8-24.10-default i686
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Oskar found a critical bug in isdnhdlc.c, please
apply this simple fix to next versions.



From: Oskar Senft <oskar.senft@gmx.de>

isdnhdlc_decode is called multiple times for bigger frames, so
decrementing dsize is a bad idea and can cause a overflow of
the dst buffer.


Signed-off-by: Karsten Keil <kkeil@suse.de>

diff -ur linux-2.6.11-rc2.org/drivers/isdn/hisax/isdnhdlc.c linux-2.6.11-rc2/drivers/isdn/hisax/isdnhdlc.c
--- linux-2.6.11-rc2.org/drivers/isdn/hisax/isdnhdlc.c	2004-11-23 15:53:25.000000000 +0100
+++ linux-2.6.11-rc2/drivers/isdn/hisax/isdnhdlc.c	2005-02-03 15:50:06.352137856 +0100
@@ -308,7 +308,7 @@
 				hdlc->crc = crc_ccitt_byte(hdlc->crc, hdlc->shift_reg);
 
 				// good byte received
-				if (dsize--) {
+				if (hdlc->dstpos < dsize) {
 					dst[hdlc->dstpos++] = hdlc->shift_reg;
 				} else {
 					// frame too long

-- 
Karsten Keil
SuSE Labs
ISDN development
