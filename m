Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbTIKXRk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 19:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbTIKXRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 19:17:40 -0400
Received: from email-out2.iomega.com ([147.178.1.83]:12795 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S261592AbTIKXRi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 19:17:38 -0400
Subject: [PATCH] 2.4.22 precedes 0.9.9 in module-init-tools of course
From: Pat LaVarre <p.lavarre@ieee.org>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1063312953.3347.24.camel@patehci2>
References: <Pine.LNX.4.44L0.0309111551410.2667-100000@ida.rowland.org>
	 <1063312953.3347.24.camel@patehci2>
Content-Type: text/plain
Organization: 
Message-Id: <1063322319.3616.26.camel@patehci2>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Sep 2003 17:18:39 -0600
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Sep 2003 23:17:37.0773 (UTC) FILETIME=[E3CEB1D0:01C378BA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think newbies still need a more emphatic hint, such as:

--- linux-2.6.0-test5/Documentation/Changes	2003-09-08 13:50:28.000000000 -0600
+++ linux/Documentation/Changes	2003-09-11 16:09:12.155352016 -0600
@@ -42,6 +42,9 @@
 encountered a bug!  If you're unsure what version you're currently
 running, the suggested command should tell you.
 
+Except also upgrade your module-init-tools if your depmod -V gives
+you a "depmod version" rather than a "module-init-tools" version.
+
 Again, keep in mind that this list assumes you are already
 functionally running a Linux 2.4 kernel.  Also, not all tools are
 necessary on all systems; obviously, if you don't have any PCMCIA (PC

Sure, 2.6.0-test5 helps some with:

$ cp /etc/redhat-release /dev/null
$ time sudo make install modules_install
...
Warning: you may need to install module-init-tools
See http://www.codemonkey.org.uk/post-halloween-2.5.txt
...

But I believe that hint is insufficient, because I know back when I was
mystified, that url was unreachable.

I admit Google did eventually direct me to the seemingly more available
alternate:
http://www.kernel.org/pub/linux/kernel/people/davej/misc/post-halloween-2.5.txt

Pat LaVarre

P.S. A fresh, but more complete, quote of what once mystified me is:

$ uname -r
2.4.20-6smp
$ /sbin/depmod -V
depmod version 2.4.22
depmod: Can't open /lib/modules/2.4.20-6smp/modules.dep for writing
$ sudo /sbin/depmod -V
depmod version 2.4.22
$
...

$ uname -r
2.6.0-test5
$ sudo /sbin/modprobe sr_mod
modprobe: QM_MODULES: Function not implemented

modprobe: QM_MODULES: Function not implemented

modprobe: Can't locate module sr_mod
$

Since being demystified, I've adopted a procedure I discovered only by
combining in order from module-init-tools all of man depmod, May
./README, Feb ./FAQ, Nov ./INSTALL:

cp /sbin/lsmod /dev/null
./configure --prefix=/
make
./depmod -V
sudo make moveold
sudo make install
sudo ./generate-modprobe.conf /etc/modprobe.conf
sudo vi /etc/rc.d/rc.sysinit +/USEMODULES=

I see I should also submit a patch elsewhere for the module-init-tools
README and FAQ.  I believe the INSTALL is incorrect by design (by being
generic).


