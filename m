Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbWDWR6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbWDWR6l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 13:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbWDWR6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 13:58:40 -0400
Received: from nz-out-0102.google.com ([64.233.162.199]:12728 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751434AbWDWR6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 13:58:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=DgPn+ugLavNXz7GqWAO5ORGNpZXcDwS0gjRcuI88cIooL5UcNGc2GJ/nQfsACWAdGIli8V9OcZYsPNZh/hFn1/7tZjH+mb43AZvSSipz0VgwtCtgksNADqyoDOpvF0Sx2oZqDAM7Rmb1nsF3hFykRtYNXZX5HVeul4XhA0Eh0O0=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Resource leak fix for whiteheat driver
Date: Sun, 23 Apr 2006 19:59:23 +0200
User-Agent: KMail/1.9.1
Cc: Greg Kroah-Hartman <greg@kroah.com>,
       Stuart MacDonald <stuartm@connecttech.com>,
       linux-usb-devel@lists.sourceforge.net,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604231959.23877.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We may return from drivers/usb/serial/whiteheat.c::whiteheat_attach() 
without freeing `result' if we leave via the no_firmware: label.

Spotted by the coverity checker as #670


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/usb/serial/whiteheat.c |    1 +
 1 files changed, 1 insertion(+)

--- linux-2.6.17-rc2-git4-orig/drivers/usb/serial/whiteheat.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.17-rc2-git4/drivers/usb/serial/whiteheat.c	2006-04-23 19:52:27.000000000 +0200
@@ -508,6 +508,7 @@ no_firmware:
 	err("%s: Unable to retrieve firmware version, try replugging\n", serial->type->description);
 	err("%s: If the firmware is not running (status led not blinking)\n", serial->type->description);
 	err("%s: please contact support@connecttech.com\n", serial->type->description);
+	kfree(result);
 	return -ENODEV;
 
 no_command_private:



