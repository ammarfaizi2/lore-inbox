Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129927AbQLSS7r>; Tue, 19 Dec 2000 13:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129450AbQLSS7i>; Tue, 19 Dec 2000 13:59:38 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:47751 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129464AbQLSS73>; Tue, 19 Dec 2000 13:59:29 -0500
From: Christoph Rohland <cr@sap.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: IPC_RMID should not block the key
Organisation: SAP LinuxLab
Date: 19 Dec 2000 19:28:21 +0100
Message-ID: <qwwn1ds9sfu.fsf@sap.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

here is a patch against 2.2.18 to resemble the same behaviour for
2.2 as we have in 2.4. This is what everybody else does and the 2.2
behaviour leads to some really bad situations.

Greetings
		Christoph

diff -uNr 2.2.18/ipc/shm.c c/ipc/shm.c
--- 2.2.18/ipc/shm.c    Wed Jun  7 23:26:44 2000
+++ c/ipc/shm.c Tue Dec 19 19:10:12 2000
@@ -340,6 +340,8 @@
                        shp->u.shm_perm.mode |= SHM_DEST;
                        if (shp->u.shm_nattch <= 0)
                                killseg (id);
+                       /* Do not find it any more */
+                       shp->u.shm_perm.key = IPC_PRIVATE;
                        break;
                }
                err = -EPERM;                                                                 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
