Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262738AbULQEFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262738AbULQEFu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 23:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262737AbULQEFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 23:05:50 -0500
Received: from mail.renesas.com ([202.234.163.13]:8952 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262738AbULQEFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 23:05:40 -0500
Date: Fri, 17 Dec 2004 13:05:07 +0900 (JST)
Message-Id: <20041217.130507.241920387.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.10-rc3-mm1] m32r: PAGE_NONE support (0/3)
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset updates page flags for m32r.

* Support PAGE_NONE
  - Support PAGE_NONE attribute for memory protection.
  - Add _PAGE_PROTNONE bit to pte.
    On the m32r, the _PAGE_PROTNONE bit is a software bit.

* Remove PAGE_USER
  - Remove _PAGE_USER bit from pte, because the m32r doesn't support it 
    by hardware. (cf. mips)
  
In my understanding, the _PAGE_PRONONE bit is used to show explicitly that
no physical memory is mapped and the mapped page is not accessible, right?
If a page marked with PAGE_NONE is accessed, an access error should
be happened.

Tested on M3T-M32700UT and M3A-ZA36 eva boards, and it looks working.
Please apply.

Thank you.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

[PATCH 2.6.10-rc3-mm1] m32r: Support PAGE_NONE (1/3)
- Support PAGE_NONE attribute for memory protection.
- Add _PAGE_PROTNONE bit to pte (software bit).

[PATCH 2.6.10-rc3-mm1] m32r: Remove PAGE_USER (2/3)
- Remove _PAGE_USER bit from pte.
- The m32r doesn't support _PAGE_USER bit by hardware. 

[PATCH 2.6.10-rc3-mm1] m32r: Clean up include/asm-m32r/pgtable-2level.h (3/3)
- Add #ifdef __KERNEL__
- Change __inline__ to inline for __KERNEL__ portion.
- Remove RCS ID string.

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/

