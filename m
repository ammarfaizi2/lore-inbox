Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964994AbWJWTst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbWJWTst (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 15:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbWJWTsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 15:48:31 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:4509 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S965090AbWJWTsQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 15:48:16 -0400
Date: Mon, 23 Oct 2006 15:30:57 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, maneesh@in.ibm.com
Subject: [PATCH 3/11] i386: Force data segment to be 4K aligned
Message-ID: <20061023193057.GD13263@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061023192456.GA13263@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061023192456.GA13263@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o Currently there is no specific alignment restriction in linker script
  and in some cases it can be placed non 4K aligned addresses. This fails
  kexec which checks that segment to be loaded is page aligned.

o I guess, it does not harm data segment to be 4K aligned.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/i386/kernel/vmlinux.lds.S |    1 +
 1 file changed, 1 insertion(+)

diff -puN arch/i386/kernel/vmlinux.lds.S~i386-force-data-section-to-4K-aligned arch/i386/kernel/vmlinux.lds.S
--- linux-2.6.19-rc2-git7-reloc/arch/i386/kernel/vmlinux.lds.S~i386-force-data-section-to-4K-aligned	2006-10-23 13:15:21.000000000 -0400
+++ linux-2.6.19-rc2-git7-reloc-root/arch/i386/kernel/vmlinux.lds.S	2006-10-23 15:08:55.000000000 -0400
@@ -52,6 +52,7 @@ SECTIONS
   }
 
   /* writeable */
+  . = ALIGN(4096);
   .data : AT(ADDR(.data) - LOAD_OFFSET) {	/* Data */
 	*(.data)
 	CONSTRUCTORS
_
