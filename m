Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262464AbSKTUhD>; Wed, 20 Nov 2002 15:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262415AbSKTUhD>; Wed, 20 Nov 2002 15:37:03 -0500
Received: from ns.splentec.com ([209.47.35.194]:39941 "EHLO pepsi.splentec.com")
	by vger.kernel.org with ESMTP id <S262464AbSKTUhC>;
	Wed, 20 Nov 2002 15:37:02 -0500
Message-ID: <3DDBF413.C06DAF2E@splentec.com>
Date: Wed, 20 Nov 2002 15:44:03 -0500
From: Luben Tuikov <luben@splentec.com>
Organization: Splentec Ltd.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: [PATCH]: jiffies wrap in ll_rw_blk.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- ll_rw_blk.c.old     Wed Nov 20 15:32:50 2002
+++ ll_rw_blk.c Wed Nov 20 15:33:06 2002
@@ -2092,7 +2092,7 @@
                complete(req->waiting);
 
        if (disk) {
-               unsigned long duration = jiffies - req->start_time;
+               unsigned long duration = (signed) jiffies - (signed) req->start_time;
                switch (rq_data_dir(req)) {
                    case WRITE:
                        disk->writes++;
