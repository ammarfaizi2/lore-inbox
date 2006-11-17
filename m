Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753513AbWKRAF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513AbWKRAF7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 19:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753557AbWKRAF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 19:05:59 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:27042 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1753513AbWKRAF5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 19:05:57 -0500
Date: Fri, 17 Nov 2006 17:36:07 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, pavel@suse.cz, rjw@sisk.pl
Subject: [PATCH 1/20] x86_64: Align data segment to PAGE_SIZE boundary
Message-ID: <20061117223607.GB15449@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061117223432.GA15449@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117223432.GA15449@in.ibm.com>
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
--- linux-2.6.19-rc6-reloc/arch/x86_64/kernel/vmlinux.lds.S~x86_64-align-data-segment-to-4K-boundary	2006-11-17 00:05:06.000000000 -0500
+++ linux-2.6.19-rc6-reloc-root/arch/x86_64/kernel/vmlinux.lds.S	2006-11-17 00:05:06.000000000 -0500
@@ -60,6 +60,7 @@ SECTIONS
   }
 #endif
 
+  . = ALIGN(PAGE_SIZE);        /* Align data segment to page size boundary */
 				/* Data */
   .data : AT(ADDR(.data) - LOAD_OFFSET) {
 	*(.data)
_
