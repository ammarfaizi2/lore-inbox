Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbVCUJHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVCUJHH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 04:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbVCUJHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 04:07:06 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:9687 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S261711AbVCUJGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 04:06:23 -0500
Date: Mon, 21 Mar 2005 10:05:37 +0100
To: linux-usb-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Problems with connect/disconnect cycles
Message-ID: <20050321090537.GI14614@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear usb developers, dear Andrew!

I found that my builtin sd card reader connected via USB port
experiences several connect/reconnect cycles every time I boot.

I am using 2.6.11-mm4.

Here an excerpt from syslog:

.. from boot on connected, not in syslog ...

boot at around 20:40

Mar 20 20:44:51 gandalf vmunix: usb 2-2: USB disconnect, address 2
Mar 20 20:44:51 gandalf udev[4533]: removing device node '/dev/sdcard'
Mar 20 20:44:51 gandalf udev[4533]: removing all_partitions '/dev/sdcard[1-15]'
Mar 20 20:44:51 gandalf vmunix: usb 2-2: new full speed USB device using uhci_hcd and address 3
Mar 20 20:44:52 gandalf kernel: scsi1 : SCSI emulation for USB Mass Storage devices
Mar 20 20:44:52 gandalf vmunix: usb-storage: device found at 3
Mar 20 20:44:52 gandalf kernel: usb-storage: waiting for device to settle before scanning
Mar 20 20:44:52 gandalf usb.agent[4633]:      usb-storage: already loaded
Mar 20 20:44:57 gandalf vmunix:   Vendor: Generic   Model: Flash R/W         Rev: 2002
Mar 20 20:44:57 gandalf vmunix:   Type:   Direct-Access                      ANSI SCSI revision: 02
Mar 20 20:44:57 gandalf kernel: Attached scsi removable disk sda at scsi1, channel 0, id 0, lun 0
Mar 20 20:44:57 gandalf vmunix: usb-storage: device scan complete
Mar 20 20:44:57 gandalf scsi.agent[4672]: disk at /devices/pci0000:00/0000:00:1d.1/usb2/2-2/2-2:1.0/host1/target1:0:0/1:0:0:0
Mar 20 20:44:57 gandalf udev[4682]: configured rule in '/etc/udev/rules.d/00-local.rules[2]' applied, added symlink '%k'
Mar 20 20:44:57 gandalf udev[4682]: configured rule in '/etc/udev/rules.d/00-local.rules[2]' applied, 'sda' becomes 'sdcard'
Mar 20 20:44:57 gandalf udev[4682]: creating device node '/dev/sdcard'
Mar 20 20:44:57 gandalf udev[4682]: creating device partition nodes '/dev/sdcard[1-15]'
............. wait some time ...........
Mar 20 21:35:43 gandalf vmunix: usb 2-2: USB disconnect, address 3
Mar 20 21:35:43 gandalf udev[5076]: removing device node '/dev/sdcard'
Mar 20 21:35:43 gandalf udev[5076]: removing all_partitions '/dev/sdcard[1-15]'
Mar 20 21:35:43 gandalf vmunix: usb 2-2: new full speed USB device using uhci_hcd and address 4
Mar 20 21:35:44 gandalf kernel: scsi2 : SCSI emulation for USB Mass Storage devices
Mar 20 21:35:44 gandalf vmunix: usb-storage: device found at 4
Mar 20 21:35:44 gandalf kernel: usb-storage: waiting for device to settle before scanning
Mar 20 21:35:44 gandalf usb.agent[5176]:      usb-storage: already loaded
Mar 20 21:35:49 gandalf vmunix:   Vendor: Generic   Model: Flash R/W         Rev: 2002
Mar 20 21:35:49 gandalf vmunix:   Type:   Direct-Access                      ANSI SCSI revision: 02
Mar 20 21:35:49 gandalf vmunix: Attached scsi removable disk sda at scsi2, channel 0, id 0, lun 0
Mar 20 21:35:49 gandalf vmunix: usb-storage: device scan complete
Mar 20 21:35:49 gandalf scsi.agent[5213]: disk at /devices/pci0000:00/0000:00:1d.1/usb2/2-2/2-2:1.0/host2/target2:0:0/2:0:0:0
Mar 20 21:35:49 gandalf udev[5223]: configured rule in '/etc/udev/rules.d/00-local.rules[2]' applied, added symlink '%k'
Mar 20 21:35:49 gandalf udev[5223]: configured rule in '/etc/udev/rules.d/00-local.rules[2]' applied, 'sda' becomes 'sdcard'
Mar 20 21:35:49 gandalf udev[5223]: creating device node '/dev/sdcard'
Mar 20 21:35:49 gandalf udev[5223]: creating device partition nodes '/dev/sdcard[1-15]'
Mar 20 21:40:09 gandalf vmunix: usb 2-2: USB disconnect, address 4
Mar 20 21:40:09 gandalf udev[5282]: removing device node '/dev/sdcard'
Mar 20 21:40:09 gandalf udev[5282]: removing all_partitions '/dev/sdcard[1-15]'
Mar 20 21:40:09 gandalf vmunix: usb 2-2: new full speed USB device using uhci_hcd and address 5
Mar 20 21:40:09 gandalf kernel: scsi3 : SCSI emulation for USB Mass Storage devices
Mar 20 21:40:09 gandalf vmunix: usb-storage: device found at 5
Mar 20 21:40:09 gandalf kernel: usb-storage: waiting for device to settle before scanning
Mar 20 21:40:10 gandalf usb.agent[5382]:      usb-storage: already loaded
Mar 20 21:40:14 gandalf vmunix:   Vendor: Generic   Model: Flash R/W         Rev: 2002
Mar 20 21:40:14 gandalf kernel: rect-Access                      ANSI SCSI revision: 02
Mar 20 21:40:14 gandalf vmunix:   Type:   Di<5>Attached scsi removable disk sda at scsi3, channel 0, id 0, lun 0
Mar 20 21:40:14 gandalf kernel: usb-storage: device scan complete
Mar 20 21:40:15 gandalf scsi.agent[5424]: disk at /devices/pci0000:00/0000:00:1d.1/usb2/2-2/2-2:1.0/host3/target3:0:0/3:0:0:0
Mar 20 21:40:15 gandalf udev[5434]: configured rule in '/etc/udev/rules.d/00-local.rules[2]' applied, added symlink '%k'
Mar 20 21:40:15 gandalf udev[5434]: configured rule in '/etc/udev/rules.d/00-local.rules[2]' applied, 'sda' becomes 'sdcard'
Mar 20 21:40:15 gandalf udev[5434]: creating device node '/dev/sdcard'
Mar 20 21:40:15 gandalf udev[5434]: creating device partition nodes '/dev/sdcard[1-15]'
Mar 20 21:43:29 gandalf vmunix: usb 2-2: USB disconnect, address 5
Mar 20 21:43:29 gandalf udev[5471]: removing device node '/dev/sdcard'
Mar 20 21:43:29 gandalf udev[5471]: removing all_partitions '/dev/sdcard[1-15]'
Mar 20 21:43:30 gandalf vmunix: usb 2-2: new full speed USB device using uhci_hcd and address 6
Mar 20 21:43:30 gandalf kernel: scsi4 : SCSI emulation for USB Mass Storage devices
Mar 20 21:43:30 gandalf kernel: usb-storage: device found at 6
Mar 20 21:43:30 gandalf kernel: usb-storage: waiting for device to settle before scanning
Mar 20 21:43:30 gandalf usb.agent[5571]:      usb-storage: already loaded
Mar 20 21:43:35 gandalf vmunix:   Vendor: Generic   Model: Flash R/W         Rev: 2002
Mar 20 21:43:35 gandalf vmunix:   Type:   Direct-Access                      ANSI SCSI revision: 02
Mar 20 21:43:35 gandalf kernel: Attached scsi removable disk sda at scsi4, channel 0, id 0, lun 0
Mar 20 21:43:35 gandalf vmunix: usb-storage: device scan complete
Mar 20 21:43:35 gandalf scsi.agent[5608]: disk at /devices/pci0000:00/0000:00:1d.1/usb2/2-2/2-2:1.0/host4/target4:0:0/4:0:0:0
Mar 20 21:43:35 gandalf udev[5618]: configured rule in '/etc/udev/rules.d/00-local.rules[2]' applied, added symlink '%k'
Mar 20 21:43:35 gandalf udev[5618]: configured rule in '/etc/udev/rules.d/00-local.rules[2]' applied, 'sda' becomes 'sdcard'
Mar 20 21:43:35 gandalf udev[5618]: creating device node '/dev/sdcard'
Mar 20 21:43:35 gandalf udev[5618]: creating device partition nodes '/dev/sdcard[1-15]'
Mar 20 21:43:45 gandalf vmunix: usb 2-2: USB disconnect, address 6
Mar 20 21:43:45 gandalf udev[5634]: removing device node '/dev/sdcard'
Mar 20 21:43:45 gandalf udev[5634]: removing all_partitions '/dev/sdcard[1-15]'
Mar 20 21:43:45 gandalf vmunix: usb 2-2: new full speed USB device using uhci_hcd and address 7
Mar 20 21:43:45 gandalf kernel: scsi5 : SCSI emulation for USB Mass Storage devices
Mar 20 21:43:45 gandalf kernel: usb-storage: device found at 7
Mar 20 21:43:45 gandalf kernel: usb-storage: waiting for device to settle before scanning
Mar 20 21:43:45 gandalf usb.agent[5734]:      usb-storage: already loaded
Mar 20 21:43:50 gandalf kernel:   Vendor: Generic   Model: Flash R/W         Rev: 2002
Mar 20 21:43:50 gandalf kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Mar 20 21:43:50 gandalf vmunix: Attached scsi removable disk sda at scsi5, channel 0, id 0, lun 0
Mar 20 21:43:50 gandalf kernel: usb-storage: device scan complete
Mar 20 21:43:50 gandalf scsi.agent[5772]: disk at /devices/pci0000:00/0000:00:1d.1/usb2/2-2/2-2:1.0/host5/target5:0:0/5:0:0:0
Mar 20 21:43:50 gandalf udev[5782]: configured rule in '/etc/udev/rules.d/00-local.rules[2]' applied, added symlink '%k'
Mar 20 21:43:50 gandalf udev[5782]: configured rule in '/etc/udev/rules.d/00-local.rules[2]' applied, 'sda' becomes 'sdcard'
Mar 20 21:43:50 gandalf udev[5782]: creating device node '/dev/sdcard'
Mar 20 21:43:50 gandalf udev[5782]: creating device partition nodes '/dev/sdcard[1-15]'
Mar 20 21:44:19 gandalf vmunix: usb 2-2: USB disconnect, address 7
Mar 20 21:44:19 gandalf udev[5805]: removing device node '/dev/sdcard'
Mar 20 21:44:19 gandalf udev[5805]: removing all_partitions '/dev/sdcard[1-15]'
Mar 20 21:44:19 gandalf vmunix: usb 2-2: new full speed USB device using uhci_hcd and address 8
Mar 20 21:44:19 gandalf kernel: scsi6 : SCSI emulation for USB Mass Storage devices
Mar 20 21:44:19 gandalf vmunix: usb-storage: device found at 8
Mar 20 21:44:19 gandalf kernel: usb-storage: waiting for device to settle before scanning
Mar 20 21:44:20 gandalf usb.agent[5905]:      usb-storage: already loaded
Mar 20 21:44:20 gandalf vmunix: usb 2-2: USB disconnect, address 8
Mar 20 21:44:21 gandalf kernel: usb 2-2: new full speed USB device using uhci_hcd and address 9
Mar 20 21:44:21 gandalf vmunix: scsi7 : SCSI emulation for USB Mass Storage devices
Mar 20 21:44:21 gandalf kernel: usb-storage: device found at 9
Mar 20 21:44:21 gandalf kernel: usb-storage: waiting for device to settle before scanning
Mar 20 21:44:21 gandalf usb.agent[6016]:      usb-storage: already loaded
Mar 20 21:44:26 gandalf vmunix:   Vendor: Generic   Model: Flash R/W         Rev: 2002
Mar 20 21:44:26 gandalf vmunix:   Type:   Direct-Access                      ANSI SCSI revision: 02
Mar 20 21:44:26 gandalf kernel: Attached scsi removable disk sda at scsi7, channel 0, id 0, lun 0
Mar 20 21:44:26 gandalf vmunix: usb-storage: device scan complete
Mar 20 21:44:26 gandalf scsi.agent[6053]: disk at /devices/pci0000:00/0000:00:1d.1/usb2/2-2/2-2:1.0/host7/target7:0:0/7:0:0:0
Mar 20 21:44:26 gandalf udev[6063]: configured rule in '/etc/udev/rules.d/00-local.rules[2]' applied, added symlink '%k'
Mar 20 21:44:26 gandalf udev[6063]: configured rule in '/etc/udev/rules.d/00-local.rules[2]' applied, 'sda' becomes 'sdcard'
Mar 20 21:44:26 gandalf udev[6063]: creating device node '/dev/sdcard'
Mar 20 21:44:26 gandalf udev[6063]: creating device partition nodes '/dev/sdcard[1-15]'
Mar 20 21:47:10 gandalf vmunix: usb 2-2: USB disconnect, address 9
Mar 20 21:47:10 gandalf udev[6096]: removing device node '/dev/sdcard'
Mar 20 21:47:10 gandalf udev[6096]: removing all_partitions '/dev/sdcard[1-15]'
Mar 20 21:47:10 gandalf vmunix: usb 2-2: new full speed USB device using uhci_hcd and address 10
Mar 20 21:47:10 gandalf kernel: scsi8 : SCSI emulation for USB Mass Storage devices
Mar 20 21:47:10 gandalf vmunix: usb-storage: device found at 10
Mar 20 21:47:10 gandalf kernel: usb-storage: waiting for device to settle before scanning
Mar 20 21:47:11 gandalf usb.agent[6196]:      usb-storage: already loaded
Mar 20 21:47:15 gandalf vmunix:   Vendor: Generic   Model: Flash R/W         Rev: 2002
Mar 20 21:47:15 gandalf vmunix:   Type:   Direct-Access                      ANSI SCSI revision: 02
Mar 20 21:47:15 gandalf vmunix: Attached scsi removable disk sda at scsi8, channel 0, id 0, lun 0
Mar 20 21:47:15 gandalf kernel: usb-storage: device scan complete
Mar 20 21:47:15 gandalf scsi.agent[6233]: disk at /devices/pci0000:00/0000:00:1d.1/usb2/2-2/2-2:1.0/host8/target8:0:0/8:0:0:0
Mar 20 21:47:15 gandalf udev[6243]: configured rule in '/etc/udev/rules.d/00-local.rules[2]' applied, added symlink '%k'
Mar 20 21:47:15 gandalf udev[6243]: configured rule in '/etc/udev/rules.d/00-local.rules[2]' applied, 'sda' becomes 'sdcard'
Mar 20 21:47:15 gandalf udev[6243]: creating device node '/dev/sdcard'
Mar 20 21:47:15 gandalf udev[6243]: creating device partition nodes '/dev/sdcard[1-15]'
Mar 20 21:49:48 gandalf vmunix: usb 2-2: USB disconnect, address 10
Mar 20 21:49:48 gandalf udev[6265]: removing device node '/dev/sdcard'
Mar 20 21:49:48 gandalf udev[6265]: removing all_partitions '/dev/sdcard[1-15]'
Mar 20 21:49:48 gandalf vmunix: usb 2-2: new full speed USB device using uhci_hcd and address 11
Mar 20 21:49:48 gandalf kernel: scsi9 : SCSI emulation for USB Mass Storage devices
Mar 20 21:49:48 gandalf vmunix: usb-storage: device found at 11
Mar 20 21:49:48 gandalf kernel: usb-storage: waiting for device to settle before scanning
Mar 20 21:49:49 gandalf usb.agent[6365]:      usb-storage: already loaded
Mar 20 21:49:53 gandalf vmunix:   Vendor: Generic   Model: Flash R/W         Rev: 2002
Mar 20 21:49:53 gandalf vmunix:   Type:   Direct-Access                      ANSI SCSI revision: 02
Mar 20 21:49:53 gandalf kernel: Attached scsi removable disk sda at scsi9, channel 0, id 0, lun 0
Mar 20 21:49:53 gandalf vmunix: usb-storage: device scan complete
Mar 20 21:49:53 gandalf scsi.agent[6402]: disk at /devices/pci0000:00/0000:00:1d.1/usb2/2-2/2-2:1.0/host9/target9:0:0/9:0:0:0
Mar 20 21:49:54 gandalf udev[6412]: configured rule in '/etc/udev/rules.d/00-local.rules[2]' applied, added symlink '%k'
Mar 20 21:49:54 gandalf udev[6412]: configured rule in '/etc/udev/rules.d/00-local.rules[2]' applied, 'sda' becomes 'sdcard'
Mar 20 21:49:54 gandalf udev[6412]: creating device node '/dev/sdcard'
Mar 20 21:49:54 gandalf udev[6412]: creating device partition nodes '/dev/sdcard[1-15]'


I guess that this should not be the expected behaviour. Now the question
is wether this is a problem with -mm or with usb stuff?

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>                 Università di Siena
sip:preining@at43.tuwien.ac.at                             +43 (0) 59966-690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
RUNCORN (n.)
A peeble (q.v.) which is larger that a belper (q.v.)
			--- Douglas Adams, The Meaning of Liff
