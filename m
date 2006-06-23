Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161470AbWFWAhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161470AbWFWAhS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 20:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161473AbWFWAhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 20:37:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50406 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161470AbWFWAhR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 20:37:17 -0400
Date: Thu, 22 Jun 2006 20:37:13 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org
Subject: fix up funky logic in dvb.
Message-ID: <20060623003713.GA14599@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6/drivers/media/dvb/dvb-core/dvb_demux.c~	2006-06-22 20:35:25.000000000 -0400
+++ linux-2.6/drivers/media/dvb/dvb-core/dvb_demux.c	2006-06-22 20:36:02.000000000 -0400
@@ -473,7 +473,7 @@ void dvb_dmx_swfilter_204(struct dvb_dem
 			goto bailout;
 		}
 		memcpy(&demux->tsbuf[i], buf, j);
-		if ((demux->tsbuf[0] == 0x47) | (demux->tsbuf[0] == 0xB8)) {
+		if ((demux->tsbuf[0] == 0x47) || (demux->tsbuf[0] == 0xB8)) {
 			memcpy(tmppack, demux->tsbuf, 188);
 			if (tmppack[0] == 0xB8)
 				tmppack[0] = 0x47;
@@ -484,7 +484,7 @@ void dvb_dmx_swfilter_204(struct dvb_dem
 	}
 
 	while (p < count) {
-		if ((buf[p] == 0x47) | (buf[p] == 0xB8)) {
+		if ((buf[p] == 0x47) || (buf[p] == 0xB8)) {
 			if (count - p >= 204) {
 				memcpy(tmppack, &buf[p], 188);
 				if (tmppack[0] == 0xB8)
-- 
http://www.codemonkey.org.uk
