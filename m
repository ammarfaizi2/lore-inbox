Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbTLTXyg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 18:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbTLTXyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 18:54:36 -0500
Received: from bay8-dav26.bay8.hotmail.com ([64.4.26.83]:24337 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261872AbTLTXye
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 18:54:34 -0500
X-Originating-IP: [194.236.130.199]
X-Originating-Email: [nikomail@hotmail.com]
From: "Nicklas Bondesson" <nikomail@hotmail.com>
To: "'Walt H'" <waltabbyh@comcast.net>, <linux-kernel@vger.kernel.org>
Subject: RE: Error mounting root fs on 72:01 using Promise FastTrak TX2000 (PDC20271)
Date: Sun, 21 Dec 2003 00:54:34 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcPHMfvm+NJh5OWzR+GjcZsDaRu8mgAIUjQQ
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <3FE4A6AC.802@comcast.net>
Message-ID: <BAY8-DAV26Mb5CIs4vP0000f52f@hotmail.com>
X-OriginalArrivalTime: 20 Dec 2003 23:54:33.0885 (UTC) FILETIME=[9E058CD0:01C3C754]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Oh I forgot to say that i'm running RAID1 and it detects both drives
perfectly (I'm passing the IDE addresses to the kernel at boot time from the
lilo conf, see previous post). The system was reinstalled yesterday with two
brand new 80GB Western Digital disks (WD800JB-00DUA3). The thing is, I have
succesfully installed the TX2000 card with the native ATARAID drivers before
using two 30GB Maxtor (something) disks and kernel 2.4-20 - 2.4.23. I wonder
why I can't get it up and running now. It will only work with the pre
compiled kernel shipped with Debian 3.0 (2.4.18-bf2.4). I have tried all
sorts of kernel settings. Since I have got it to work before I think should
be able to do it again.

Please advise.  

/Nicke

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Walt H
Sent: den 20 december 2003 20:45
To: nikomail@hotmail.com; linux-kernel
Subject: Re: Error mounting root fs on 72:01 using Promise FastTrak TX2000
(PDC20271)

Hello,

Is the Promise raid configured as a raid0 stripe? If so, can you see in the
boot messages if, when the ataraid driver detects the drives it is only
detecting one of the drives? Have you recently added or replaced one of the
drives?

If the ataraid driver only detects one of the drives in a raid0 array, you
might try this patch:

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


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org More majordomo info at
http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
