Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267368AbUHJVXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267368AbUHJVXw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 17:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267727AbUHJVXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 17:23:52 -0400
Received: from proxy.quengel.org ([213.146.113.159]:5760 "EHLO
	gerlin1.quengel.org") by vger.kernel.org with ESMTP id S267368AbUHJVWz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 17:22:55 -0400
To: linux-kernel@vger.kernel.org
Subject: rc4-mm1 pci-routing
From: Ralf Gerbig <rge-news@quengel.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Date: Tue, 10 Aug 2004 23:22:51 +0200
Message-ID: <87pt5yit78.fsf-news@hsp-law.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[sorry for sending this to lkml, instead of bjorn.helgaas@hp.com 
but smtp.hp.com does not like my mail]

Hi,

rc4-mm1 hangs while trying to get alsa up.

as per your request:

lspci:

0000:00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?) (rev c1)
0000:00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (rev c1)
0000:00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev c1)
0000:00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev c1)
0000:00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev c1)
0000:00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev c1)
0000:00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
0000:00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
0000:00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
0000:00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
0000:00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
0000:00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet Controller (rev a1)
0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio Controler (MCP) (rev a1)
0000:00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev a3)
0000:00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
0000:00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1)
0000:01:06.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
0000:01:06.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
0000:01:07.0 Network controller: AVM Audiovisuelles MKTG & Computer System GmbH Fritz!PCI v2.0 ISDN (rev 01)
0000:01:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
0000:01:09.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 02)
0000:01:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
0000:01:0c.0 RAID bus controller: CMD Technology Inc Silicon Image SiI 3112 SATARaid Controller (rev 02)
0000:01:0d.0 FireWire (IEEE 1394): Lucent Microelectronics FW323 (rev 61)
0000:02:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV280 [Radeon 9200] (rev 01)
0000:02:00.1 Display controller: ATI Technologies Inc: Unknown device 5941 (rev 01)

and the diff between plain and pci=routeirq:

--- /home/rge/boot.no_workie	2004-08-10 21:31:21.000000000 +0200
+++ /var/log/boot.msg	2004-08-10 21:34:02.718847882 +0200
@@ -136,13 +136,35 @@
 <6>usbcore: registered new driver usbfs
 <6>usbcore: registered new driver hub
 <6>PCI: Using ACPI for IRQ routing
-<6>** PCI interrupts are no longer routed automatically.  If this
-<6>** causes a device to stop working, it is probably because the
-<6>** driver failed to call pci_enable_device().  As a temporary
-<6>** workaround, the "pci=routeirq" argument restores the old
-<6>** behavior.  If this argument makes the device work again,
+<6>** Routing PCI interrupts for all devices because "pci=routeirq"
+<6>** was specified.  If this was required to make a driver work,
 <6>** please email the output of "lspci" to bjorn.helgaas@hp.com
 <6>** so I can fix the driver.
+<4>ACPI: PCI Interrupt Link [APCS] enabled at IRQ 23
+<6>ACPI: PCI interrupt 0000:00:01.1[A] -> GSI 23 (level, high) -> IRQ 23
+<4>ACPI: PCI Interrupt Link [APCF] enabled at IRQ 22
+<6>ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 22 (level, high) -> IRQ 22
+<4>ACPI: PCI Interrupt Link [APCG] enabled at IRQ 21
+<6>ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 21 (level, high) -> IRQ 21
+<4>ACPI: PCI Interrupt Link [APCL] enabled at IRQ 20
+<6>ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 20 (level, high) -> IRQ 20
+<4>ACPI: PCI Interrupt Link [APCH] enabled at IRQ 22
+<6>ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 22 (level, high) -> IRQ 22
+<4>ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 21
+<6>ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 21 (level, high) -> IRQ 21
+<4>ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
+<6>ACPI: PCI interrupt 0000:01:06.0[A] -> GSI 18 (level, high) -> IRQ 18
+<6>ACPI: PCI interrupt 0000:01:06.1[A] -> GSI 18 (level, high) -> IRQ 18
+<4>ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
+<6>ACPI: PCI interrupt 0000:01:07.0[A] -> GSI 19 (level, high) -> IRQ 19
+<4>ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
+<6>ACPI: PCI interrupt 0000:01:08.0[A] -> GSI 16 (level, high) -> IRQ 16
+<4>ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
+<6>ACPI: PCI interrupt 0000:01:09.0[A] -> GSI 17 (level, high) -> IRQ 17
+<6>ACPI: PCI interrupt 0000:01:0b.0[A] -> GSI 19 (level, high) -> IRQ 19
+<6>ACPI: PCI interrupt 0000:01:0c.0[A] -> GSI 16 (level, high) -> IRQ 16
+<6>ACPI: PCI interrupt 0000:01:0d.0[A] -> GSI 17 (level, high) -> IRQ 17
+<6>ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 19 (level, high) -> IRQ 19
 <4>vesafb: probe of vesafb0 failed with error -6
 <6>Machine check exception polling timer started.
 <6>cpufreq: Detected nForce2 chipset revision C1
