Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbVKSQyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbVKSQyb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 11:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbVKSQyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 11:54:31 -0500
Received: from smtp113.sbc.mail.re2.yahoo.com ([68.142.229.92]:15500 "HELO
	smtp113.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750721AbVKSQya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 11:54:30 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Stas Sergeev <stsp@aknet.ru>
Subject: Re: 2.6.15-rc1-mm1 Oops
Date: Sat, 19 Nov 2005 11:54:27 -0500
User-Agent: KMail/1.8.3
Cc: Linux kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <437F34C7.4010301@aknet.ru>
In-Reply-To: <437F34C7.4010301@aknet.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511191154.28028.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 November 2005 09:20, Stas Sergeev wrote:
> Hi.
> 
> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc1/2.6.15-rc1-mm1
> Everything works fine on plain 2.6.14.
> Since 2.6.14-mm1 I am getting the attached Oops
> (grabbed via netconsole, from 2.6.15-rc1-mm1).
> After that Oops, the PC is completely dead.
> The Oops happens when the saa7134 module is being
> modprobed. Any ideas?
> 
> 

Ok, that was me ;) Please try the patch below.

-- 
Dmitry

Fix an OOPS when initializing IR remote on saa7134

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/media/video/saa7134/saa7134-input.c |    2 ++
 1 files changed, 2 insertions(+)

Index: work/drivers/media/video/saa7134/saa7134-input.c
===================================================================
--- work.orig/drivers/media/video/saa7134/saa7134-input.c
+++ work/drivers/media/video/saa7134/saa7134-input.c
@@ -713,6 +713,8 @@ int saa7134_input_init1(struct saa7134_d
 		return -ENOMEM;
 	}
 
+	ir->dev = input_dev;
+
 	/* init hardware-specific stuff */
 	ir->mask_keycode = mask_keycode;
 	ir->mask_keydown = mask_keydown;
