Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbVJ2Eum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbVJ2Eum (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 00:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbVJ2Eum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 00:50:42 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:12157 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751143AbVJ2Eul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 00:50:41 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] toshiba_ohci1394_dmi_table should be __devinitdata, not
 __devinit
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 28 Oct 2005 21:50:35 -0700
Message-ID: <52fyqlorj8.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 29 Oct 2005 04:50:36.0953 (UTC) FILETIME=[4DB52090:01C5DC44]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't really understand why gcc gives the error it does, but without
this patch, when building with CONFIG_HOTPLUG=n, I get errors like:

      CC      arch/x86_64/pci/../../i386/pci/fixup.o
    arch/x86_64/pci/../../i386/pci/fixup.c: In function `pci_fixup_i450nx':
    arch/x86_64/pci/../../i386/pci/fixup.c:13: error: pci_fixup_i450nx causes a section type conflict

The change is obviously correct: an array should be declared
__devinitdata rather that __devinit.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

diff --git a/arch/i386/pci/fixup.c b/arch/i386/pci/fixup.c
--- a/arch/i386/pci/fixup.c
+++ b/arch/i386/pci/fixup.c
@@ -398,7 +398,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI
  */
 static u16 toshiba_line_size;
 
-static struct dmi_system_id __devinit toshiba_ohci1394_dmi_table[] = {
+static struct dmi_system_id __devinitdata toshiba_ohci1394_dmi_table[] = {
 	{
 		.ident = "Toshiba PS5 based laptop",
 		.matches = {
