Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751486AbWF1RRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbWF1RRh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 13:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbWF1RRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 13:17:37 -0400
Received: from gw.goop.org ([64.81.55.164]:63468 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751478AbWF1RRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 13:17:35 -0400
Message-ID: <44A2B9AF.50803@goop.org>
Date: Wed, 28 Jun 2006 10:17:35 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: 2.6.17-mm3: swsusp fails when process is debugged by ptrace
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I try to suspend the machine while a process debug-stopped by ptrace, 
suspend fails:

PM: Preparing system for mem sleep
Freezing cpus ...
Breaking affinity for irq 0
Breaking affinity for irq 1
Breaking affinity for irq 12
Breaking affinity for irq 23
CPU 1 is now offline
SMP alternatives: switching to UP code
CPU1 is down
Stopping tasks: ==========================================================================================================================================================
 stopping tasks timed out after 20 seconds (13 tasks remaining):
  khubd
  kseriod
  pdflush
  pdflush
  kswapd0
  kprefetchd
  pccardd
  kirqd
  kjournald
  kauditd
  knodemgrd_0
  kjournald
  test-vsnprintf
Restarting tasks...<6> Strange, khubd not stopped
 Strange, kseriod not stopped
 Strange, pdflush not stopped
 Strange, pdflush not stopped
 Strange, kswapd0 not stopped
 Strange, kprefetchd not stopped
 Strange, pccardd not stopped
 Strange, kirqd not stopped
 Strange, kjournald not stopped
 Strange, kauditd not stopped
 Strange, knodemgrd_0 not stopped
 Strange, kjournald not stopped
 Strange, test-vsnprintf not stopped
 done
Thawing cpus ...

In this case, test-vsnprintf is stopped in a breakpoint in gdb.  If I 
quit it, then suspend works as expected.

    J

