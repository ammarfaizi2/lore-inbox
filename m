Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030359AbWJCRdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030359AbWJCRdq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 13:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030352AbWJCRbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 13:31:44 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:55951 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030364AbWJCRbD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 13:31:03 -0400
Date: Tue, 3 Oct 2006 13:06:28 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, horms@verge.net.au, lace@jankratochvil.net,
       hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com, maneesh@in.ibm.com
Subject: [PATCH 2/12] i386: align data section to 4K boundary
Message-ID: <20061003170628.GB3164@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061003170032.GA30036@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061003170032.GA30036@in.ibm.com>
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
--- linux-2.6.18-git17/arch/i386/kernel/vmlinux.lds.S~i386-force-data-section-to-4K-aligned	2006-10-02 13:17:58.000000000 -0400
+++ linux-2.6.18-git17-root/arch/i386/kernel/vmlinux.lds.S	2006-10-02 14:38:17.000000000 -0400
@@ -52,6 +52,7 @@ SECTIONS
   }
 
   /* writeable */
+  . = ALIGN(4096);
   .data : AT(ADDR(.data) - LOAD_OFFSET) {	/* Data */
 	*(.data)
 	CONSTRUCTORS
_
