Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278203AbRJLXsk>; Fri, 12 Oct 2001 19:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278204AbRJLXsa>; Fri, 12 Oct 2001 19:48:30 -0400
Received: from mx5.port.ru ([194.67.57.15]:11017 "EHLO smtp5.port.ru")
	by vger.kernel.org with ESMTP id <S278203AbRJLXsO>;
	Fri, 12 Oct 2001 19:48:14 -0400
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200110122351.f9CNp4g03047@vegae.deep.net>
Subject: adlib module region leak
To: alan@lxorguk.org.uk
Date: Sat, 13 Oct 2001 03:51:00 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux-2.4.12-orig/drivers/sound/adlib_card.c.orig   Thu Oct 11 04:21:53 2001+++ linux-2.4.12/drivers/sound/adlib_card.c     Sat Oct 13 03:46:50 2001
@@ -50,8 +50,8 @@

 static void __exit cleanup_adlib(void)
 {
+       release_region(cfg.io_base, 4);
        sound_unload_synthdev(cfg.slots[0]);
-
 }

 module_init(init_adlib);

