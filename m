Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbUIHMcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbUIHMcZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 08:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbUIHMcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 08:32:25 -0400
Received: from [195.23.16.24] ([195.23.16.24]:13717 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261711AbUIHMaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 08:30:55 -0400
Message-ID: <413EFB7A.8000303@grupopie.com>
Date: Wed, 08 Sep 2004 13:30:50 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kallsyms: fix sparc gibberish
Content-Type: multipart/mixed;
 boundary="------------060809050504030802080500"
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.6; VDF: 6.27.0.50; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060809050504030802080500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


This one liner fixes the bug of using ".word" to represent 16 bits
quantities, that made kallsyms produce gibberish on sparc.

Although it works on almost every platform except sparc, it should
really use ".short" or ".hword" to represent 16 bits on any platform.

Please apply,


Signed-Off-By: Paulo Marques <pmarques@grupopie.com>

-- 
Paulo Marques - www.grupopie.com

To err is human, but to really foul things up requires a computer.
Farmers' Almanac, 1978

--------------060809050504030802080500
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

--- linux-2.6.9-rc1-mm3/scripts/kallsyms.c	2004-09-05 21:51:14.000000000 +0100
+++ linux-2.6.9-rc1-kall/scripts/kallsyms.c	2004-09-05 21:52:38.000000000 +0100
@@ -303,7 +303,7 @@ write_src(void)
 
 	output_label("kallsyms_token_index");
 	for (i = 0; i < 256; i++)
-		printf("\t.word\t%d\n", best_idx[i]);
+		printf("\t.short\t%d\n", best_idx[i]);
 	printf("\n");
 }
 

--------------060809050504030802080500--