@@ -183,7 +205,6 @@
 <4>hdd: SAMSUNG DVD-ROM SD-616E, ATAPI CD/DVD-ROM drive
 <4>ide1 at 0x170-0x177,0x376 on irq 15
 <6>PDC20268: IDE controller at PCI slot 0000:01:09.0
-<4>ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
 <6>ACPI: PCI interrupt 0000:01:09.0[A] -> GSI 17 (level, high) -> IRQ 17
 <6>PDC20268: chipset revision 2
 <6>PDC20268: 100%% native mode on irq 17
@@ -213,7 +234,6 @@
 <6> hde: hde1 hde2
 <7>libata version 1.02 loaded.
 <7>sata_sil version 0.54
-<4>ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
 <6>ACPI: PCI interrupt 0000:01:0c.0[A] -> GSI 16 (level, high) -> IRQ 16
 <6>ata1: SATA max UDMA/100 cmd 0xE0802080 ctl 0xE080208A bmdma 0xE0802000 irq 16
 <6>ata2: SATA max UDMA/100 cmd 0xE08020C0 ctl 0xE08020CA bmdma 0xE0802008 irq 16
@@ -272,7 +292,7 @@
 Kernel logging (ksyslog) stopped.
 Kernel log daemon terminating.
 
-Boot logging started on /dev/tty1(/dev/console) at Tue Aug 10 21:22:10 2004
+Boot logging started on /dev/tty1(/dev/console) at Tue Aug 10 21:33:28 2004
 
 Master Resource Control: previous runlevel: N, switching to runlevel: 5
 <notice>start services (random isdn hotplug)
@@ -290,14 +310,18 @@
 Setting up network interfaces:
     lo       
     lo        IP address: 127.0.0.1/8   
-doneWaiting for mandatory devices:  eth-id-00:00:1c:d7:58:77 eth-id-f6:00:78:af:8d:6c
-20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0 
-    eth-id-00:00:1c:d7:58:77            No interface found
-failed    eth-id-f6:00:78:af:8d:6c            No interface found
-failed    isdn0    
+done    eth0      device: nVidia Corporation nForce2 Ethernet Controller (rev a1)
+    eth0      configuration: eth-id-f6:00:78:af:8d:6c
+    eth0      IP address: 192.168.100.10/24
+doneWaiting for mandatory devices:  eth-id-00:00:1c:d7:58:77
+19 18 17 16 15 14 13 12 
+    eth1      device: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
+    eth1      configuration: eth-id-00:00:1c:d7:58:77
+    eth1      IP address: 192.168.150.1/24
+done    isdn0    
     isdn0     Startmode is 'manual'
-skippedSetting up service network  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .failed
-<notice>exit status of (network) is (7)
+skippedSetting up service network  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .done
+<notice>exit status of (network) is (0)
 <notice>start services (syslog)
 Starting syslog services<notice>startproc: execve (/sbin/syslogd) [ /sbin/syslogd -a /var/lib/dhcp/dev/log -a /var/lib/named/dev/log -a /var/lib/ntp/dev/log ], [ CONSOLE=/dev/console TERM=linux SHELL=/bin/sh progress=25 INIT_VERSION=sysvinit-2.85 REDIRECT=/dev/tty1 COLUMNS=80 PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin RUNLEVEL=5 PWD=/ PREVLEVEL=N LINES=25 SHLVL=2 sscripts=42 _=/sbin/startproc DAEMON=/sbin/syslogd ]
 <notice>startproc: execve (/sbin/klogd) [ /sbin/klogd -c 1 -2 ], [ CONSOLE=/dev/console TERM=linux SHELL=/bin/sh progress=25 INIT_VERSION=sysvinit-2.85 REDIRECT=/dev/tty1 COLUMNS=80 PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin RUNLEVEL=5 PWD=/ PREVLEVEL=N LINES=25 SHLVL=2 sscripts=42 _=/sbin/startproc DAEMON=/sbin/klogd ]
