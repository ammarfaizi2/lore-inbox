Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbWJELsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWJELsy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 07:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWJELsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 07:48:54 -0400
Received: from havoc.gtf.org ([69.61.125.42]:4017 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751057AbWJELsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 07:48:53 -0400
Date: Thu, 5 Oct 2006 07:48:48 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/microcode: handle sysfs error
Message-ID: <20061005114848.GA10397@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 arch/i386/kernel/microcode.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/i386/kernel/microcode.c b/arch/i386/kernel/microcode.c
index bca92be..441f140 100644
--- a/arch/i386/kernel/microcode.c
+++ b/arch/i386/kernel/microcode.c
@@ -656,14 +656,18 @@ static struct attribute_group mc_attr_gr
 
 static int mc_sysdev_add(struct sys_device *sys_dev)
 {
-	int cpu = sys_dev->id;
+	int err, cpu = sys_dev->id;
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 
 	if (!cpu_online(cpu))
 		return 0;
+
 	pr_debug("Microcode:CPU %d added\n", cpu);
 	memset(uci, 0, sizeof(*uci));
-	sysfs_create_group(&sys_dev->kobj, &mc_attr_group);
+
+	err = sysfs_create_group(&sys_dev->kobj, &mc_attr_group);
+	if (err)
+		return err;
 
 	microcode_init_cpu(cpu);
 	return 0;
