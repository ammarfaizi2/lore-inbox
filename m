Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751668AbVJMT2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbVJMT2S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 15:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751663AbVJMT2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 15:28:17 -0400
Received: from xproxy.gmail.com ([66.249.82.201]:50321 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751644AbVJMT2P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 15:28:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=ainkqUxnNcRV3FSMtch1Si1ZVDDVL0F3WGQuAwmjvzdwQlzcQtax4dNXHHPd1fyYsXqd+NMU3A2Urz8QbtV7aSX9GHj2b7z3cGkqJJWbKiDNal09cvJroqeh7CmQNCD/Sdl42p9VUiagFq+XaXjjx29QzY8zrVJCxB04SXJ2QrU=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH 14/14] Big kfree NULL check cleanup - Documentation
Date: Thu, 13 Oct 2005 21:31:08 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, "Greg Kroah-Hartman" <gregkh@suse.de>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200510132131.09134.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the Documentation/ part of the big kfree cleanup patch.

Remove pointless checks for NULL prior to calling kfree() in example code in Documentation/.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

Please see the initial announcement mail on LKML with subject
"[PATCH 00/14] Big kfree NULL check cleanup"
for additional details.

 Documentation/DocBook/writing_usb_driver.tmpl |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6.14-rc4-orig/Documentation/DocBook/writing_usb_driver.tmpl	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/Documentation/DocBook/writing_usb_driver.tmpl	2005-10-12 15:25:38.000000000 +0200
@@ -345,8 +345,7 @@ if (!retval) {
   <programlisting>
 static inline void skel_delete (struct usb_skel *dev)
 {
-    if (dev->bulk_in_buffer != NULL)
-        kfree (dev->bulk_in_buffer);
+    kfree (dev->bulk_in_buffer);
     if (dev->bulk_out_buffer != NULL)
         usb_buffer_free (dev->udev, dev->bulk_out_size,
             dev->bulk_out_buffer,