@@ -307,7 +331,19 @@
 Starting dsl<notice>startproc: execve (/usr/sbin/pppd) [ /usr/sbin/pppd call kamp ], [ CONSOLE=/dev/console TERM=linux SHELL=/bin/sh progress=26 INIT_VERSION=sysvinit-2.85 REDIRECT=/dev/tty1 COLUMNS=80 PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin RUNLEVEL=5 PWD=/ PREVLEVEL=N LINES=25 SHLVL=2 sscripts=42 _=/sbin/startproc DAEMON=/usr/sbin/pppd ]
 Plugin rp-pppoe.so loaded.
 RP-PPPoE plugin version 3.3 compiled against pppd 2.4.2
-/usr/sbin/pppd: In file /etc/ppp/peers/kamp: unrecognized option 'eth1'
+Using interface ppp0
+Connect: ppp0 <--> eth1
+Couldn't increase MTU to 1500
+Couldn't increase MRU to 1500
+Couldn't increase MTU to 1500
+Couldn't increase MRU to 1500
+Couldn't increase MTU to 1500
+Couldn't increase MRU to 1500
+PAP authentication succeeded
+peer from calling number 00:90:1A:10:10:00 authorized
+local  IP address 213.146.113.159
+remote IP address 195.62.99.234
+Script /etc/ppp/ip-up finished (pid 3351), status = 0x0
 done
 <notice>exit status of (kamp) is (0)
 <notice>start services (portmap)
@@ -320,25 +356,47 @@
 <notice>start services (wondershaper sshd named fbset alsasound)
 <notice>startproc: execve (/usr/sbin/sshd) [ /usr/sbin/sshd -o PidFile=/var/run/sshd.init.pid ], [ CONSOLE=/dev/console TERM=linux SHELL=/bin/sh progress=29 INIT_VERSION=sysvinit-2.85 REDIRECT=/dev/tty1 COLUMNS=80 PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin RUNLEVEL=5 PWD=/ PREVLEVEL=N LINES=25 SHLVL=2 sscripts=42 _=/sbin/startproc DAEMON=/usr/sbin/sshd ]
 Starting SSH daemondone
-Starting wondershaper failed
-Cannot find device "eth1"
-Cannot find device "eth1"
-Cannot find device "eth1"
-Cannot find device "eth1"
-Cannot find device "eth1"
-Cannot find device "eth1"
-Cannot find device "eth1"
-Cannot find device "eth1"
-Cannot find device "eth1"
-Cannot find device "eth1"
-Cannot find device "eth1"
-Cannot find device "eth1"
-Cannot find device "eth1"
-Cannot find device "eth1"
-Cannot find device "eth1"
-Cannot find device "eth1"
-Cannot find device "eth1"
-Cannot find device "eth1"
 <notice>startproc: execve (/usr/sbin/named) [ /usr/sbin/named -t /var/lib/named -u named ], [ CONSOLE=/dev/console TERM=linux SHELL=/bin/sh progress=29 INIT_VERSION=sysvinit-2.85 REDIRECT=/dev/tty1 COLUMNS=80 PATH=/sbin:/usr/sbin:/bin:/usr/bin RUNLEVEL=5 PWD=/ PREVLEVEL=N LINES=25 SHLVL=2 sscripts=42 _=/sbin/startproc DAEMON=/usr/sbin/named ]
 Starting name server BIND 9 done
