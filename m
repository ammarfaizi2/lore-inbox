Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280136AbRJaKsp>; Wed, 31 Oct 2001 05:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280142AbRJaKsf>; Wed, 31 Oct 2001 05:48:35 -0500
Received: from mta13-acc.tin.it ([212.216.176.44]:26283 "EHLO fep13-svc.tin.it")
	by vger.kernel.org with ESMTP id <S280136AbRJaKs2>;
	Wed, 31 Oct 2001 05:48:28 -0500
Message-ID: <3BDFD716.1D4D9393@revicon.com>
Date: Wed, 31 Oct 2001 11:48:54 +0100
From: Lars Knudsen <gandalf@revicon.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: becker@scyld.com, linux-kernel@vger.kernel.org,
        Alan Cox <laughing@shared-source.org>
Subject: fealnx build problems with latest linux kernels
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I encountered a problem when trying to build the fealnx driver
with the latest linux kernels 2.4.10-2.4.13, vanilla as well as
2.4.13-ac2 and 2.4.13-ac5. The problem is present only when
the kernel is configured without support for hot-pluggable
devices.

The problem seems to be a swapped __devinitdata and =. 
The following patch fixes the problem.

\Gandalf

--- fealnx.c    Wed Oct 31 11:03:01 2001
+++ fealnx.c-orig       Wed Oct 31 11:01:07 2001
@@ -1815,7 +1815,7 @@
        return 0;
 }

-static struct pci_device_id fealnx_pci_tbl[] __devinitdata = {
+static struct pci_device_id fealnx_pci_tbl[] = __devinitdata {
        {0x1516, 0x0800, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
        {0x1516, 0x0803, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
        {0x1516, 0x0891, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
