Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278128AbRJ1KdN>; Sun, 28 Oct 2001 05:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278125AbRJ1KdE>; Sun, 28 Oct 2001 05:33:04 -0500
Received: from smtp.mailbox.co.uk ([195.82.125.32]:60598 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S278128AbRJ1Kco>; Sun, 28 Oct 2001 05:32:44 -0500
Date: Sun, 28 Oct 2001 10:33:18 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Patch: mark CSZ packet scheduling algorithm experimental
Message-ID: <20011028103318.A21147@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The Configure.help entry for the CSZ packet scheduling algorithm describes
this code as:

  Note: this scheduler is currently broken.

Unfortunately, there isn't a description of _what_ is broken, and not
having any experience of packet schedulers... 8)

So, if this is no longer true, the comment should be removed from the
help entry.  If it is still true, the following patch might be
appropriate:

--- orig/Documentation/Configure.help	Sat Oct 27 22:00:22 2001
+++ linux/Documentation/Configure.help	Sun Oct 28 10:24:28 2001
@@ -9066,7 +9066,7 @@
   whenever you want).  If you want to compile it as a module, say M
   here and read <file:Documentation/modules.txt>.
 
-CSZ packet scheduler
+CSZ packet scheduler (experimental)
 CONFIG_NET_SCH_CSZ
   Say Y here if you want to use the Clark-Shenker-Zhang (CSZ) packet
   scheduling algorithm for some of your network devices.  At the
--- orig/net/sched/Config.in	Sat Jan 22 19:46:44 2000
+++ linux/net/sched/Config.in	Sun Oct 28 10:24:57 2001
@@ -4,7 +4,7 @@
 define_bool CONFIG_NETLINK y
 define_bool CONFIG_RTNETLINK y	
 tristate '  CBQ packet scheduler' CONFIG_NET_SCH_CBQ
-tristate '  CSZ packet scheduler' CONFIG_NET_SCH_CSZ
+dep_tristate '  CSZ packet scheduler (experimental)' CONFIG_NET_SCH_CSZ $CONFIG_EXPERIMENTAL
 #tristate '  H-PFQ packet scheduler' CONFIG_NET_SCH_HPFQ
 #tristate '  H-FSC packet scheduler' CONFIG_NET_SCH_HFCS
 if [ "$CONFIG_ATM" = "y" ]; then


--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

