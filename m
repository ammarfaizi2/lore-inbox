Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbTKXUwQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 15:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbTKXUwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 15:52:16 -0500
Received: from mail.ccur.com ([208.248.32.212]:23302 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S261406AbTKXUwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 15:52:14 -0500
Message-ID: <3FC26F78.10303@ccur.com>
Date: Mon, 24 Nov 2003 15:52:08 -0500
From: John Blackwood <john.blackwood@ccur.com>
Reply-To: john.blackwood@ccur.com
Organization: Concurrent Computer Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: ak@muc.de
Subject: [PATCH] arch/x86_64/kernel/signal.c linux-2.6.0-test10
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

In linux-2.6.0-test10, I believe that there are several lines of code
in the x86_64 version of handle_signal() that will not ever be executed
and can most likely be removed.

I also believe that there are several lines that should be added to the
end of the do_signal() routine for handling the -ERESTART_RESTARTBLOCK
case.

Thank you.

diff -ru linux-2.6.0-test10/arch/x86_64/kernel/signal.c 
linux/arch/x86_64/kernel/signal.c
--- linux-2.6.0-test10/arch/x86_64/kernel/signal.c      2003-11-23 
20:32:33.000000000 -0500
+++ linux/arch/x86_64/kernel/signal.c   2003-11-24 11:30:18.000000000 -0500
@@ -371,10 +371,6 @@
                                regs->rax = regs->orig_rax;
                                regs->rip -= 2;
                }
-               if (regs->rax == (unsigned long)-ERESTART_RESTARTBLOCK){
-                       regs->rax = __NR_restart_syscall;
-                       regs->rip -= 2;
-               }
        }

 #ifdef CONFIG_IA32_EMULATION
@@ -453,6 +449,10 @@
                        regs->rax = regs->orig_rax;
                        regs->rip -= 2;
                }
+               else if (res == -ERESTART_RESTARTBLOCK) {
+                       regs->rax = __NR_restart_syscall;
+                       regs->rip -= 2;
+               }
        }
        return 0;
 }


