Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753554AbWKRAFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554AbWKRAFz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 19:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753553AbWKRAFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 19:05:55 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:4257 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1753513AbWKRAFy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 19:05:54 -0500
Date: Fri, 17 Nov 2006 17:52:37 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, pavel@suse.cz, rjw@sisk.pl
Subject: [PATCH 14/20] x86_64: Modify discover_ebda to use virtual address
Message-ID: <20061117225237.GO15449@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061117223432.GA15449@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117223432.GA15449@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/x86_64/kernel/setup.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/x86_64/kernel/setup.c~x86_64-Modify-discover_ebda-to-use-virtual-addresses arch/x86_64/kernel/setup.c
--- linux-2.6.19-rc6-reloc/arch/x86_64/kernel/setup.c~x86_64-Modify-discover_ebda-to-use-virtual-addresses	2006-11-17 00:11:14.000000000 -0500
+++ linux-2.6.19-rc6-reloc-root/arch/x86_64/kernel/setup.c	2006-11-17 00:11:14.000000000 -0500
@@ -327,10 +327,10 @@ static void discover_ebda(void)
 	 * there is a real-mode segmented pointer pointing to the 
 	 * 4K EBDA area at 0x40E
 	 */
-	ebda_addr = *(unsigned short *)EBDA_ADDR_POINTER;
+	ebda_addr = *(unsigned short *)__va(EBDA_ADDR_POINTER);
 	ebda_addr <<= 4;
 
-	ebda_size = *(unsigned short *)(unsigned long)ebda_addr;
+	ebda_size = *(unsigned short *)__va(ebda_addr);
 
 	/* Round EBDA up to pages */
 	if (ebda_size == 0)
_
