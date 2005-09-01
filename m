Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030270AbVIASFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030270AbVIASFe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 14:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030273AbVIASFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 14:05:34 -0400
Received: from loki.cs.umass.edu ([128.119.243.168]:14031 "EHLO
	mail.cs.umass.edu") by vger.kernel.org with ESMTP id S1030270AbVIASFd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 14:05:33 -0400
Message-ID: <43174438.5040704@cs.umass.edu>
Date: Thu, 01 Sep 2005 14:11:04 -0400
From: "Thomas S. Heydt-Benjamin" <tshb@cs.umass.edu>
Reply-To: tshb@cs.umass.edu
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.13 freezes during acpi wakup with wake-on-lan
X-Enigmail-Version: 0.92.0.0
OpenPGP: url=http://www.cs.umass.edu/~tshb/tshb.pub
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Spam-Net-Tests: NO (loki, relay 128.119.40.196 auth=site-local)
X-Spam-Checked: This message probably not SPAM
X-Spam-Score: -1.626, Required: 5
X-Spam-Tests: BAYES_00,UPPERCASE_25_50
X-Spam-Report-$ThisHost: ---- Start SpamAssassin (v2.6xx-cscf) results
	-1.7 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	                            [score: 0.0000]
	 0.0 UPPERCASE_25_50        message body is 25-50% uppercase
X-MIMEDefang-Relay-1852595aaf0946a4530a11f79d6f33e3dfd75698: 128.119.40.196
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


I am working with an IBM X31 laptop running Redhat FC5 with 2.6.13
kernel.  I need to get wake-on-lan working for mobile systems power
management experiments that we are performing in my lab.

The kernel is configured to use ACPI (pertinent kernel configuration
excerpt follows message).

When I put the laptop into "mem" suspend state (exact procedure follows
message), and then wake it up with a magic packet to it's NIC, I get an
infinite number of error messages and a frozen computer.

The error message is: "evgpe-0700: *** Error: acpi_ev_gpe_dispatch: No
handler or method for GPE[ B], disabling event" which repeats forever in
an infinite loop.  I have googled extensively for a solution,
unfortunately all published answers that I have found simply say "use
APM instead of ACPI".  When we use APM, we find that power is cut to the
NIC when in mem suspend state, thus preventing the possibility of
wake-on-lan.

Any suggestions greatly appreciated.  Several people in my lab have
tried to get this working, and all have failed.

			---Tom Heydt-Benjamin

- ------------------ Procedure for mem suspend ----------------------
[root@csdhcp173 acpi]# uname -a
Linux csdhcp173.csdhcp.cs.local 2.6.13 #1 Wed Aug 31 11:58:14 EDT 2005
i686 i686 i386 GNU/Linux
[root@csdhcp173 acpi]# cd /proc/acpi
[root@csdhcp173 acpi]# cat wakeup
Device  Sleep state     Status
 LID       3            *enabled
SLPB       3            *enabled
PCI0       3            disabled
UART       3            disabled
PCI1       4            disabled
DOCK       4            disabled
USB0       3            disabled
USB1       3            disabled
USB2       3            disabled
AC9M       4            disabled
[root@csdhcp173 acpi]# echo "PCI0" > wakeup
[root@csdhcp173 acpi]# echo "PCI1" > wakeup
[root@csdhcp173 acpi]# ethtool -s eth0 wol g
[root@csdhcp173 acpi]# echo "mem" > /sys/power/state
- ------------------ Pertinant .config excerpt -----------------------
# Power management options (ACPI, APM)
#
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_PM_STD_PARTITION=""

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
# CONFIG_ACPI_SLEEP_PROC_SLEEP is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_HOTKEY=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
CONFIG_ACPI_IBM=y
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR=2001
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
# CONFIG_ACPI_CONTAINER is not set


#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)
Comment: GnuPT 2.6.2.1 by EQUIPMENTE.DE
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDF0Q4aLVgMs89qN8RAjFKAJ46TrSoYHnDRjX7RHx1K8CGXoQwygCgw2zQ
eq6fEz53pXNjQLPgmxn7dQo=
=/uxE
-----END PGP SIGNATURE-----
