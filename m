Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261552AbTCGMdE>; Fri, 7 Mar 2003 07:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261553AbTCGMdE>; Fri, 7 Mar 2003 07:33:04 -0500
Received: from 237.oncolt.com ([213.86.99.237]:48857 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S261552AbTCGMdD>; Fri, 7 Mar 2003 07:33:03 -0500
Subject: Re: 2.5.51 CRC32 undefined
From: David Woodhouse <dwmw2@infradead.org>
To: Arun Prasad <arun@netlab.hcltech.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <3E674B7C.E442D16@netlab.hcltech.com>
References: <3E674B7C.E442D16@netlab.hcltech.com>
Content-Type: text/plain
Organization: 
Message-Id: <1047040816.32200.59.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4.dwmw2) 
Date: 07 Mar 2003 12:40:17 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-06 at 13:22, Arun Prasad wrote:

>     CONFIG_CRC32=y
>     CONFIG_PCNET32=m

	<...>

>     pcnet32: Unknown symbol crc32_le

The problem is that crc32.o isn't actually linked into the kernel,
because no symbols from it are referenced when the linker is asked to
pull in lib/lib.a

Set CONFIG_CRC32=m. We probably shouldn't allow it to be set to 'Y' in
the first place., given the above.

===== lib/Kconfig 1.2 vs edited =====
--- 1.2/lib/Kconfig	Fri Nov  1 12:07:52 2002
+++ edited/lib/Kconfig	Fri Mar  7 12:37:54 2003
@@ -6,6 +6,7 @@
 
 config CRC32
 	tristate "CRC32 functions"
+	depends on m
 	help
 	  This option is provided for the case where no in-kernel-tree
 	  modules require CRC32 functions, but a module built outside the




-- 
dwmw2

