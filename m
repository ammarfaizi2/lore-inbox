Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266721AbUJBPbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266721AbUJBPbg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 11:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266854AbUJBPbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 11:31:36 -0400
Received: from cantor.suse.de ([195.135.220.2]:24016 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266721AbUJBPbX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 11:31:23 -0400
Date: Sat, 2 Oct 2004 17:30:53 +0200
From: Olaf Hering <olh@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  allow CONFIG_NET=n on ppc64
Message-ID: <20041002153053.GA2643@suse.de>
References: <20040929200158.GA16366@suse.de> <20040929201524.GA14615@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040929201524.GA14615@wotan.suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Sep 29, Andi Kleen wrote:

> On Wed, Sep 29, 2004 at 10:01:58PM +0200, Olaf Hering wrote:
> > 
> > The attached minimal config does not compile on ppc64.
> > I was able to boot the resulting binary with this patch.

> Right fix is to declare compat_sys_socketcall as as cond_syscall() 
> in sys.c

ok.

Signed-off-by: Olaf Hering <olh@suse.de>

diff -purNX /suse/olh/kernel/kernel_exclude.txt linux-2.6.9-rc3-bk2/include/net/sock.h linux-2.6.9-rc3-bk2.nonet/include/net/sock.h
--- linux-2.6.9-rc3-bk2/include/net/sock.h	2004-09-30 05:05:21.000000000 +0200
+++ linux-2.6.9-rc3-bk2.nonet/include/net/sock.h	2004-10-02 17:24:23.666152810 +0200
@@ -1336,6 +1336,13 @@ static inline void sock_valbool_flag(str
 extern __u32 sysctl_wmem_max;
 extern __u32 sysctl_rmem_max;
 
+#ifdef CONFIG_NET
 int siocdevprivate_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg);
+#else
+static inline int siocdevprivate_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
+{
+	return -ENODEV;
+}
+#endif
 
 #endif	/* _SOCK_H */
diff -purNX /suse/olh/kernel/kernel_exclude.txt linux-2.6.9-rc3-bk2/kernel/sys.c linux-2.6.9-rc3-bk2.nonet/kernel/sys.c
--- linux-2.6.9-rc3-bk2/kernel/sys.c	2004-09-30 05:03:55.000000000 +0200
+++ linux-2.6.9-rc3-bk2.nonet/kernel/sys.c	2004-10-02 17:05:49.589116448 +0200
@@ -282,6 +282,7 @@ cond_syscall(compat_set_mempolicy)
 cond_syscall(sys_pciconfig_read)
 cond_syscall(sys_pciconfig_write)
 cond_syscall(sys_pciconfig_iobase)
+cond_syscall(compat_sys_socketcall)
 
 static int set_one_prio(struct task_struct *p, int niceval, int error)
 {

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
