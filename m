Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264656AbUFVPzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264656AbUFVPzY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 11:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264880AbUFVPw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 11:52:26 -0400
Received: from mail.convergence.de ([212.84.236.4]:35783 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S264982AbUFVPvf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 11:51:35 -0400
Message-ID: <40D85585.1060608@gmx.de>
Date: Tue, 22 Jun 2004 17:51:33 +0200
From: Michael Hunold <m.hunold@gmx.de>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: sensors@stimpy.netroedge.com, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       a.othieno@bluewin.ch
Subject: [PATCH][2.6] drivers/media/video/tda9840.c: honour return code of
 i2c_add_driver()
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

i2c_add_driver() may actually fail, but my driver returns 0
regardless. Thanks to Arthur Othieno <a.othieno@bluewin.ch> for this 
obviously correct patch.

Signed-off-by: Michael Hunold <hunold@linuxtv.org>
Signed-off-by: Arthur Othieno <a.othieno@bluewin.ch>

  tda9840.c |    7 +++----
  1 files changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/media/video/tda9840.c	2003-12-18 03:59:06.000000000 +0100
+++ b/drivers/media/video/tda9840.c	2004-06-04 18:15:25.000000000 +0200
@@ -268,13 +268,12 @@ static struct i2c_driver driver = {
          .command	= tda9840_command,
  };

-static int tda9840_init_module(void)
+static int __init tda9840_init_module(void)
  {
-        i2c_add_driver(&driver);
-        return 0;
+        return i2c_add_driver(&driver);
  }

-static void tda9840_cleanup_module(void)
+static void __exit tda9840_cleanup_module(void)
  {
          i2c_del_driver(&driver);
  }


