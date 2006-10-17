Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423222AbWJQLL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423222AbWJQLL3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 07:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423228AbWJQLL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 07:11:29 -0400
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:29650 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1423222AbWJQLL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 07:11:28 -0400
Message-ID: <4534BA77.6040400@cn.ibm.com>
Date: Tue, 17 Oct 2006 19:11:51 +0800
From: Yi CDL Yang <yyangcdl@cn.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, binutils@sourceware.org, bug-binutils@gnu.org
Subject: 2.6.19-rc2 has ld error for ppc64
X-MIMETrack: Itemize by SMTP Server on D23M0037/23/M/IBM(Release 7.0HF124 | January 12, 2006) at
 10/17/2006 19:14:30,
	Serialize by Router on D23M0037/23/M/IBM(Release 7.0HF124 | January 12, 2006) at
 10/17/2006 19:14:31,
	Serialize complete at 10/17/2006 19:14:31
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=GB2312
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On building 2.6.19-rc2 on ppc64, ld always reports such an error:

".text exceeds stub group size"

...

this patch can make ld happy without any complain.


--- binutils-2.17/bfd/elf64-ppc.c.orig 2006-10-16 23:58:53.000000000 -0400
+++ binutils-2.17/bfd/elf64-ppc.c 2006-10-16 18:43:57.000000000 -0400
@@ -4538,6 +4538,7 @@ ppc64_elf_check_relocs (bfd *abfd, struc
case R_PPC64_REL14_BRTAKEN:
case R_PPC64_REL14_BRNTAKEN:
{
+ htab->has_14bit_branch = 0;
asection *dest = NULL;

/* Heuristic: If jumping outside our section, chances are


