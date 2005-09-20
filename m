Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932620AbVITGPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620AbVITGPe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 02:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932674AbVITGPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 02:15:34 -0400
Received: from mf2.realtek.com.tw ([220.128.56.22]:517 "EHLO
	mf2.realtek.com.tw") by vger.kernel.org with ESMTP id S932620AbVITGPe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 02:15:34 -0400
Message-ID: <01bf01c5bdaa$9e8b81c0$106215ac@realtek.com.tw>
From: "colin" <colin@realtek.com.tw>
To: <linux-kernel@vger.kernel.org>
Subject: CONFIG_PRINTK doesn't makes size smaller
Date: Tue, 20 Sep 2005 14:14:55 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2005/09/20 =?Bog5?B?pFWkyCAwMjoxNDo1NQ==?=,
	Serialize by Router on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2005/09/20 =?Bog5?B?pFWkyCAwMjoxNDo1OA==?=,
	Serialize complete at 2005/09/20 =?Bog5?B?pFWkyCAwMjoxNDo1OA==?=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="big5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there,
I tried to make kernel with CONFIG_PRINTK off. I considered it should become
smaller, but it didn't because it actually isn't an empty function, and
there are many copies of it in vmlinux, not just one. Here is its
definition:
    static inline int printk(const char *s, ...) { return 0; }

I change the definition to this and it can greatly reduce the size by about
5%:
    #define printk(...) do {} while (0)
However, this definition would lead to error in some situations. For
example:
    1. (printk)
    2. ret = printk

I hope someone could suggest a better definition of printk that can both
make printk smaller and eliminate errors.

Regards,
Colin


