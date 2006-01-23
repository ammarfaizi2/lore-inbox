Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751431AbWAWI1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbWAWI1H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 03:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWAWI1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 03:27:07 -0500
Received: from xproxy.gmail.com ([66.249.82.202]:64075 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751431AbWAWI1F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 03:27:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=uqstlhvGqqC/HagtUbEYiVGc7d618VfOUSBhjkCH0fxKHKII4SjfU7+blqUW23LBw3HknthdutZoWOLF4P8Yj5TRH8vmP6mEoXlv9jUWi7BC9mmXH+gGIcciaC88GCIxLibDLQOslAmNJHTg0AaB5IpkzQX6j6u4aedHeX+MgJk=
Message-ID: <43D490C9.7000302@gmail.com>
Date: Mon, 23 Jan 2006 16:16:09 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] fbcon: Fix screen artifacts when moving cursor
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When moving the cursor by writing to /dev/vcs*, the old cursor image is not
erased.  Fix by hiding the cursor first before moving the cursor to the
new position.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/char/vt.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/char/vt.c b/drivers/char/vt.c
index f1d9cb7..0900d1d 100644
--- a/drivers/char/vt.c
+++ b/drivers/char/vt.c
@@ -3213,6 +3213,7 @@ void getconsxy(struct vc_data *vc, unsig
 
 void putconsxy(struct vc_data *vc, unsigned char *p)
 {
+	hide_cursor(vc);
 	gotoxy(vc, p[0], p[1]);
 	set_cursor(vc);
 }

