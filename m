Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWEGCCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWEGCCz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 22:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWEGCCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 22:02:55 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:61802 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750822AbWEGCCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 22:02:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=h23K6sf9eW2QZAlqiQWJn2GkQZTqH+dcmTqHVjGlQQrBFe5W5ct+wAPzpKuE86DIxyRPWaombQENH8U3D9Mq5wYcYat9F0eOIwsgHAUgycKZ0UwEi6kFr55xUf+oxaq46DrAMWyQghabm5ZZnrzDhyzTJOBMBWoix+APYEtNYLw=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix mem-leak in sidewinder driver
Date: Sun, 7 May 2006 04:03:47 +0200
User-Agent: KMail/1.9.1
Cc: Vojtech Pavlik <vojtech@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605070403.47763.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In sw_connect we leak 'buf' and 'idbuf' when we do not leave via one of 
the fail* labels. This was spotted by the coverity checker.
This patch fixes the memory leak.

Patch is compile tested only due to lack of hardware.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/input/joystick/sidewinder.c |    2 ++
 1 files changed, 2 insertions(+)

--- linux-2.6.17-rc3-git12-orig/drivers/input/joystick/sidewinder.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.17-rc3-git12/drivers/input/joystick/sidewinder.c	2006-05-07 03:57:47.000000000 +0200
@@ -776,6 +776,8 @@ static int sw_connect(struct gameport *g
 			goto fail4;
 	}
 
+	kfree(buf);
+	kfree(idbuf);
 	return 0;
 
  fail4:	input_free_device(sw->dev[i]);


