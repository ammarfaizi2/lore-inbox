Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932935AbWFZTPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932935AbWFZTPj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 15:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932936AbWFZTPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 15:15:38 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:61061 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932935AbWFZTPh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 15:15:37 -0400
Message-ID: <44A031FA.7050502@us.ibm.com>
Date: Mon, 26 Jun 2006 12:14:02 -0700
From: Haren Myneni <haren@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vgoyal@in.ibm.com
CC: Troy Benjegerdes <hozer@hozed.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       ellerman@au1.ibm.com, Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc: build fix for ppc32 with CONFIG_KEXEC
References: <20060626063128.GA3359@narn.hozed.org> <20060626135801.GC8985@in.ibm.com>
In-Reply-To: <20060626135801.GC8985@in.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------050704020902080309020608"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050704020902080309020608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Vivek Goyal wrote:

>On Mon, Jun 26, 2006 at 01:31:28AM -0500, Troy Benjegerdes wrote:
>  
>
>>various things like 'reserve_crashkernel' are referenced, but only
>>exist in arch/powerpc/kernel/machine_kexec_64.c.
>>
>>    
>>
>
>I think for ppc32 the framework is present for kexec/kdump but nobody 
>is actively testing/maintaining it as of today.
>  
>
At present, even though kexec support is included for PPC32, I believe, 
it has been actively tested/maintained only on gamecube.

Michael, if you are OK with this patch, please send it to upstream.
Thanks
Haren

arch/powerpc/kernel/built-in.o(.init.text+0x1c98): In function 
`early_init_devtree':
: undefined reference to `reserve_crashkernel'
arch/powerpc/kernel/built-in.o(.init.text+0x1d90): In function 
`early_init_devtree':
: undefined reference to `overlaps_crashkernel'
 This patch will fix the above build errors on ppc32 with CONFIG_KEXEC.  
Both reserve_crashkernel() and overlaps_crashkernel() should be moved to 
machine_kexec.c() after the kdump support is included on ppc32.

Signed-off-by: Haren Myneni <haren@us.ibm.com>





>Thanks
>Vivek
>_______________________________________________
>fastboot mailing list
>fastboot@lists.osdl.org
>https://lists.osdl.org/mailman/listinfo/fastboot
>  
>


--------------050704020902080309020608
Content-Type: text/x-patch;
 name="ppc32-kexec-build-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc32-kexec-build-fix.patch"

--- linux-2.6.17-git10/arch/powerpc/kernel/machine_kexec_32.c.orig	2006-06-26 05:33:51.000000000 -0700
+++ linux-2.6.17-git10/arch/powerpc/kernel/machine_kexec_32.c	2006-06-26 05:47:04.000000000 -0700
@@ -63,3 +63,16 @@ int default_machine_kexec_prepare(struct
 {
 	return 0;
 }
+
+/*
+ * FIXME: Move the following functions to machine_kexec.c after
+ * kdump support is included on ppc32.
+ */
+void __init reserve_crashkernel(void)
+{
+}
+
+int overlaps_crashkernel(unsigned long start, unsigned long size)
+{
+	return 0;
+}

--------------050704020902080309020608--
