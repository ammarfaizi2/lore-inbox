Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269104AbRHLMmJ>; Sun, 12 Aug 2001 08:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269144AbRHLMl7>; Sun, 12 Aug 2001 08:41:59 -0400
Received: from smtp-rt-7.wanadoo.fr ([193.252.19.161]:29940 "EHLO
	embelia.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S269104AbRHLMlw>; Sun, 12 Aug 2001 08:41:52 -0400
Content-Type: text/plain;
  charset="iso-8859-15"
From: Renaud =?iso-8859-15?q?Gu=E9rin?= <rguerin@free.fr>
To: linux-kernel@vger.kernel.org
Subject: 2.4.8 breaks ATM
Date: Sun, 12 Aug 2001 14:43:47 +0200
X-Mailer: KMail [version 1.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <E15Vuaq-0000BF-00@saturne.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following part of the 2.4.8 patch seems to be a typo (">>" looks more 
logical than ">" if vci_bit is a bitfield), and broke ATM for me:

--- v2.4.7/linux/net/atm/common.c       Tue Jul  3 17:08:22 2001
+++ linux/net/atm/common.c      Sun Aug  5 13:12:41 2001
@@ -210,7 +210,7 @@
 
        if ((vpi != ATM_VPI_UNSPEC && vpi != ATM_VPI_ANY &&
            vpi >> dev->ci_range.vpi_bits) || (vci != ATM_VCI_UNSPEC &&
-           vci != ATM_VCI_ANY && vci >> dev->ci_range.vci_bits))
+           vci != ATM_VCI_ANY && vci > dev->ci_range.vci_bits))
                return -EINVAL;
        if (vci > 0 && vci < ATM_NOT_RSV_VCI && 
!capable(CAP_NET_BIND_SERVICE))
                return -EPERM;


I simply reverted the patch and it works again.


-- 
-----------------------------------------------
Renaud Guerin
rguerin@free.fr - guerinre@utt.fr
Génie des Systèmes d'Information et de Décision
Université de Technologie de Troyes (France)
-----------------------------------------------
