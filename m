Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262508AbULDAVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262508AbULDAVq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 19:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262511AbULDAVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 19:21:46 -0500
Received: from ns1.q-leap.de ([153.94.51.193]:55964 "EHLO mail.q-leap.de")
	by vger.kernel.org with ESMTP id S262508AbULDAUy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 19:20:54 -0500
From: Roland Fehrenbacher <rf@q-leap.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16817.739.384632.576205@gargle.gargle.HOWL>
Date: Sat, 4 Dec 2004 01:20:51 +0100
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Subject: Re: Trouble with swiotlb
In-Reply-To: <41B0DC46.7050906@osdl.org>
References: <16816.30598.368287.762457@gargle.gargle.HOWL>
	<41B0DC46.7050906@osdl.org>
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: rf@q-leap.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Randy" == Randy Dunlap <Randy.Dunlap> writes:

    Randy> Roland Fehrenbacher wrote:
    >> Hi,
    >> 
    >> when building 2.4.28 or 2.4.27 on x86_64 with IOMMU and SWIOTLB
    >> support enabled I get unresolved symbol for 3 modules:
    >> 
    >> depmod: *** Unresolved symbols in
    >> /lib/modules/2.4.28/kernel/drivers/net/e1000/e1000.o depmod:
    >> *** Unresolved symbols in
    >> /lib/modules/2.4.28/kernel/drivers/usb/host/uhci.o depmod: ***
    >> Unresolved symbols in
    >> /lib/modules/2.4.28/kernel/drivers/usb/host/usb-uhci.o
    >> 
    >> When modprobing any of the modules I get: unresolved symbol
    >> swiotlb
    >> 
    >> The kernel boots fine on Opterons and EM64T Xeons otherwise.
    >> 
    >> Any ideas.

    Randy> Looks like it just needs 'swiotlb' exported (as in 2.6.x).
    Randy> Can you test the attached patch?  I don't have 2.4.x
    Randy> booting on x8-64 yet.

Hi Randy,

thanks for the fast reply. Your patch solved the problem. I can boot
Opterons and EM64T Xeons now without any problems.

Roland
 
linux-2428-work
<description>

Signed-off-by: Your Name <email@domain.tld>

diffstat:=
 arch/x86_64/kernel/setup.c |    1 +
 1 files changed, 1 insertion(+)

diff -Naurp ./arch/x86_64/kernel/setup.c~swiotlb ./arch/x86_64/kernel/setup.c
--- ./arch/x86_64/kernel/setup.c~swiotlb	2004-08-07 16:26:04.000000000 -0700
+++ ./arch/x86_64/kernel/setup.c	2004-12-03 11:54:07.000000000 -0800
@@ -52,6 +52,7 @@ int acpi_disabled;
 EXPORT_SYMBOL(acpi_disabled);
 
 int swiotlb;
+EXPORT_SYMBOL(swiotlb);
 
 extern	int phys_proc_id[NR_CPUS];
 