-Starting sound driver:  intel8x0
\ Kein Zeilenumbruch am Dateiende.
+Starting wondershaper done
+Starting sound driver:  intel8x0 intel8x0done
+Restoring the previous sound settingdone
+<notice>exit status of (wondershaper sshd named fbset alsasound) is (0 0 0 0 0)
+<notice>start services (kbd)
+Loading keymap qwertz/de-latin1-nodeadkeys.map.gz
+doneLoading compose table latin1.adddone
+Start Unicode mode
+doneLoading console font lat9w-16.psfu  -m trivial (K
+done<notice>exit status of (kbd) is (0)
+<notice>start services (xntpd inn)
+<notice>startproc: execve (/usr/sbin/ntpd) [ /usr/sbin/ntpd -p /var/lib/ntp/var/run/ntp/ntpd.pid -u ntp -i /var/lib/ntp ], [ CONSOLE=/dev/console TERM=linux SHELL=/bin/sh progress=35 INIT_VERSION=sysvinit-2.85 REDIRECT=/dev/tty1 COLUMNS=80 PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin RUNLEVEL=5 PWD=/ PREVLEVEL=N LINES=25 SHLVL=2 sscripts=42 _=/sbin/startproc DAEMON=/usr/sbin/ntpd ]
+Try to get initial date and time via NTP from 192.53.103.104done
+Starting network time protocol daemon (NTPD)done
+Starting News-Server INNStarting innd.
+done
+<notice>exit status of (xntpd inn) is (0 0)
+<notice>start services (cups)
+Starting cupsd<notice>startproc: execve (/usr/sbin/cupsd) [ /usr/sbin/cupsd ], [ CONSOLE=/dev/console TERM=linux SHELL=/bin/sh progress=37 INIT_VERSION=sysvinit-2.85 REDIRECT=/dev/tty1 COLUMNS=80 PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin RUNLEVEL=5 PWD=/ PREVLEVEL=N LINES=25 SHLVL=2 sscripts=42 _=/sbin/startproc DAEMON=/usr/sbin/cupsd ]
+done
+<notice>exit status of (cups) is (0)
+<notice>start services (dhcpd)
+Starting DHCP server [chroot]done
+<notice>exit status of (dhcpd) is (0)
+<notice>start services (xdm postfix)
+<notice>startproc: execve (/opt/kde3/bin/kdm) [ /opt/kde3/bin/kdm ], [ LC_MONETARY= CONSOLE=/dev/console TERM=linux SHELL=/bin/sh LC_NUMERIC= QTDIR=/usr/lib/qt3 LC_ALL= progress=39 INIT_VERSION=sysvinit-2.85 KDEROOTHOME=/root/.kdm FROM_HEADER=quengel.org REDIRECT=/dev/tty1 COLUMNS=80 PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin LC_MESSAGES= RUNLEVEL=5 LC_COLLATE= PWD=/ LANG=de_DE.UTF-8 PREVLEVEL=N LINES=25 SHLVL=2 XCURSOR_THEME= no_proxy=localhost WINDOWMANAGER=/usr/X11R6/bin/kde LC_CTYPE=de_DE.UTF-8 sscripts=42 LC_TIME= _=/sbin/startproc DAEMON=/opt/kde3/bin/kdm ]
+Starting service kdmdone
+Starting mail service (Postfix)done
+getpt: No such file or directory
+could not get pty for /etc/init.d/rc5.d/S19xinetd
+<notice>exit status of (xdm postfix) is (0 0)
+<notice>start services (xinetd cron)
+getpt: No such file or directory
+could not get pty for /etc/init.d/rc5.d/S19cron
+Starting CRON daemonStarting INET services. (xinetd)<notice>startproc: execve (/usr/sbin/cron) [ /usr/sbin/cron ], [ CONSOLE=/dev/console TERM=linux SHELL=/bin/sh progress=41 INIT_VERSION=sysvinit-2.85 REDIRECT=/dev/tty1 COLUMNS=80 PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin RUNLEVEL=5 PWD=/ PREVLEVEL=N LINES=25 SHLVL=2 sscripts=42 _=/sbin/startproc DAEMON=/usr/sbin/cron ]
+<notice>startproc: execve (/usr/sbin/xinetd) [ /usr/sbin/xinetd ], [ CONSOLE=/dev/console TERM=linux SHELL=/bin/sh progress=41 INIT_VERSION=sysvinit-2.85 REDIRECT=/dev/tty1 COLUMNS=80 PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin RUNLEVEL=5 PWD=/ PREVLEVEL=N LINES=25 SHLVL=2 sscripts=42 _=/sbin/startproc DAEMON=/usr/sbin/xinetd ]
+done
+done
+<notice>exit status of (xinetd cron) is (0 0)
+Master Resource Control: runlevel 5 has been reached
+Skipped services in runlevel 5: isdn
+<notice>killproc: kill(1077,3)

This is a SuSE9.1, EPOX 8RDA3+

Sorry about LANG=de


Ralf
-- 
 P:     Linus Torvalds			patch-2.2.4
-S:     Buried alive in diapers
+S:     Buried alive in reporters
