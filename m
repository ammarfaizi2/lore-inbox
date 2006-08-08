Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030233AbWHHVOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbWHHVOW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 17:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030301AbWHHVOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 17:14:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:59338 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030233AbWHHVN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 17:13:56 -0400
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Hans Verkuil <hverkuil@xs4all.nl>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 09/14] V4L/DVB (4418): Fix broken msp3400 module option
	'standard'
Date: Tue, 08 Aug 2006 18:06:54 -0300
Message-id: <20060808210654.PS04688300009@infradead.org>
In-Reply-To: <20060808210151.PS78629800000@infradead.org>
References: <20060808210151.PS78629800000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Hans Verkuil <hverkuil@xs4all.nl>

Due to a wrong statement order the 'standard' module option didn't
work for 'G' model chips.

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/msp3400-kthreads.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/video/msp3400-kthreads.c b/drivers/media/video/msp3400-kthreads.c
index f2fd919..ed02ff8 100644
--- a/drivers/media/video/msp3400-kthreads.c
+++ b/drivers/media/video/msp3400-kthreads.c
@@ -961,10 +961,10 @@ int msp34xxg_thread(void *data)
 		/* setup the chip*/
 		msp34xxg_reset(client);
 		state->std = state->radio ? 0x40 : msp_standard;
-		if (state->std != 1)
-			goto unmute;
 		/* start autodetect */
 		msp_write_dem(client, 0x20, state->std);
+		if (state->std != 1)
+			goto unmute;
 
 		/* watch autodetect */
 		v4l_dbg(1, msp_debug, client, "started autodetect, waiting for result\n");

