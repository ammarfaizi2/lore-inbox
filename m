Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbTLTTos (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 14:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbTLTTos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 14:44:48 -0500
Received: from 12-211-67-128.client.attbi.com ([12.211.67.128]:62606 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S261606AbTLTTor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 14:44:47 -0500
Message-ID: <3FE4A6AC.802@comcast.net>
Date: Sat, 20 Dec 2003 11:44:44 -0800
From: Walt H <waltabbyh@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031121
X-Accept-Language: en-us
MIME-Version: 1.0
To: nikomail@hotmail.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Error mounting root fs on 72:01 using Promise FastTrak TX2000
 (PDC20271)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Is the Promise raid configured as a raid0 stripe? If so, can you see in the boot
messages if, when the ataraid driver detects the drives it is only detecting one
of the drives? Have you recently added or replaced one of the drives?

If the ataraid driver only detects one of the drives in a raid0 array, you might
try this patch:

--- /usr/src/temp/linux-2.4.21/drivers/ide/raid/pdcraid.c       2003-06-13
07:51:34.000000000 -0700
+++ pdcraid.c   2003-07-18 06:54:25.000000000 -0700
@@ -361,7 +361,8 @@
        if (ideinfo->sect==0)
                return 0;
-       lba = (ideinfo->capacity / (ideinfo->head*ideinfo->sect));
+/*     lba = (ideinfo->capacity / (ideinfo->head*ideinfo->sect));
        lba = lba * (ideinfo->head*ideinfo->sect);
-       lba = lba - ideinfo->sect;
+       lba = lba - ideinfo->sect; */
+       lba = ideinfo->capacity - ideinfo->sect;

        return lba;

I diffed it against 2.4.21 but it should still apply. HTH,

-Walt


