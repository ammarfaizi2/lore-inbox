Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315746AbSHVTRm>; Thu, 22 Aug 2002 15:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315762AbSHVTRm>; Thu, 22 Aug 2002 15:17:42 -0400
Received: from mail01.qualys.com ([12.162.2.5]:13446 "HELO mail01.qualys.com")
	by vger.kernel.org with SMTP id <S315746AbSHVTRl>;
	Thu, 22 Aug 2002 15:17:41 -0400
Date: Thu, 22 Aug 2002 10:49:48 -0700
From: Silvio Cesare <silvio@qualys.com>
To: linux-kernel@vger.kernel.org
Cc: silvio@qualys.com
Subject: [PATCH TRIVIAL]: linux-2.5.31/drivers/telephony/ixj.c
Message-ID: <20020822104948.A7968@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

trivial patch to fix the check for following kmalloc size overflow with
elements_used (the type being checked and the type being used were
different, and of different sizes).

--
Silvio

--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch.2.5.31.ixj"

diff -u linux-2.5.31/drivers/telephony/ixj.c dev/linux-2.5.31/drivers/telephony/ixj.c
--- linux-2.5.31/drivers/telephony/ixj.c	Sat Aug 10 18:41:18 2002
+++ dev/linux-2.5.31/drivers/telephony/ixj.c	Thu Aug 22 10:45:51 2002
@@ -5943,7 +5943,7 @@
 	lcp = kmalloc(sizeof(IXJ_CADENCE), GFP_KERNEL);
 	if (lcp == NULL)
 		return -ENOMEM;
-	if (copy_from_user(lcp, (char *) cp, sizeof(IXJ_CADENCE)) || (unsigned)lcp->elements_used >= ~0U/sizeof(IXJ_CADENCE) )
+	if (copy_from_user(lcp, (char *) cp, sizeof(IXJ_CADENCE)) || (unsigned)lcp->elements_used >= ~0U/sizeof(IXJ_CADENCE_ELEMENT) )
         {
                 kfree(lcp);
                 return -EFAULT;

--J/dobhs11T7y2rNN--
