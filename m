Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754637AbWKMQyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754637AbWKMQyr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 11:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755219AbWKMQyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 11:54:17 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:8874 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1755215AbWKMQyH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 11:54:07 -0500
Date: Mon, 13 Nov 2006 11:26:52 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com
Subject: [RFC] [PATCH 1/16] x86_64: Align data segment to page size boundary
Message-ID: <20061113162652.GB17429@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061113162135.GA17429@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061113162135.GA17429@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


o Explicitly align data segment to PAGE_SIZE boundary otherwise depending on
  config options and tool chain it might be placed on a non PAGE_SIZE aligned
  boundary and vmlinux loaders like kexec fail when they encounter a 
  PT_LOAD type segment which is not aligned to PAGE_SIZE boundary.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/x86_64/kernel/vmlinux.lds.S |    1 +
 1 file changed, 1 insertion(+)

diff -puN arch/x86_64/kernel/vmlinux.lds.S~x86_64-align-data-segment-to-4K-boundary arch/x86_64/kernel/vmlinux.lds.S
--- linux-2.6.19-rc5-reloc/arch/x86_64/kernel/vmlinux.lds.S~x86_64-align-data-segment-to-4K-boundary	2006-11-09 22:25:15.000000000 -0500
+++ linux-2.6.19-rc5-reloc-root/arch/x86_64/kernel/vmlinux.lds.S	2006-11-09 22:28:24.000000000 -0500
@@ -60,6 +60,7 @@ SECTIONS
   }
 #endif
 
+  . = ALIGN(PAGE_SIZE);        /* Align data segment to page size boundary */
 				/* Data */
   .data : AT(ADDR(.data) - LOAD_OFFSET) {
 	*(.data)
_
