Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290502AbSBFNQ1>; Wed, 6 Feb 2002 08:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290500AbSBFNQR>; Wed, 6 Feb 2002 08:16:17 -0500
Received: from [62.245.135.174] ([62.245.135.174]:12995 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S290496AbSBFNQI>;
	Wed, 6 Feb 2002 08:16:08 -0500
Message-ID: <3C612C91.38441A85@TeraPort.de>
Date: Wed, 06 Feb 2002 14:16:01 +0100
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Reply-To: m.knoblauch@TeraPort.de
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18-pre4-J0-VM-22-preempt-lock i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: marcelo@conectiva.com.br
Subject: [PATCH] Add amount of cached memory to sysreq-m output
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 02/06/2002 02:16:00 PM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 02/06/2002 02:16:07 PM,
	Serialize complete at 02/06/2002 02:16:07 PM
Content-Type: multipart/mixed;
 boundary="------------E873FED574EF83BBA1E11C05"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E873FED574EF83BBA1E11C05
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii

Hi,

 this small patch against fs/buffer.c adds the Cached memory to the
output of sysreq-m requests. Applies against 2.4.18-pre8.

--- buffer.c.orig       Wed Feb  6 13:46:19 2002
+++ buffer.c    Wed Feb  6 13:48:55 2002
@@ -2724,6 +2724,9 @@
        printk("Buffer memory:   %6dkB\n",
                        atomic_read(&buffermem_pages) <<
(PAGE_SHIFT-10));

+       printk("Cache memory:   %6dkB\n",
+                      
(atomic_read(&page_cache_size)-atomic_read(&buffermem_pages)) <<
(PAGE_SHIFT-10));
+
 #ifdef CONFIG_SMP /* trylock does nothing on UP and so we could
deadlock */
        if (!spin_trylock(&lru_list_lock))
                return;


Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
--------------E873FED574EF83BBA1E11C05
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii;
 name="buffer.c-patch"
Content-Disposition: inline;
 filename="buffer.c-patch"

--- buffer.c.orig	Wed Feb  6 13:46:19 2002
+++ buffer.c	Wed Feb  6 13:48:55 2002
@@ -2724,6 +2724,9 @@
 	printk("Buffer memory:   %6dkB\n",
 			atomic_read(&buffermem_pages) << (PAGE_SHIFT-10));
 
+	printk("Cache memory:   %6dkB\n",
+			(atomic_read(&page_cache_size)- atomic_read(&buffermem_pages)) << (PAGE_SHIFT-10));
+
 #ifdef CONFIG_SMP /* trylock does nothing on UP and so we could deadlock */
 	if (!spin_trylock(&lru_list_lock))
 		return;

--------------E873FED574EF83BBA1E11C05--

