Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267395AbSKTCxr>; Tue, 19 Nov 2002 21:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267537AbSKTCxr>; Tue, 19 Nov 2002 21:53:47 -0500
Received: from 1-064.ctame701-1.telepar.net.br ([200.181.137.64]:47550 "EHLO
	1-064.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S267395AbSKTCxp>; Tue, 19 Nov 2002 21:53:45 -0500
Date: Wed, 20 Nov 2002 01:00:33 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andy Chou <acc@CS.Stanford.EDU>
cc: mc@cs.stanford.edu, <linux-kernel@vger.kernel.org>, <linux@advansys.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Re: [CHECKER] 74 potential buffer overruns in 2.5.33
In-Reply-To: <20021119234531.GA2723@Xenon.stanford.edu>
Message-ID: <Pine.LNX.4.44L.0211192358500.4103-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2002, Andy Chou wrote:

> [BUG] Clear cut.
> /home/acc/linux/2.5.33/drivers/scsi/advansys.c:5100:advansys_detect:
> ERROR:BUFFER:5100:5100:Array bounds error: ep->adapter_info[6] indexed
> with [6]
>                 ep->adapter_info[1] = asc_dvc_varp->cfg->adapter_info[1];
>                 ep->adapter_info[2] = asc_dvc_varp->cfg->adapter_info[2];
>                 ep->adapter_info[3] = asc_dvc_varp->cfg->adapter_info[3];
>                 ep->adapter_info[4] = asc_dvc_varp->cfg->adapter_info[4];
>                 ep->adapter_info[5] = asc_dvc_varp->cfg->adapter_info[5];
>
> Error --->
>                 ep->adapter_info[6] = asc_dvc_varp->cfg->adapter_info[6];
>
>                /*
>                 * Modify board configuration.

Nice catch.  The fix should be simple too, since the 7th field
doesn't seem to be referenced anywhere else in advansys.c.

Bob, does the attached trivial patch look ok to you ?

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>


===== drivers/scsi/advansys.c 1.18 vs edited =====
--- 1.18/drivers/scsi/advansys.c	Tue Oct 15 16:13:00 2002
+++ edited/drivers/scsi/advansys.c	Wed Nov 20 01:00:08 2002
@@ -5100,7 +5100,6 @@
                 ep->adapter_info[3] = asc_dvc_varp->cfg->adapter_info[3];
                 ep->adapter_info[4] = asc_dvc_varp->cfg->adapter_info[4];
                 ep->adapter_info[5] = asc_dvc_varp->cfg->adapter_info[5];
-                ep->adapter_info[6] = asc_dvc_varp->cfg->adapter_info[6];

                /*
                 * Modify board configuration.

