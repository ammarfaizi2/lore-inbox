Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbWCYE2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbWCYE2g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 23:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbWCYE2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 23:28:06 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:44220
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750839AbWCYE10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 23:27:26 -0500
Date: Fri, 24 Mar 2006 20:27:01 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 08/20] get_cpu_sysdev() signedness fix
Message-ID: <20060325042701.GI21260@kroah.com>
References: <20060325041355.180237000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="driver-0021-get_cpu_sysdev-signedness-fix.patch"
In-Reply-To: <20060325042556.GA21260@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
Doing (int < NR_CPUS) doesn't dtrt if it's negative..

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 drivers/base/cpu.c  |    2 +-
 include/linux/cpu.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

a29d642a4aa99c5234314ab2523281139226c231
--- linux-2.6.16.orig/drivers/base/cpu.c
+++ linux-2.6.16/drivers/base/cpu.c
@@ -141,7 +141,7 @@ int __devinit register_cpu(struct cpu *c
 	return error;
 }
 
-struct sys_device *get_cpu_sysdev(int cpu)
+struct sys_device *get_cpu_sysdev(unsigned cpu)
 {
 	if (cpu < NR_CPUS)
 		return cpu_sys_devices[cpu];
--- linux-2.6.16.orig/include/linux/cpu.h
+++ linux-2.6.16/include/linux/cpu.h
@@ -32,7 +32,7 @@ struct cpu {
 };
 
 extern int register_cpu(struct cpu *, int, struct node *);
-extern struct sys_device *get_cpu_sysdev(int cpu);
+extern struct sys_device *get_cpu_sysdev(unsigned cpu);
 #ifdef CONFIG_HOTPLUG_CPU
 extern void unregister_cpu(struct cpu *, struct node *);
 #endif

--
