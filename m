Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293155AbSB1TQb>; Thu, 28 Feb 2002 14:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293689AbSB1TPe>; Thu, 28 Feb 2002 14:15:34 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:33215 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S293684AbSB1TOn>; Thu, 28 Feb 2002 14:14:43 -0500
Message-Id: <200202281827.LAA26782@tstac.esa.lanl.gov>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] 2.5.5-dj2, modify arch/i386/Config.help for highpte options.
Date: Thu, 28 Feb 2002 12:12:51 -0700
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies the help text for the CONFIG_NOHIGHMEM option in
arch/i386/Config.help to explain the two new options; 
CONFIG_HIGHMEM4G_HIGHPTE and CONFIG_HIGHMEM64G_HIGHPTE.

Since this is a choice selection, the help text for the first option,
CONFIG_NOHIGHMEM is the only one which is visible using the current
configurators.

Here is a snippet from arch/i386/config.in both 2.5.5-dj2 and 2.5.6-pre1:

choice 'High Memory Support' \
        "off           CONFIG_NOHIGHMEM \
         4GB           CONFIG_HIGHMEM4G \
         4GB-highpte   CONFIG_HIGHMEM4G_HIGHPTE \
         64GB          CONFIG_HIGHMEM64G \
         64GB-highpte  CONFIG_HIGHMEM64G_HIGHPTE" off

If the notes for the highpte options are incorrect, feel free to provide 
a better explanation.

Steven

--- linux-2.5.5-dj2/arch/i386/Config.help.orig  Thu Feb 28 10:58:01 2002
+++ linux-2.5.5-dj2/arch/i386/Config.help       Thu Feb 28 11:52:43 2002
@@ -111,13 +111,21 @@
   possible.

   If the machine has between 1 and 4 Gigabytes physical RAM, then
-  answer "4GB" here.
+  answer "4GB" or "4GB-highpte" here.  The "4GB-highpte" option
+  will put user-space page table entries into high memory.
+
+  If the machine has more than 4 Gigabytes physical RAM, then
+  answer "64GB" or "64GB-highpte" here.  The "64GB-highpte" option
+  will put user-space page table entries into high memory.
+
+  Selecting either "64GB" or "64GB-highpte" turns Intel PAE
+  (Physical Address Extension) mode on.

-  If more than 4 Gigabytes is used then answer "64GB" here. This
-  selection turns Intel PAE (Physical Address Extension) mode on.
   PAE implements 3-level paging on IA32 processors. PAE is fully
   supported by Linux, PAE mode is implemented on all recent Intel
-  processors (Pentium Pro and better). NOTE: If you say "64GB" here,
+  processors (Pentium Pro and better).
+
+  NOTE: If you say "64GB" or "64GB-highpte" here,
   then the kernel will not boot on CPUs that don't support PAE!

   The actual amount of total physical memory will either be



