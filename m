Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265184AbUETW20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265184AbUETW20 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 18:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265267AbUETW20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 18:28:26 -0400
Received: from dcs-server2.cs.uiuc.edu ([128.174.252.3]:47330 "EHLO
	dcs-server2.cs.uiuc.edu") by vger.kernel.org with ESMTP
	id S265184AbUETW2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 18:28:23 -0400
From: "Zhenmin Li" <zli4@cs.uiuc.edu>
To: <linux-kernel@vger.kernel.org>
Subject: [OPERA] Another potential bug in /arch/mips/kernel/sysirix.c
Date: Thu, 20 May 2004 17:26:36 -0500
Message-ID: <001801c43eb9$835b09f0$76f6ae80@Turandot>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We ran our bug detection tool upon Linux 2.6.6, and found some potential
errors. 
We would sincerely appreciate your help if anyone can confirm whether they
are bugs or not.


Linux 2.6.6, /arch/mips/kernel/sysirix.c, Line 1642

1634 asmlinkage int irix_statvfs64(char *fname, struct irix_statvfs64 *buf)
1635 {
1636         struct nameidata nd;
1637         struct kstatfs kbuf;
1638         int error, i;
1639
1640         printk("[%s:%d] Wheee.. irix_statvfs(%s,%p)\n",
1641                current->comm, current->pid, fname, buf);
!1642         error = verify_area(VERIFY_WRITE, buf, sizeof(struct
irix_statvfs));
1643         if(error)
1644                 goto out;


May be changed to:
1634 asmlinkage int irix_statvfs64(char *fname, struct irix_statvfs64 *buf)
1635 {
1636         struct nameidata nd;
1637         struct kstatfs kbuf;
1638         int error, i;
1639
1640         printk("[%s:%d] Wheee.. irix_statvfs(%s,%p)\n",
1641                current->comm, current->pid, fname, buf);
!1642         error = verify_area(VERIFY_WRITE, buf, sizeof(struct
irix_statvfs64));
1643         if(error)
1644                 goto out;



Thanks a lot,
OPERA Research Group
University of Illinois at Urbana-Champaign




