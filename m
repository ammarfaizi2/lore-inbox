Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271889AbRIIEnm>; Sun, 9 Sep 2001 00:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271890AbRIIEnc>; Sun, 9 Sep 2001 00:43:32 -0400
Received: from blount.mail.mindspring.net ([207.69.200.226]:35844 "EHLO
	blount.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S271889AbRIIEnT>; Sun, 9 Sep 2001 00:43:19 -0400
Subject: Re: [PATCH] (Updated) Preemptible Kernel
From: Robert Love <rml@ufl.edu>
To: linux-kernel@vger.kernel.org
In-Reply-To: <999813729.2039.9.camel@phantasy>
In-Reply-To: <999813729.2039.9.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.05.07.08 (Preview Release)
Date: 09 Sep 2001 00:44:00 -0400
Message-Id: <1000010641.9763.3.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

with the preemption config set, there is a compile failure with the
ieee1394 drivers.  thank you to Patrick Chase and the others who
reported this.

note: drivers are going to need to explicity include linux/sched.h if
they use (certain) spinlock primitives and want to compile with
CONFIG_PREEMPT set.  its cleaner anyhow.

this patch is against 2.4.9-ac10 but should be fine for 2.4.10-pre5...




diff -urN linux-2.4.9-ac10/drivers/ieee1394/ linux/drivers/ieee1394/csr.c
--- linux-2.4.9-ac10/drivers/ieee1394/csr.c	Fri Sep  7 23:53:41 2001
+++ linux/drivers/ieee1394/csr.c	Sun Sep  9 00:07:21 2001
@@ -10,6 +10,7 @@
  */
 
 #include <linux/string.h>
+#include <linux/sched.h>
 
 #include "ieee1394_types.h"
 #include "hosts.h"




-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

