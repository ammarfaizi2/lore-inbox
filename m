Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265751AbTF3GEO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 02:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265760AbTF3GEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 02:04:14 -0400
Received: from [213.171.53.133] ([213.171.53.133]:34053 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id S265751AbTF3GEL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 02:04:11 -0400
Date: Mon, 30 Jun 2003 09:20:15 +0400
From: Samium Gromoff <deepfire@ibe.miee.ru>
To: linux-kernel@vger.kernel.org, gcc-bugs@gcc.gnu.org
Subject: [GCC] gcc vs. indentation
Message-Id: <20030630092015.49dd6969.deepfire@ibe.miee.ru>
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Mon__30_Jun_2003_09:20:15_+0400_081fbeb8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Mon__30_Jun_2003_09:20:15_+0400_081fbeb8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

	The story begun when i`ve started to make indentation fixes in the DAC960 driver.
 And in order to ensure i didn`t broke anything i was checking a diff between the
 resulting object files.

	Surprisingly enough i`ve realised soon that indeed some indentation changes
 give gcc a reason to produce different code.

	One of the cases is below, all three of them are in the attached .tar.gz file.
	The code in question is the 2.5.72-bk1 kernel, however there was no changes
 in the related code for some time, so plain .72 should be safe.

	The examples are in the form of pairs of a C diff, and a "objdump -d" output diff.

The C diff:
diff -X scripts/Xrule -urN 25/drivers/block/DAC960.c 25dac/drivers/block/DAC960.c
--- 25/drivers/block/DAC960.c   2003-06-17 01:09:50.000000000 +0400
+++ 25dac/drivers/block/DAC960.c        2003-06-29 22:11:01.000000000 +0400
@@ -272,8 +272,7 @@
   dma_addr_t RequestSenseDMA;
   struct pci_pool *RequestSensePool = NULL;

-  if (Controller->FirmwareType == DAC960_V1_Controller)
-    {
+  if (Controller->FirmwareType == DAC960_V1_Controller) {
       CommandAllocationLength = offsetof(DAC960_Command_T, V1.EndMarker);
       CommandAllocationGroupSize = DAC960_V1_CommandAllocationGroupSize;
       ScatterGatherPool = pci_pool_create("DAC960_V1_ScatterGather",

--- ./origDAC960.o.d    2003-06-29 21:02:55.000000000 +0400
+++ ./newDAC960.o.d     2003-06-29 22:13:46.000000000 +0400
@@ -1,5 +1,5 @@

-origDAC960.o:     file format elf32-i386
+./newDAC960.o:     file format elf32-i386

 Disassembly of section .text:

@@ -5837,7 +5837,7 @@
     52a8:      84 c0                   test   %al,%al
     52aa:      75 14                   jne    52c0 <DAC960_V1_ProcessCompletedCommand+0x80>
     52ac:      0f 0b                   ud2a
-    52ae:      7d 0d                   jge    52bd <DAC960_V1_ProcessCompletedCommand+0x7d>
+    52ae:      7c 0d                   jl     52bd <DAC960_V1_ProcessCompletedCommand+0x7d>
     52b0:      27                      daa
     52b1:      00 00                   add    %al,(%eax)
     52b3:      00 8d b6 00 00 00       add    %cl,0xb6(%ebp)
@@ -5951,7 +5951,7 @@
     5421:      84 c0                   test   %al,%al
     5423:      0f 85 97 fe ff ff       jne    52c0 <DAC960_V1_ProcessCompletedCommand+0x80>
     5429:      0f 0b                   ud2a
-    542b:      8f 0d 27 00 00 00       popl   0x27
+    542b:      8e 0d 27 00 00 00       movl   0x27,%cs
     5431:      e9 8a fe ff ff          jmp    52c0 <DAC960_V1_ProcessCompletedCommand+0x80>
     5436:      89 1c 24                mov    %ebx,(%esp,1)
     5439:      e8 fc ff ff ff          call   543a <DAC960_V1_ProcessCompletedCommand+0x1fa>
@@ -7414,7 +7414,7 @@
     6ba2:      84 c0                   test   %al,%al
     6ba4:      75 0a                   jne    6bb0 <DAC960_V2_ProcessCompletedCommand+0xa0>
     6ba6:      0f 0b                   ud2a
-    6ba8:      bc 11 27 00 00          mov    $0x2711,%esp
+    6ba8:      bb 11 27 00 00          mov    $0x2711,%ebx
     6bad:      00 89 f6 83 bc 24       add    %cl,0x24bc83f6(%ecx)
     6bb3:      84 00                   test   %al,(%eax)
     6bb5:      00 00                   add    %al,(%eax)


Thats it.
The point is i thought and hoped that gcc abstract syntax tree constructor is
indentation invariant, and that is seemingly not true.

regards, Samium Gromoff

--Multipart_Mon__30_Jun_2003_09:20:15_+0400_081fbeb8
Content-Type: application/octet-stream;
 name="gcc-hrmph.tar.gz"
Content-Disposition: attachment;
 filename="gcc-hrmph.tar.gz"
Content-Transfer-Encoding: base64

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
SZIkSZKkfzf9H5LUU6EAUAAA

--Multipart_Mon__30_Jun_2003_09:20:15_+0400_081fbeb8--
