Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267704AbUBTAal (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 19:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267681AbUBTA3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 19:29:51 -0500
Received: from hera.cwi.nl ([192.16.191.8]:38070 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S267675AbUBTAVJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 19:21:09 -0500
From: Andries.Brouwer@cwi.nl
Date: Fri, 20 Feb 2004 01:21:01 +0100 (MET)
Message-Id: <UTC200402200021.i1K0L1525525.aeb@smtp.cwi.nl>
To: hpa@transmeta.com, linux-kernel@vger.kernel.org
Subject: kernel too big
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.5.61 hpa changed

-      /* 0x28000*16 = 2.5 MB, conservative estimate for the current maximum */
-      if (sys_size > (is_big_kernel ? 0x28000 : DEF_SYSSIZE))
+      /* 0x40000*16 = 4.0 MB, reasonable estimate for the current maximum */
+      if (sys_size > (is_big_kernel ? 0x40000 : DEF_SYSSIZE))
              die("System is too big. ...");

(with comment "bootsect removal").

Today I find for a 2.6.3 machine that it boots with 2994 kB and
crashes at boot time with 3005 kB.

Thus, it looks like this "reasonable estimate" is too optimistic.

If I understand correctly, the real requirement is that
_end must stay below 8MB (unless the initial page tables
in head.S are made larger). A crash occurs with _end = c07fcf8c.

Maybe these "conservative" or "reasonable" estimates should be
replaced by a text on _end?

Andries
