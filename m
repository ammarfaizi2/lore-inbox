Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131880AbQKTObp>; Mon, 20 Nov 2000 09:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131879AbQKTObg>; Mon, 20 Nov 2000 09:31:36 -0500
Received: from users.portal.ru ([195.16.96.19]:45065 "EHLO users.portal.ru")
	by vger.kernel.org with ESMTP id <S131844AbQKTObZ>;
	Mon, 20 Nov 2000 09:31:25 -0500
Message-ID: <3A192EBC.F5B048F2@cyberplat.ru>
Date: Mon, 20 Nov 2000 17:01:32 +0300
From: Oleg Makarenko <omakarenko@cyberplat.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18-21 i686)
X-Accept-Language: ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.2.18pre22: ppa_fail(3) from ppa_wait at line 319
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.2.18pre22 I get a lot of scsidisk I/O errors on my parallel port
zip.

All pervious versions of 2.2.18pre worked fine. The problem is 100%
reproducible and occurs
after a long period of inactivity (10 or more minutes)

compiled with #define PPA_DEBUG 1 I get:

ppa_fail(3) from ppa_wait at line 319

if you need more information please contact me directly as I am not on
the list

the following partial reversal patch seems to help (but I am not sure it
is correct):

--- ppa.c.2.2.18pre22   Mon Nov 20 16:54:36 2000
+++ ppa.c       Mon Nov 20 16:54:54 2000
@@ -690,7 +690,7 @@
            }
        }
        /* Now check to see if the drive is ready to comunicate */
-       r = ppa_wait(host_no); /* need ppa_wait() - PJC */
+      r = (r_str(ppb) & 0xf0);
        /* If not, drop back down to the scheduler and wait a timer tick
*/
        if (!(r & 0x80))
            return 0;



Oleg



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
