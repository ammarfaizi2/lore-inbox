Return-Path: <linux-kernel-owner+w=401wt.eu-S1161293AbXAMGGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161293AbXAMGGA (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 01:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161294AbXAMGGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 01:06:00 -0500
Received: from an-out-0708.google.com ([209.85.132.245]:11178 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161293AbXAMGGA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 01:06:00 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:x-x-sender:to:subject:message-id:mime-version:content-type;
        b=Fz+hYjzs+Ocx4LXJrGVZKbYeDAmym3s+5dwXpzwUXVc3I6luSxmYjbeEtdT5luXENaFj1KRUqzkt/Sghu/1YKV+cPOtAdU0W0qzPIPfLOUgWOkcUu5hB+WeueKviXn1tyRk2JUxr4uxZpvnkqNsKvg/B/jp31b9h7MmAmGHj2C8=
Date: Sat, 13 Jan 2007 14:05:51 +0800 (SGT)
From: Jeff Chua <jeff.chua.linux@gmail.com>
X-X-Sender: root@boston.corp.fedex.com
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: Linux v2.6.20-rc5
Message-ID: <Pine.LNX.4.64.0701131404520.22948@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



From: Jeff Chua <jchua@fedex.com>

>   CC [M]  drivers/kvm/vmx.o
> {standard input}: Assembler messages:
> {standard input}:3257: Error: bad register name `%sil'
> make[2]: *** [drivers/kvm/vmx.o] Error 1
> make[1]: *** [drivers/kvm] Error 2
> make: *** [drivers] Error 2


I'm not using the kernel profiler, so here's a patch to make it work without 
CONFIG_PROFILING.


Thanks,
Jeff


--- linux/drivers/kvm/vmx.c.org	2007-01-13 12:57:28 +0800
+++ linux/drivers/kvm/vmx.c	2007-01-13 14:01:17 +0800
@@ -21,7 +21,11 @@
  #include <linux/module.h>
  #include <linux/mm.h>
  #include <linux/highmem.h>
+
+#ifdef CONFIG_PROFILING
  #include <linux/profile.h>
+#endif
+
  #include <asm/io.h>
  #include <asm/desc.h>

@@ -1861,11 +1865,13 @@
  	asm ("mov %0, %%ds; mov %0, %%es" : : "r"(__USER_DS));
  #endif

+#ifdef CONFIG_PROFILING
  	/*
  	 * Profile KVM exit RIPs:
  	 */
  	if (unlikely(prof_on == KVM_PROFILING))
  		profile_hit(KVM_PROFILING, (void *)vmcs_readl(GUEST_RIP));
+#endif

  	kvm_run->exit_type = 0;
  	if (fail) {
