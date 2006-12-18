Return-Path: <linux-kernel-owner+w=401wt.eu-S1753924AbWLRMd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753924AbWLRMd1 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 07:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753928AbWLRMd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 07:33:27 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:34600 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753927AbWLRMd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 07:33:26 -0500
Message-ID: <458683CF.8030606@openvz.org>
Date: Mon, 18 Dec 2006 15:04:31 +0300
From: Kirill Korotaev <dev@openvz.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: tony.luck@intel.com, linux-ia64@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Alexey Kuznetsov <alexey@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org
Subject: [PATCH] IA64: alignment bug in ldscript
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[IA64] bug in ldscript (mainstream)

Occasionally, in mainstream number of fsys entries is even.
In OpenVZ it is odd and we get misaligned kernel image,
which does not boot.

Signed-Off-By: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Signed-Off-By: Kirill Korotaev <dev@openvz.org>

diff -urp ../linux-2.6.18-vz/arch/ia64/kernel/vmlinux.lds.S linux-2.6.18-vz/arch/ia64/kernel/vmlinux.lds.S
--- ../linux-2.6.18-vz/arch/ia64/kernel/vmlinux.lds.S	2006-12-08 13:34:19.000000000 +0300
+++ linux-2.6.18-vz/arch/ia64/kernel/vmlinux.lds.S	2006-12-13 02:51:03.000000000 +0300
@@ -163,6 +163,7 @@ SECTIONS
 	}
 #endif
 
+  . = ALIGN(8);
    __con_initcall_start = .;
   .con_initcall.init : AT(ADDR(.con_initcall.init) - LOAD_OFFSET)
 	{ *(.con_initcall.init) }

