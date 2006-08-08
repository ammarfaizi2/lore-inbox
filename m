Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965050AbWHHVKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965050AbWHHVKn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 17:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965049AbWHHVKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 17:10:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:43466 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965048AbWHHVKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 17:10:42 -0400
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Hans Verkuil <hverkuil@xs4all.nl>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 08/14] V4L/DVB (4416): Cx25840_read4 has wrong endianness.
Date: Tue, 08 Aug 2006 18:06:53 -0300
Message-id: <20060808210653.PS88121900008@infradead.org>
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

cx25840_read4 assembled the bytes in the wrong order.

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/cx25840/cx25840-core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/video/cx25840/cx25840-core.c b/drivers/media/video/cx25840/cx25840-core.c
index 5c2036b..7bb7589 100644
--- a/drivers/media/video/cx25840/cx25840-core.c
+++ b/drivers/media/video/cx25840/cx25840-core.c
@@ -104,8 +104,8 @@ u32 cx25840_read4(struct i2c_client * cl
 	if (i2c_master_recv(client, buffer, 4) < 4)
 		return 0;
 
-	return (buffer[0] << 24) | (buffer[1] << 16) |
-	    (buffer[2] << 8) | buffer[3];
+	return (buffer[3] << 24) | (buffer[2] << 16) |
+	    (buffer[1] << 8) | buffer[0];
 }
 
 int cx25840_and_or(struct i2c_client *client, u16 addr, unsigned and_mask,

