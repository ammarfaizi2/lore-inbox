Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315717AbSHVSzo>; Thu, 22 Aug 2002 14:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315720AbSHVSzl>; Thu, 22 Aug 2002 14:55:41 -0400
Received: from mail01.qualys.com ([12.162.2.5]:24746 "HELO mail01.qualys.com")
	by vger.kernel.org with SMTP id <S315717AbSHVSzk>;
	Thu, 22 Aug 2002 14:55:40 -0400
Date: Thu, 22 Aug 2002 11:04:43 -0700
From: Silvio Cesare <silvio@qualys.com>
To: linux-kernel@vger.kernel.org
Cc: silvio@qualys.com
Subject: [PATCH TRIVIAL] linux-2.5.31/drivers/scsi/sg.c
Message-ID: <20020822110443.A8182@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

remove 1 verify_area call which is directly followed with a __copy_to_user,
and replace with just a copy_to_user.

--
Silvio

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch.2.5.31.sg"

diff -u linux-2.5.31/drivers/scsi/sg.c dev/linux-2.5.31/drivers/scsi/sg.c
--- linux-2.5.31/drivers/scsi/sg.c	Sat Aug 10 18:41:28 2002
+++ dev/linux-2.5.31/drivers/scsi/sg.c	Thu Aug 22 11:02:29 2002
@@ -493,9 +493,7 @@
 	    sb_len = (hp->mx_sb_len > sb_len) ? sb_len : hp->mx_sb_len;
 	    len = 8 + (int)srp->sense_b[7]; /* Additional sense length field */
 	    len = (len > sb_len) ? sb_len : len;
-	    if ((err = verify_area(VERIFY_WRITE, hp->sbp, len)))
-		goto err_out;
-	    if (__copy_to_user(hp->sbp, srp->sense_b, len)) {
+	    if (copy_to_user(hp->sbp, srp->sense_b, len)) {
 		err = -EFAULT;
 		goto err_out;
 	    }

--BXVAT5kNtrzKuDFl--
