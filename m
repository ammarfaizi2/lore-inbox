Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751023AbVLZF1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbVLZF1p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 00:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbVLZF1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 00:27:45 -0500
Received: from relay4.usu.ru ([194.226.235.39]:6302 "EHLO relay4.usu.ru")
	by vger.kernel.org with ESMTP id S1751022AbVLZF1o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 00:27:44 -0500
Message-ID: <43AF7F00.50304@ums.usu.ru>
Date: Mon, 26 Dec 2005 10:26:24 +0500
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix console utf8 composing
References: <Pine.LNX.4.61.0512242300360.29877@yvahk01.tjqt.qr> <43AE2B06.4010906@ums.usu.ru> <Pine.LNX.4.61.0512252209380.15152@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0512252209380.15152@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 6.33.0.19; VDF: 6.33.0.64; host: usu2.usu.ru)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:

>>Differences between our versions are described below.

>What do you think we should do? I have not given this fix any thought, 
>because it applied fine for long time (+/- fuzz), so I cannot comment on 
>anything in your version being better or not.

If you really don't care about characters beyond 0xffff (but see below),
please consider applying this on top of your patch:

--- linux-2.6.15-rc6/drivers/char/consolemap.c	2005-12-25 
10:02:11.000000000 +0500
+++ linux-2.6.15-rc6.my/drivers/char/consolemap.c	2005-12-25 
10:01:22.000000000 +0500
@@ -216,6 +216,7 @@
  	u16 **p1, *p2;
  	u16 *q;
  	
+	if (!p) return;
  	q = p->inverse_trans_unicode;
  	if (!q) {
  		q = p->inverse_trans_unicode =
@@ -289,6 +290,7 @@
  		p = (struct uni_pagedir *)*vc_cons[i].d->vc_uni_pagedir_loc;
  		if (p && p != q) {
  			set_inverse_transl(vc_cons[i].d, p, USER_MAP);
+			set_inverse_trans_unicode(vc_cons[i].d, p);
  			q = p;
  		}
  	}

>>My version of to_utf8() takes uint as a second argument and handles values
>>beyonf 0xffff.
>
>I doubt that there is reason to support characters beyond 0xffff.
>CJK is within 0xffff, besides that console fonts just do not have the 
>capacity to support CJK in a meaningful way.

Using console fonts is not the only way to display characters. You
forgot about jfbterm.

-- 
Alexander E. Patrakov


