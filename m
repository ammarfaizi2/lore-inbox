Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbUKRSB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbUKRSB2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 13:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262836AbUKRSBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 13:01:25 -0500
Received: from pop.gmx.de ([213.165.64.20]:26056 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262830AbUKRSAz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 13:00:55 -0500
X-Authenticated: #8922711
From: "Gerold J. Wucherpfennig" <gjwucherpfennig@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Kernel thoughts of a Linux user
Date: Thu, 18 Nov 2004 18:59:27 +0100
User-Agent: KMail/1.6.82
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200411181859.27722.gjwucherpfennig@gmx.net>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- setting up kernel boot parameters with graphical tools is unreliable, 
because the system doesn't know which bootloader entry was chosen.
One solution to this issue is to create a new kernel parameter "loaderhint"
where the bootloader will be able to set the number of the chosen boot entry.
In the configuration file of the bootloader this will have to be explicitly 
remarked e.g. ... loaderhint=%selection% ... . Unfortunately this could be
circumvented, because it isn't mandatory and could be manipulated in the boot 
loader configuration. (Other/better suggestions are welcome)

-speed up the booting process and make the system more reliable and
secure by skipping to autoprobe all devices. Instead initialize only the
devices which were set up at the last system startup. The data can be given
by kernel parameters or there could be established a more convenient
mechanism. This data will be stored automatically when the system startup
is completed (by some shell script etc.) There will be a kernel mechanism to
tell userspace about available, but unconfigured, unprobed devices (sysfs?)
and a mechanism to set up each device separately. There has to be a fallback
mechanism which lets the kernel boot with full probing like it is done today,
of course. (Other/better suggestions are welcome).

- The above mentioned ideas will pave the way to some sort of device manager
which can enable/disable devices, initialize new devices and store all those
settings across system reboots as it has never been possible in the UNIX/Linux
world before

- Make sysfs optional and enable to publish kernel <-> userspace data
especially the kernel's KObject data across the kernel's netlink interface as
it has been summarized on www.kerneltrap.org. This will avoid the
deadlocks sysfs does introduce when some userspace app holds an open file
handle of an sysfs object (KObject) which is to be removed. An importrant side 
effect for embedded systems will be that the RAM overhead introduced by sysfs
will vaporize.

- Replace DRI with sth. slimmer and intoduce real kernel drivers
and introduce real kernel drivers which handel all the initialization and 
interrupt handling (only minimal hardware abstraction). One goal is to
remove X.org's PCI magic. Ultimately this shall give framebuffer and X
the same basis. This was summarized on kerneltrap.org.


I hope this thoughts will be helpful to someone and may lead to a discussion
which will lead to code which resolves some deficiencies of Linux systems
(compared to features of some other prominent operating system).
