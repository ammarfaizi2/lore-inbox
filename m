Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132152AbRDCPVX>; Tue, 3 Apr 2001 11:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132167AbRDCPVN>; Tue, 3 Apr 2001 11:21:13 -0400
Received: from gherkin.sa.wlk.com ([192.158.254.49]:10756 "HELO
	gherkin.sa.wlk.com") by vger.kernel.org with SMTP
	id <S132152AbRDCPU5>; Tue, 3 Apr 2001 11:20:57 -0400
Message-Id: <m14kSbM-0005khC@gherkin.sa.wlk.com>
From: rct@gherkin.sa.wlk.com (Bob_Tracy)
Subject: Cyrix/mtrr fix missing from 2.4.3
To: linux-kernel@vger.kernel.org
Date: Tue, 3 Apr 2001 10:20:12 -0500 (CDT)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following fix was omitted from 2.4.3.  It corrects a problem
where the mtrr code attempts to set up a region twice as large as
the user requested.

The original message appeared in linux-kernel on 14 Mar 2001.

--Bob Tracy

----- Forwarded message from David Wragg -----
>From: David Wragg <dpw@doc.ic.ac.uk>
>Date: 14 Mar 2001 22:57:21 +0000

Oops, it got broken by the MTRR >32-bit support in 2.4.0-testX.  The
patch below should fix it.

Joerg, I think this might well fix your Cyrix mtrr problem also.

Let me know how it goes,
Dave Wragg

diff -uar linux-2.4.2/arch/i386/kernel/mtrr.c linux-2.4.2.cyrix/arch/i386/kernel/mtrr.c
--- linux-2.4.2/arch/i386/kernel/mtrr.c	Thu Feb 22 15:24:53 2001
+++ linux-2.4.2.cyrix/arch/i386/kernel/mtrr.c	Wed Mar 14 22:28:02 2001
@@ -538,7 +538,7 @@
      * Note: shift==0xf means 4G, this is unsupported.
      */
     if (shift)
-      *size = (reg < 7 ? 0x1UL : 0x40UL) << shift;
+      *size = (reg < 7 ? 0x1UL : 0x40UL) << (shift - 1);
     else
       *size = 0;
 

----- End of forwarded message from David Wragg -----
