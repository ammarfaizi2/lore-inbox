Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131577AbRCNW6f>; Wed, 14 Mar 2001 17:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131578AbRCNW60>; Wed, 14 Mar 2001 17:58:26 -0500
Received: from duck.doc.ic.ac.uk ([146.169.1.46]:23306 "EHLO duck.doc.ic.ac.uk")
	by vger.kernel.org with ESMTP id <S131577AbRCNW6X>;
	Wed, 14 Mar 2001 17:58:23 -0500
To: rct@gherkin.sa.wlk.com (Bob_Tracy),
        Joerg Diederich <dieder@ibr.cs.tu-bs.de>
Cc: davej@suse.de, linux-kernel@vger.kernel.org
Subject: Re: another Cyrix/mtrr problem?
In-Reply-To: <m14d1KU-0005khC@gherkin.sa.wlk.com>
From: David Wragg <dpw@doc.ic.ac.uk>
Date: 14 Mar 2001 22:57:21 +0000
Message-ID: <y7ru24wuffy.fsf@sytry.doc.ic.ac.uk>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rct@gherkin.sa.wlk.com (Bob_Tracy) writes:
> Unfortunately, when I execute
> 
> echo "base=0xd8000000 size=0x100000 type=write-combining" >| /proc/mtrr
> 
> I get a 2MB region instead of the 1MB region I expected...

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
 
