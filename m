Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263244AbTJERmu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 13:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263272AbTJERmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 13:42:50 -0400
Received: from mailhost.cs.auc.dk ([130.225.194.6]:2045 "EHLO
	mailhost.cs.auc.dk") by vger.kernel.org with ESMTP id S263244AbTJERmm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 13:42:42 -0400
Subject: Re: Floppy disk working constantly [PATCH]
From: Emmanuel Fleury <fleury@cs.auc.dk>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1065186072.6517.44.camel@rade7.s.cs.auc.dk>
References: <1065186072.6517.44.camel@rade7.s.cs.auc.dk>
Content-Type: text/plain
Organization: Aalborg University -- Computer Science Dept.
Message-Id: <1065375728.11878.25.camel@rade7.s.cs.auc.dk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 05 Oct 2003 19:42:08 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Richard B. Johnson did this patch for 2.4.22. And, I applied it and
tested it on both 2.4.22 and 2.6.0-test6. It seems to work.

Please apply this patch to both 2.4.22 and 2.6.0-test6.

-----------------
--- linux-2.4.22/arch/i386/boot/setup.S.orig    Fri Aug  2 20:39:42 2002
+++ linux-2.4.22/arch/i386/boot/setup.S Fri Oct  3 11:50:43 2003
@@ -59,6 +59,8 @@
 #define SIG1   0xAA55
 #define SIG2   0x5A5A

+FDC_MOTOR = 0x3f2
+FDC_MOTON = 0x10
 INITSEG  = DEF_INITSEG         # 0x9000, we move boot here, out of the
way
 SYSSEG   = DEF_SYSSEG          # 0x1000, system loaded at 0x10000
(65536).
 SETUPSEG = DEF_SETUPSEG                # 0x9020, this is the current
segment
@@ -776,6 +778,12 @@

        movb    $0xFB, %al                      # mask all irq's but
irq2 which
        outb    %al, $0x21                      # is cascaded
+
+       movl    $FDC_MOTOR, %edx                # FDC motor control
+       inb     %dx, %al                        # Get what's there
+       andb    $~FDC_MOTON, %al                # Reset motor bit
+       outb    %al, %dx                        # Turn OFF motor
+

 # Well, that certainly wasn't fun :-(. Hopefully it works, and we don't
 # need no steenking BIOS anyway (except for the initial loading :-).
------------

Regards
-- 
Emmanuel

`Right,' said Ford, `I'm going to have a look.'
He glanced round at the others. `Is no one going to say,
"No you can't possibly, let me go instead"?'
They all shook their heads. `Oh well.'
  -- Ford attempting to be heroic (Douglas Adams)

