Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261760AbVGQDMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbVGQDMr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 23:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261805AbVGQDMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 23:12:47 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:56587 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261760AbVGQDLf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 23:11:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=j4zh6DMXBl+fPvaFrIU00mWisSFxQ8HQ11rvb/MpP+WRXMu0XlUjVfotm8VxAzsEYchCdzjjqY2nh4NitkLx5CyWNbrRqOWwR/ZxeZkzY08NvsuUk/tOoiEvsBvLhL/Msxsms08/iBmg3VYQnWr2H4k///5ThcLTTfKfGJ4LtEU=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] make SPEAKUP_DEFAULT depend on SPEAKUP
Date: Sun, 17 Jul 2005 05:29:41 +0200
User-Agent: KMail/1.8.1
Cc: Kirk Reiser <kirk@braille.uwo.ca>, speakup@braille.uwo.ca, akpm@osdl.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507170529.42532.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When running `make oldconfig' with my 2.6.13-rc3 config on 2.6.13-rc3-mm1 I
got a bit surprised when I answered `N'o to CONFIG_SPEAKUP but then still 
got prompted for CONFIG_SPEAKUP_DEFAULT - that didn't make sense, why would 
I want to select a default synthesizer for speakup if I have disabled speakup 
alltogether in the first place?
The patch below makes SPEAKUP_DEFAULT depend on SPEAKUP. I believe that's the 
sane thing to do :)


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/char/speakup/Kconfig |    1 +
 1 files changed, 1 insertion(+)

--- linux-2.6.13-rc3-mm1-orig/drivers/char/speakup/Kconfig	2005-07-17 04:39:45.000000000 +0200
+++ linux-2.6.13-rc3-mm1/drivers/char/speakup/Kconfig	2005-07-17 05:15:05.000000000 +0200
@@ -204,6 +204,7 @@
 endif
 
 config SPEAKUP_DEFAULT
+	depends on SPEAKUP
 	string "Choose Default synthesizer for Speakup"
 	default "none"
 
