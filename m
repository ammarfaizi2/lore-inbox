Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWEVWIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWEVWIo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 18:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWEVWIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 18:08:44 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:2159 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751232AbWEVWIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 18:08:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=hn+5JDsSp+lO+3JLdPXaZ0BWUxWc1mZzbJ7s4hEne/jrW2L2DmheT8V1KuGTEZ6HqjpLN5NT25rC0ZyANiwE3IcFNt9FebQjxil88w0zOF0SXPqk9hZx7UmVr7OOMAz4jzQLP59oSY6SCaUZ574dh/78IgIhDRsKlP3vEDDktZ0=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/3][resend] moxa: remove pointless check of 'tty' argument vs NULL
Date: Tue, 23 May 2006 00:09:42 +0200
User-Agent: KMail/1.9.1
Cc: Alan Cox <alan@redhat.com>, Martin Mares <mj@ucw.cz>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Moxa Technologies <support@moxa.com.tw>, linux-kernel@vger.kernel.org,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605230009.42853.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(This patch was originaly send on 15/05-2006 - this is a resend.
 Patch still applies cleanly to 2.6.17-rc4-mm3)


Remove pointless check of 'tty' argument vs NULL from moxa driver.
(applies on top of patch 1/3)

(Discussion about the patch when it was initially posted resulted in 
agreement that this is the right thing to do.)


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/char/mxser.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.17-rc4-mm1/drivers/char/mxser.c.1	2006-05-15 22:33:49.000000000 +0200
+++ linux-2.6.17-rc4-mm1/drivers/char/mxser.c	2006-05-15 22:34:38.000000000 +0200
@@ -1081,7 +1081,7 @@ static int mxser_write(struct tty_struct
 	struct mxser_struct *info = tty->driver_data;
 	unsigned long flags;
 
-	if (!tty || !info->xmit_buf)
+	if (!info->xmit_buf)
 		return (0);
 
 	while (1) {
@@ -1117,7 +1117,7 @@ static void mxser_put_char(struct tty_st
 	struct mxser_struct *info = tty->driver_data;
 	unsigned long flags;
 
-	if (!tty || !info->xmit_buf)
+	if (!info->xmit_buf)
 		return;
 
 	if (info->xmit_cnt >= SERIAL_XMIT_SIZE - 1)



