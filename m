Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261989AbUEFO2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbUEFO2g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 10:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbUEFO2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 10:28:36 -0400
Received: from users.linvision.com ([62.58.92.114]:37523 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S261989AbUEFO22 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 10:28:28 -0400
Date: Thu, 6 May 2004 16:28:27 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: "Srinivas G." <srinivasg@esntechnologies.co.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Small problem, Can anybody help me?
Message-ID: <20040506142827.GI15056@harddisk-recovery.com>
References: <1118873EE1755348B4812EA29C55A97222F512@esnmail.esntechnologies.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118873EE1755348B4812EA29C55A97222F512@esnmail.esntechnologies.co.in>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2004 at 07:31:56PM +0530, Srinivas G. wrote:
> I have written a small hello.c program in the Linux Kernel version
> 2.4.18-3.

Ancient kernel with lots of known bugs and security issues. You'd
rather upgrade.

> The code is as follows.
> -----------------------
> 
> 
> define MODULE

The idea is to put that definition on the gcc command line.

> #include <linux/module.h>
> #include <linux/init.h>

You're missing #include <linux/kernel.h> 

> MODULE_LICENSE("GPL");
> 
> int Test_init(void)
> {
> 	printk("<1> Hello World\n");

Use KERN_ALERT instead of "<1>". We have #defines for a reason: if we
change the definition tomorrow, your source will still work. So use:

  printk(KERN_ALERT "Hello, world!\n");

> 	return 0;
> }
> 
> void Test_cleanup(void)
> {
> 	printk("<1> Good bye\n");
> }
> 
> module_init(Test_init);
> module_exit(Test_cleanup);
> 
> 
> I compiled it under same kernel version that is 2.4.18-3. It was showing
> the following errors.
> 
> In file included from hello.c:2:
> /usr/include/linux/module.h:60: parse error before `atomic_t'
  ^^^^^^^^^^^^
You're compiling against libc headers instead of kernel headers. See:

  http://www.kernelnewbies.org/faq/index.php3#headers

The way to compile a module on linux 2.4 is:

  gcc -O2 -Wall -I/path/to/kernel/include/directory -D__KERNEL__ -DMODULE -c hello.c


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
