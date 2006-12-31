Return-Path: <linux-kernel-owner+w=401wt.eu-S932676AbWLaC0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932676AbWLaC0N (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 21:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932679AbWLaC0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 21:26:12 -0500
Received: from wx-out-0506.google.com ([66.249.82.234]:49187 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932676AbWLaC0M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 21:26:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:organization:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=FkAjdRgae3BTFju7uuALIx/xw4NZWrSDVsynDDzdix3w6uDcG6oSMXv1cHwzKywSj9dtxc/R5z456NiqIw+D0c+s0E/eiKSwMDgOpg88ppPqdDMuNa8F18F6nXdewPIB8ed5kpnZpvKO/5jBbUePH4IE0kAsBTSj5Zmy6lMCJfI=
Date: Sat, 30 Dec 2006 18:26:03 -0800
From: Amit Choudhary <amit2030@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.20-rc2] [BUGFIX] drivers/atm/firestream.c: Fix infinite
 recursion when alignment passed is 0.
Message-Id: <20061230182603.d3815dcb.amit2030@gmail.com>
Organization: X
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.15; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Fix infinite recursion when alignment passed is 0 in function aligned_kmalloc(), in file drivers/atm/firestream.c. Also, a negative value for alignment does not make sense. Check for negative value too.
The function prototype is:
		static void __devinit *aligned_kmalloc (int size, gfp_t flags, int alignment).


Signed-off-by: Amit Choudhary <amit2030@gmail.com>

diff --git a/drivers/atm/firestream.c b/drivers/atm/firestream.c
index 9c67df5..2ba6b2e 100644
--- a/drivers/atm/firestream.c
+++ b/drivers/atm/firestream.c
@@ -1385,7 +1385,7 @@ static void __devinit *aligned_kmalloc (
 
 	if (alignment <= 0x10) {
 		t = kmalloc (size, flags);
-		if ((unsigned long)t & (alignment-1)) {
+		if ((unsigned long)t & ((alignment <= 0) ? 0 : (alignment-1))) {
 			printk ("Kmalloc doesn't align things correctly! %p\n", t);
 			kfree (t);
 			return aligned_kmalloc (size, flags, alignment * 4);
