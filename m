Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269129AbUJKQJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269129AbUJKQJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 12:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269150AbUJKPyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 11:54:07 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:64168 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S269048AbUJKPv7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 11:51:59 -0400
Subject: 2.6.9-rc4-mm1 HPET compile problems on AMD64
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-i2O5+SHrvLSBLkjV7v1Z"
Organization: 
Message-Id: <1097509362.12861.334.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Oct 2004 08:42:42 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-i2O5+SHrvLSBLkjV7v1Z
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Andrew,

I get following error while linking kernel on 2.6.9-rc4-mm1.
x86_64/kernel/time.c seems to have a dependency on char/hpet.c
driver. Its forcing me to use CONFIG_HPET. 

 LD      .tmp_vmlinux1
arch/x86_64/kernel/built-in.o(.init.text+0x2071): In function
`late_hpet_init':
arch/x86_64/kernel/entry.S:259: undefined reference to `hpet_alloc'
make: *** [.tmp_vmlinux1] Error 1

I used following fix to compile. I have no idea, if its right
or not.

Thanks,
Badari



--=-i2O5+SHrvLSBLkjV7v1Z
Content-Disposition: attachment; filename=hpet_alloc_fix.patch
Content-Type: text/plain; name=hpet_alloc_fix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux.org/arch/x86_64/kernel/time.c	2004-10-11 09:17:15.613107488 -0700
+++ linux/arch/x86_64/kernel/time.c	2004-10-11 09:14:05.983935504 -0700
@@ -727,6 +727,7 @@ static unsigned int __init pit_calibrate
 	return (end - start) / 50;
 }
 
+#ifdef	CONFIG_HPET
 static __init int late_hpet_init(void)
 {
 	struct hpet_data	hd;
@@ -773,6 +774,7 @@ static __init int late_hpet_init(void)
 	return 0;
 }
 fs_initcall(late_hpet_init);
+#endif
 
 static int hpet_init(void)
 {

--=-i2O5+SHrvLSBLkjV7v1Z--

