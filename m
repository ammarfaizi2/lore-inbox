Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292609AbSBZVLs>; Tue, 26 Feb 2002 16:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293600AbSBZVLi>; Tue, 26 Feb 2002 16:11:38 -0500
Received: from relay1.pair.com ([209.68.1.20]:9995 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S292609AbSBZVL2>;
	Tue, 26 Feb 2002 16:11:28 -0500
X-pair-Authenticated: 68.5.32.62
Content-Type: text/plain; charset=US-ASCII
From: Shane Nay <shane@minirl.com>
To: linux-kernel@vger.kernel.org
Subject: Simple cyberjack diff
Date: Tue, 26 Feb 2002 14:16:35 -0800
X-Mailer: KMail [version 1.3]
Cc: linux-usb@sii.li
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020226211128Z292609-889+7550@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While looking around the usb code I noticed this semaphore problem in
cyberjack.  Anyway, it's a quicky.

Thanks,
Shane Nay.

--- virgin/linux/drivers/usb/serial/cyberjack.c Fri Dec 21 09:41:55 2001
+++ linux/drivers/usb/serial/cyberjack.c        Tue Feb 26 14:09:31 2002
@@ -238,7 +238,8 @@
        if( (count+priv->wrfilled)>sizeof(priv->wrbuf) ) {
                /* To much data  for buffer. Reset buffer. */
                priv->wrfilled=0;
-               return (0);
+               count=0;
+               goto exit;
        }
 
        /* Copy data */
@@ -299,7 +300,7 @@
                        priv->wrsent=0;
                }
        }
-
+exit:
        up (&port->sem);
        return (count);
 } 
