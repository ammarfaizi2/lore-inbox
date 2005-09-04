Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbVIDXos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbVIDXos (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbVIDXat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:30:49 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:25473 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932089AbVIDX37
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:29:59 -0400
Message-Id: <20050904232317.799069000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:04 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andreas Oberritter <obi@linuxtv.org>
Content-Disposition: inline; filename=dvb-core-demux-sw-sectionfilter-fix.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 05/54] core: dvb_demux: fix continuity counter error handling
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Oberritter <obi@linuxtv.org>

Don't return immediately from dvb_dmx_swfilter_section_packet() if CC is not ok.
Otherwise a new feed drops all packets until the first packet with CC=0 arrives.

Signed-off-by: Andreas Oberritter <obi@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dvb-core/dvb_demux.c |    1 -
 1 file changed, 1 deletion(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-core/dvb_demux.c	2005-09-04 22:24:24.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-core/dvb_demux.c	2005-09-04 22:27:54.000000000 +0200
@@ -336,7 +336,6 @@ static int dvb_dmx_swfilter_section_pack
 		*/
 		feed->pusi_seen = 0;
 		dvb_dmx_swfilter_section_new(feed);
-		return 0;
 	}
 
 	if (buf[1] & 0x40) {

--

