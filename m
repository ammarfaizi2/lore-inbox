Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbQKPBq5>; Wed, 15 Nov 2000 20:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129279AbQKPBqr>; Wed, 15 Nov 2000 20:46:47 -0500
Received: from web1106.mail.yahoo.com ([128.11.23.126]:47620 "HELO
	web1106.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129091AbQKPBqe>; Wed, 15 Nov 2000 20:46:34 -0500
Message-ID: <20001116011632.23521.qmail@web1106.mail.yahoo.com>
Date: Thu, 16 Nov 2000 02:16:32 +0100 (CET)
From: willy tarreau <wtarreau@yahoo.fr>
Subject: Re: 2.4.0-test11-pre5/drivers/net/sunhme.c compile failure on x86
To: "David S. Miller" <davem@redhat.com>, adam@yggdrasil.com
Cc: willy@meta-x.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !

(thanks Dave for the quick patch)

I also had to move the #include <asm/uaccess.h>
out of the #ifdef __sparc__/#endif because
copy_{from|to}_user were left undefined (see
simple patch below).

Regards,
Willy


--- drivers/net/sunhme.c-orig   Wed Nov 15 12:56:33
2000
+++ drivers/net/sunhme.c        Wed Nov 15 12:59:35
2000
@@ -48,8 +48,8 @@
 #ifndef __sparc_v9__
 #include <asm/io-unit.h>
 #endif
-#include <asm/uaccess.h>
 #endif
+#include <asm/uaccess.h>
 
 #include <asm/pgtable.h>
 #include <asm/irq.h>


___________________________________________________________
Do You Yahoo!? -- Pour dialoguer en direct avec vos amis, 
Yahoo! Messenger : http://fr.messenger.yahoo.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
