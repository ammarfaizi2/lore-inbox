Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbWAWG3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWAWG3L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 01:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWAWG3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 01:29:11 -0500
Received: from main.gmane.org ([80.91.229.2]:17334 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751317AbWAWG3L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 01:29:11 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: CONFIG_X86_PM_TIMER broken in 2.6.15.1 (since before 2.6.14?)
Date: Mon, 23 Jan 2006 15:28:57 +0900
Message-ID: <dr1t39$qod$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s185160.ppp.asahi-net.or.jp
User-Agent: Mail/News 1.5 (X11/20060119)
X-Enigmail-Version: 0.94.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

Now I have a repeatable confirmation that selecting CONFIG_X86_PM_TIMER=y
does "break" printk on a few systems.

With CONFIG_X86_PM_TIMER=y pmtmr is preferred to tsc and as a result, printk
time is not reset on CPU init.

The difference (hand diff) between the dmesg in the two configs is:

normal( # CONFIG_X86_PM_TIMER is not set ):
...

...
[17179569.184000] PID hash table entries: 4096 (order: 12, 65536 bytes)
          [    0.000000] Detected 3011.142 MHz processor.
                    [   25.672059] Using tsc for high-res timesource
                              [   25.673931] Console: colour VGA+ 80x25



broken ( CONFIG_X86_PM_TIMER=y ):
...
[17179569.184000] ACPI: PM-Timer IO Port: 0x808
...
[17179569.184000] PID hash table entries: 4096 (order: 12, 65536 bytes)

[17179569.184000] Detected 3011.098 MHz processor.

[17179569.184000] Using pmtmr for high-res timesource

[17179569.184000] Console: colour VGA+ 80x25


Apart from that everything is the same (apart from the prink time).

Any clues as to why might this be broken?

I tired to look under arch/i386/kernel/timers but it was too much for me,
got buried under too many jiffies :-)


Kalin.

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

