Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315528AbSE2VLg>; Wed, 29 May 2002 17:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315529AbSE2VLf>; Wed, 29 May 2002 17:11:35 -0400
Received: from verlaine.noos.net ([212.198.2.73]:56388 "EHLO smtp.noos.fr")
	by vger.kernel.org with ESMTP id <S315528AbSE2VLe>;
	Wed, 29 May 2002 17:11:34 -0400
Message-ID: <3CF54413.6090200@free.fr>
Date: Wed, 29 May 2002 23:11:47 +0200
From: Christian Gennerat <xgen@free.fr>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; fr-FR; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: fr-fr
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Kernel zombie threads after module removal.
In-Reply-To: <3CF52841.8040507@noos.fr> <20020529200908.GA7499@compsoc.man.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



John Levon wrote:

>>This is very close to the problem related in 
>>http://lkml.org/archive/2002/2/4/368/index.html
>>but I have no USB. I have SCSI with aha152x_cs.o,
>>and after doing "cardctl eject" that removes the module,
>>the process scsi_eh_0  stays as zombie.
>>
>
>Add 
>
>	reparent_to_init();
>
>after the call to daemonize() in scsi_error_handler() in
>drivers/scsi/scsi_error.c
>
>Disclaimer: I don't know this code at all
>
Good.

diff -Bbu /src/linux/drivers/scsi/scsi_error.c.orig /src/linux/drivers/scsi/scsi_error.c
--- scsi_error.c.orig	Sun Sep  9 17:52:35 2001
+++ scsi_error.c	Wed May 29 22:41:32 2002
@@ -1860,6 +1860,7 @@
 	 */
 
 	daemonize();
+	reparent_to_init();
 
 	/*
 	 * Set the name of this process.


>


