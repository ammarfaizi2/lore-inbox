Return-Path: <linux-kernel-owner+w=401wt.eu-S933022AbWL0ROO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933022AbWL0ROO (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 12:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933017AbWL0ROK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 12:14:10 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41547 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932999AbWL0RNr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 12:13:47 -0500
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       Akinobu Mita <akinobu.mita@gmail.com>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 21/28] V4L/DVB (4994): Vivi: fix use after free in
	list_for_each()
Date: Wed, 27 Dec 2006 14:57:31 -0200
Message-id: <20061227165731.PS48805300021@infradead.org>
In-Reply-To: <20061227165016.PS89442900000@infradead.org>
References: <20061227165016.PS89442900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Akinobu Mita <akinobu.mita@gmail.com>

Freeing data including list_head in list_for_each() is not safe.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/vivi.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/media/video/vivi.c b/drivers/media/video/vivi.c
index 474ddb7..3cead24 100644
--- a/drivers/media/video/vivi.c
+++ b/drivers/media/video/vivi.c
@@ -1363,7 +1363,9 @@ static void __exit vivi_exit(void)
 	struct vivi_dev *h;
 	struct list_head *list;
 
-	list_for_each(list,&vivi_devlist) {
+	while (!list_empty(&vivi_devlist)) {
+		list = vivi_devlist.next;
+		list_del(list);
 		h = list_entry(list, struct vivi_dev, vivi_devlist);
 		kfree (h);
 	}

