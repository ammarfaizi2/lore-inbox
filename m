Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbTILPtX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 11:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbTILPtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 11:49:23 -0400
Received: from mail32.messagelabs.com ([62.173.108.211]:28850 "HELO
	mail32.messagelabs.com") by vger.kernel.org with SMTP
	id S261731AbTILPtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 11:49:21 -0400
X-VirusChecked: Checked
X-Env-Sender: liam.girdwood@wolfsonmicro.com
X-Msg-Ref: server-22.tower-32.messagelabs.com!1063381860!1236953
X-StarScan-Version: 5.0.7; banners=wolfsonmicro.com,-,-
Subject: [PATCH] AC97 2.4.23-pre3 -  WM9712 suspend/resume
From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Content-Type: text/plain
Message-Id: <1063381757.7795.25.camel@caernarfon>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 12 Sep 2003 16:49:17 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch eliminates pop noises when doing a PM suspend/resume with the
WM9712 AC97 codec.

It should probably also be applied against the 2.6.0-test series.

Cheers

Liam



diff -urN linux-2.4.23-pre3/drivers/sound/ac97_codec.c
linux-2.4.23-pre3-lg1/drivers/sound/ac97_codec.c
--- linux-2.4.23-pre3/drivers/sound/ac97_codec.c        2003-08-25
12:44:42.000000000 +0100
+++ linux-2.4.23-pre3-lg1/drivers/sound/ac97_codec.c    2003-09-12
15:12:42.000000000 +0100
@@ -1077,6 +1077,11 @@
 /* WM9711, WM9712 */
 static int wolfson_init11(struct ac97_codec * codec)
 {
+       /* stop pop's during suspend/resume */
+       codec->codec_write(codec, AC97_WM97XX_TEST,
+               codec->codec_read(codec, AC97_WM97XX_TEST) & 0xffbf);
+
+
        /* set out3 volume */
        codec->codec_write(codec, AC97_WM9711_OUT3VOL, 0x0808);
        return 0;


-- 
Liam Girdwood <liam.girdwood@wolfsonmicro.com>


Wolfson Microelectronics plc
www.wolfsonmicro.com
T +44 131 272 7000
F +44 131 272 7001
Registered in Scotland 89839

This message may contain confidential or proprietary information. If you receive this message in error, please immediately delete it, destroy all copies of it and notify the sender. Any views expressed in this message are those of the individual sender, except where the message states otherwise. We take reasonable precautions to ensure our Emails are virus free. However, we cannot accept responsibility for any virus transmitted by us and recommend that you subject any incoming Email to your own virus checking procedures.
