Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267334AbSLEPZt>; Thu, 5 Dec 2002 10:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267335AbSLEPZs>; Thu, 5 Dec 2002 10:25:48 -0500
Received: from comtv.ru ([217.10.32.4]:44251 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S267334AbSLEPZs>;
	Thu, 5 Dec 2002 10:25:48 -0500
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] for 2.5.50, sysfs works wrong in some cases
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 05 Dec 2002 18:27:57 +0300
Message-ID: <m3n0nk1o5e.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

I've just found that 2.5.50 can't open root device specified in
'root=/dev/sda3' form. As for me, following patch solves problem:

--- vanilla/linux-2.5.50/drivers/block/genhd.c  Mon Nov 11 06:28:13 2002
+++ linux-2.5.50/drivers/block/genhd.c  Thu Dec  5 18:17:27 2002
@@ -408,7 +408,6 @@
                disk->minors = minors;
                while (minors >>= 1)
                        disk->minor_shift++;
-               kobject_init(&disk->kobj);
                disk->kobj.subsys = &block_subsys;
                INIT_LIST_HEAD(&disk->full_list);


kobject_init() will be called from kobject_register().


with best, regards

