Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265676AbUE1Bap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265676AbUE1Bap (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 21:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265679AbUE1Bap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 21:30:45 -0400
Received: from dsl-3-146.novia.net ([216.40.3.146]:32914 "EHLO
	mail.optimumdata.com") by vger.kernel.org with ESMTP
	id S265676AbUE1Bam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 21:30:42 -0400
Message-ID: <40B69641.2080001@tux.obix.com>
Date: Thu, 27 May 2004 20:30:41 -0500
From: Phil Brutsche <phil@tux.obix.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: Problems with 3c59x in 2.6.7-rc1-bk*
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With a 3c905C NIC, I get a kernel panic & hard lock while trying to 
bring up the interface at boot.

After reverting the following patch (introduced in 2.6.6-bk1) there are 
no more kernel panics.  2.6.6 and earlier work fine with this card.

diff -Nru a/drivers/net/3c59x.c b/drivers/net/3c59x.c
--- a/drivers/net/3c59x.c       2004-03-13 22:54:58 -08:00
+++ b/drivers/net/3c59x.c       2004-05-10 04:25:39 -07:00
@@ -520,7 +520,7 @@
         {"3c905B-FX Cyclone 100baseFx",
          PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM, 128, },
         {"3c905C Tornado",
-        PCI_USES_IO|PCI_USES_MASTER, IS_TORNADO|HAS_NWAY|HAS_HWCKSM, 
128, },
+       PCI_USES_IO|PCI_USES_MASTER, 
IS_TORNADO|HAS_NWAY|HAS_HWCKSM|EXTRA_PREAMBLE, 128, },
         {"3c980 Cyclone",
          PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM, 128, },
         {"3c980C Python-T",

The strange part?  The patch description shows that it tries to fix 
100baseTX-FD problems with 3c905C cards... which it precisely what works 
fine here WITHOUT the patch.

Yell if anyone needs the text of the panic.

(Andrew, this is directed at you because the changelog shows the patch 
came to Linus from you via -mm)

-- 

Phil Brutsche
phil@tux.obix.com
