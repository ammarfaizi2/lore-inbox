Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316491AbSGVGdf>; Mon, 22 Jul 2002 02:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316503AbSGVGdf>; Mon, 22 Jul 2002 02:33:35 -0400
Received: from mail.cogenit.fr ([195.68.53.173]:46815 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S316491AbSGVGdf>;
	Mon, 22 Jul 2002 02:33:35 -0400
Date: Mon, 22 Jul 2002 08:35:48 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: support <support@promise.com.tw>
Cc: Hank <hanky@promise.com.tw>, linux-kernel@vger.kernel.org,
       marcelo@conectiva.com.br, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] 2.4.19-rc2-ac2 pdc202xx.c update
Message-ID: <20020722083548.A27973@fafner.intra.cogenit.fr>
References: <01b801c22f0b$c02cc360$47cba8c0@promise.com.tw> <01ee01c2312e$22976900$47cba8c0@promise.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01ee01c2312e$22976900$47cba8c0@promise.com.tw>; from support@promise.com.tw on Mon, Jul 22, 2002 at 11:16:04AM +0800
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

support <support@promise.com.tw> :
[...]
> We don't occur Oops you said, Please check your patch rule again.

There's a side effect with your macro. Let's expand it:

+#define set_2regs(a, b) \
+        OUT_BYTE((a + adj), indexreg); \
+       OUT_BYTE(b, datareg);
[...]
+       if (speed == XFER_UDMA_2)
+               set_2regs(thold, (IN_BYTE(datareg) & 0x7f));

	if (speed == XFER_UDMA_2)
		OUT_BYTE((thold + adj), indexreg);
	OUT_BYTE((IN_BYTE(datareg) & 0x7f), datareg);

Do you see the problem ?

-- 
Ueimor
