Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264398AbUEYA5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264398AbUEYA5O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 20:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264402AbUEYA5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 20:57:14 -0400
Received: from ws3.netA.ort.spb.ru ([195.70.200.211]:52456 "EHLO
	gate-n.ort.spb.ru") by vger.kernel.org with ESMTP id S264398AbUEYA5L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 20:57:11 -0400
Date: Tue, 25 May 2004 04:57:04 +0400 (MSD)
From: Andrew Shirrayev <andrews@gate.ort.spb.ru>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: e100 or e1000 on SMP kernel freeze system (ipx+ncp)
Message-ID: <Pine.LNX.4.33.0405250357340.30203-100000@gate.ort.spb.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score-Gate: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


#If run this script on start-up,
#kernel hung with high risk...

echo disconnect eth0-cable and press Enter
read
insmod e100
# or
#insmod e1000
ip link set eth0 up
ipx_interface add -p eth0 802.2 111
#run ncpmount 2 times.
ncpmount -S srv -U usr -n /mnt
ncpmount -S srv -U usr -n /mnt
echo insert eth0-cable to NIC
echo and wait 3-4 seconds until
echo message \"NIC Link is Up\"
echo and press Enter
while ! read -t 1; do echo  -n .;done
echo Don't hung? Great...
==============================
if add "sleep 1" beetwen ncpmount
risk of hung decrease, and <1%...

ncpmount 2.2.0.18 have dalay approximately 1 second
before print error message... Same result?

ncpmount 2.2.4 print error message very fast...
==============================
Result table:
1)
  Kernel: 2.4.21 or 2.4.26 (SMP, acpi on or off)
  system: 2xP4Xeon (HT on or off) on ServerWorks chipset
  NIC: dual e1000
  ncpfs+ipx: 2.2.4 (Debian)
  Result: Freeze after message "NIC Link is Up"
  Risk of hung: 99%
2)
  Kernel: 2.4.21 (SMP, acpi off)
  system: 2xP4Xeon (HT on or off) on ServerWorks chipset
  NIC: dual e1000
  ncpfs+ipx: 2.2.0.18 (Debian)
  Result: Don't freeze after message "NIC Link is Up"
  Risk of hung: less 10%
3)
  Kernel: 2.4.26 (nonSMP, acpi off)
  system: 2xP4Xeon (HT on or off) on ServerWorks chipset
  NIC: dual e1000
  ncpfs+ipx: 2.2.4 (Debian)
  Result: Don't freeze after message "NIC Link is Up"
  Risk of hung: less 1% :-)
4)
  Kernel: 2.4.26 (SMP, acpi on or off)
  system: P4 on intel chipset
  NIC: e100
  ncpfs+ipx: 2.2.0.18 (Debian)
  Result: Some times freeze after message "NIC Link is Up"
  Risk of hung: >10%
5)
  Kernel: 2.4.26 (SMP, acpi on or off)
  system: P4 on intel chipset
  NIC: e1000
  ncpfs+ipx: 2.2.0.18 (Debian)
  Result: Some times freeze after message "NIC Link is Up"
  Risk of hung: >10%
6)
  Kernel: 2.4.26 (nonSMP, acpi off)
  system: P4 on intel chipset
  NIC: e1000 or e100
  ncpfs+ipx: 2.2.0.18 (Debian)
  Result: Don't freeze after message "NIC Link is Up"
  Risk of hung: less 1%



