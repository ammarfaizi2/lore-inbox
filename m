Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313325AbSDOWiW>; Mon, 15 Apr 2002 18:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313326AbSDOWiV>; Mon, 15 Apr 2002 18:38:21 -0400
Received: from kknd.mweb.co.za ([196.2.45.79]:31665 "EHLO kknd.mweb.co.za")
	by vger.kernel.org with ESMTP id <S313325AbSDOWiV>;
	Mon, 15 Apr 2002 18:38:21 -0400
Subject: [Patch] Compilation error on 2.5.8
From: Bongani <bonganilinux@mweb.co.za>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 16 Apr 2002 00:53:08 +0200
Message-Id: <1018911190.2688.67.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following error when I try to compile 2.5.8
init/main.o: In function `start_kernel':
init/main.o(.text.init+0x5e2): undefined reference to
`setup_per_cpu_areas'

Looking at the code it looks like someone got confused ;)
around the ifdefs.I'm  under the assumption that setup_per_cpu_areas()
does nothing on a uniprocessor. The patch compile fine on 
my PC. 


--- init/main.c Tue Apr 16 00:33:04 2002
+++ init/main.c_new     Tue Apr 16 00:32:51 2002
@@ -344,7 +344,9 @@
        lock_kernel();
        printk(linux_banner);
        setup_arch(&command_line);
+#ifdef CONFIG_SMP
        setup_per_cpu_areas();
+#endif
        printk("Kernel command line: %s\n", saved_command_line);
        parse_options(command_line);
        trap_init();



Cheers
	-Bongani

