Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265692AbTFNRL4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 13:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265693AbTFNRL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 13:11:56 -0400
Received: from smtp-out8.blueyonder.co.uk ([195.188.213.11]:19611 "EHLO
	smtp-out8.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S265692AbTFNRLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 13:11:55 -0400
From: Edward Macfarlane Smith <snowfire@blueyonder.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Machine does not shutdown with certain configuration
Date: Sat, 14 Jun 2003 18:26:21 +0100
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200306141826.21935.snowfire@blueyonder.co.uk>
X-OriginalArrivalTime: 14 Jun 2003 17:25:45.0652 (UTC) FILETIME=[FD3CEF40:01C33299]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since getting my new laptop (Sony PCG-Z1SP, it's a Centrino machine) I had 
never got it to successfully power off. I had just been using the SuSE kernel 
and then the same configuration that worked well on a couple of other 
machines, but I then tried a different configuration and it powered off, 
after I did a little playing I tracked it down to the "Local APIC support on 
uniprocessors" option. Turning this off makes the machine poweroff. 
I have checked this on 2.4.21-rc6-ac1 and 2.4.21-ac1. I just thought other 
people might find that useful to know. 
The text on the help for CONFIG_X86_UP_APIC seems to suggest it's fine to use 
it on any machine (and certainly while running it seems to make no 
difference), would a patch to the text to indicate it may prevent power off 
be accepted, or is this problem too specific to this machine to be included?
Regards,
Edward

e.g.

--- linux-2.4.21_ac1_orig/Documentation/Configure.help  2003-06-14 
16:00:30.000000000 +0100
+++ linux/Documentation/Configure.help  2003-06-14 18:04:18.000000000 +0100
@@ -289,6 +289,8 @@
   have a local APIC, then the kernel will still run with no slowdown at
   all. The local APIC supports CPU-generated self-interrupts (timer,
   performance counters), and the NMI watchdog which detects hard lockups.
+  On some machines (e.g. Sony Vaio PCG-Z1SP) this option may prevent the
+  machine from powering off when it is halted.

   If you have a system with several CPUs, you do not need to say Y
   here: the local APIC will be used automatically.

