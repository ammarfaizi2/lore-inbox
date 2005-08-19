Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932568AbVHSFzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932568AbVHSFzc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 01:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbVHSFzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 01:55:32 -0400
Received: from smtp103.sbc.mail.re2.yahoo.com ([68.142.229.102]:18336 "HELO
	smtp103.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932565AbVHSFzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 01:55:31 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: sysfs: write returns ENOMEM?
Date: Fri, 19 Aug 2005 00:55:25 -0500
User-Agent: KMail/1.8.2
Cc: Greg KH <gregkh@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508190055.25747.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Apologies if you see this message twice - I accidentially sent it in HTML
 format first time around and I am pretty sure LKML will eat it]

Hi,

According to the SuS write() can not return ENOMEM, only ENOBUFS is allowed
(surprisingly read() is allowed to use both ENOMEM and ENOBUFS):

http://www.opengroup.org/onlinepubs/000095399/functions/write.html

Should we adjust sysfs write to follow the standard?

-- 
Dmitry

===================================================================
sysfs: write should return ENOBUFS

According to SuS ENOMEM is not a valid return code for write(),
ENOBUFS should be returned.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 fs/sysfs/file.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: work/fs/sysfs/file.c
===================================================================
--- work.orig/fs/sysfs/file.c
+++ work/fs/sysfs/file.c
@@ -180,7 +180,7 @@ fill_write_buffer(struct sysfs_buffer * 
 	if (!buffer->page)
 		buffer->page = (char *)get_zeroed_page(GFP_KERNEL);
 	if (!buffer->page)
-		return -ENOMEM;
+		return -ENOBUFS;
 
 	if (count >= PAGE_SIZE)
 		count = PAGE_SIZE;
