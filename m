Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129429AbQLFNbB>; Wed, 6 Dec 2000 08:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131637AbQLFNav>; Wed, 6 Dec 2000 08:30:51 -0500
Received: from ruddock-207.caltech.edu ([131.215.90.207]:12036 "EHLO
	agard.caltech.edu") by vger.kernel.org with ESMTP
	id <S131598AbQLFNaf>; Wed, 6 Dec 2000 08:30:35 -0500
Message-ID: <3A2E3837.6B01FF9E@its.caltech.edu>
Date: Wed, 06 Dec 2000 04:59:36 -0800
From: James Lamanna <jlamanna@its.caltech.edu>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problems with PDC202xx driver
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whenever I tried using the PDC202xx driver in 
2.4-test11 I kept receiving the line in dmsg:
PDC20267: neither IDE port enabled (BIOS)

I traced this to ide-pci.c, line 606:
if (e->reg && (pci_read_config_byte(dev, e->reg, &tmp) 
	|| (tmp & e->mask) != e->val))
    continue;       /* port not enabled */

This if was returning true, and skipping the rest of the loop
(which sets up the ioports...)
So it looks like to me that it's not enabling the IOPorts
for this chipset. This seems like a really bad thing, considering
that I can gain no access to the drives currently using this driver.
Any suggestions?

Thanks,
--James Lamanna
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
