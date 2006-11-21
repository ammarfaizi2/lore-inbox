Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031405AbWKUU1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031405AbWKUU1Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 15:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031406AbWKUU1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 15:27:24 -0500
Received: from mx2.cs.washington.edu ([128.208.2.105]:2957 "EHLO
	mx2.cs.washington.edu") by vger.kernel.org with ESMTP
	id S1031405AbWKUU1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 15:27:23 -0500
Date: Tue, 21 Nov 2006 12:27:22 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: d binderman <dcb314@hotmail.com>
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] i386 msr: remove unused variable
In-Reply-To: <BAY107-F28B649DE13B7A3C02F1B459CEC0@phx.gbl>
Message-ID: <Pine.LNX.4.64N.0611211225300.25455@attu4.cs.washington.edu>
References: <BAY107-F28B649DE13B7A3C02F1B459CEC0@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variable in msr_write().

Reported by D Binderman <dcb314@hotmail.com>.

Cc: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: David Rientjes <rientjes@cs.washington.edu>
---
 arch/i386/kernel/msr.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/i386/kernel/msr.c b/arch/i386/kernel/msr.c
index d535cdb..331bd59 100644
--- a/arch/i386/kernel/msr.c
+++ b/arch/i386/kernel/msr.c
@@ -195,7 +195,6 @@ static ssize_t msr_write(struct file *fi
 {
 	const u32 __user *tmp = (const u32 __user *)buf;
 	u32 data[2];
-	size_t rv;
 	u32 reg = *ppos;
 	int cpu = iminor(file->f_dentry->d_inode);
 	int err;
@@ -203,7 +202,7 @@ static ssize_t msr_write(struct file *fi
 	if (count % 8)
 		return -EINVAL;	/* Invalid chunk size */
 
-	for (rv = 0; count; count -= 8) {
+	for (; count; count -= 8) {
 		if (copy_from_user(&data, tmp, 8))
 			return -EFAULT;
 		err = do_wrmsr(cpu, reg, data[0], data[1]);
