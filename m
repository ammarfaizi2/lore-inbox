Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136264AbRAMCZR>; Fri, 12 Jan 2001 21:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136349AbRAMCZH>; Fri, 12 Jan 2001 21:25:07 -0500
Received: from ns1.netbauds.net ([194.207.240.11]:8 "EHLO ns1.netbauds.net")
	by vger.kernel.org with ESMTP id <S136264AbRAMCYt>;
	Fri, 12 Jan 2001 21:24:49 -0500
Message-ID: <3A5FBC50.8966DE33@netbauds.net>
Date: Sat, 13 Jan 2001 02:24:16 +0000
From: Darryl Miles <darryl@netbauds.net>
X-Mailer: Mozilla 4.6 [en] (X11; I; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: NETDEV WATCHDOG: eth0: transmit timed out
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am getting complete lockups of the NIC, up/down the interface doesn't
restore it.  rmmod/insmod of ne2k-pci and 8390 doesn't restore it.  A
reboot does.

The m/c with this card in isn't normally highly loaded on the network,
but under heavy load it will lockup completely (fairly reliably I
suspect).  I have also had this problem with 2.4.0-test11, I had traced
it to ei_tx_intr() in so much as it was calling the
"ei_local->stat.collisions += 16;" line.  This is 8390.c:635 in 2.4.0.


The log below shows the time I had reloaded the modules trying to bring
it back to life.

Jan 13 01:46:24 thehostname kernel: NETDEV WATCHDOG: eth0: transmit
timed out
Jan 13 01:46:24 thehostname kernel: eth0: Tx timed out, lost interrupt?
TSR=0x3, ISR=0x3, t=951.
Jan 13 01:46:26 thehostname kernel: NETDEV WATCHDOG: eth0: transmit
timed out
Jan 13 01:46:26 thehostname kernel: eth0: Tx timed out, lost interrupt?
TSR=0x3, ISR=0x3, t=100.
Jan 13 01:47:14 thehostname kernel: NETDEV WATCHDOG: eth0: transmit
timed out
Jan 13 01:47:14 thehostname kernel: eth0: Tx timed out, lost interrupt?
TSR=0x3, ISR=0x3, t=106.
Jan 13 01:47:15 thehostname kernel: NETDEV WATCHDOG: eth0: transmit
timed out
Jan 13 01:47:15 thehostname kernel: eth0: Tx timed out, lost interrupt?
TSR=0x3, ISR=0x3, t=26.
Jan 13 01:47:17 thehostname kernel: NETDEV WATCHDOG: eth0: transmit
timed out
Jan 13 01:47:17 thehostname kernel: eth0: Tx timed out, lost interrupt?
TSR=0x3, ISR=0x3, t=105.
Jan 13 01:47:24 thehostname kernel: RPC: sendmsg returned error 101
Jan 13 01:47:24 thehostname kernel: nfs: RPC call returned error 101
Jan 13 01:47:24 thehostname kernel: nfs_statfs: statfs error = 101
Jan 13 01:47:37 thehostname kernel: ne2k-pci.c:v1.02 10/19/2000 D.
Becker/P. Gortmaker
Jan 13 01:47:37 thehostname kernel:  
http://www.scyld.com/network/ne2k-pci.html
Jan 13 01:47:37 thehostname kernel: eth0: RealTek RTL-8029 found at
0xe800, IRQ 19, 48:54:E8:21:15:56.
Jan 13 01:47:47 thehostname kernel: NETDEV WATCHDOG: eth0: transmit
timed out
Jan 13 01:47:47 thehostname kernel: eth0: Tx timed out, lost interrupt?
TSR=0x3, ISR=0x3, t=111.
Jan 13 01:47:58 thehostname kernel: NETDEV WATCHDOG: eth0: transmit
timed out
Jan 13 01:47:58 thehostname kernel: eth0: Tx timed out, lost interrupt?
TSR=0x3, ISR=0x3, t=1031.
Jan 13 01:48:00 thehostname kernel: NETDEV WATCHDOG: eth0: transmit
timed out
Jan 13 01:48:00 thehostname kernel: eth0: Tx timed out, lost interrupt?
TSR=0x1, ISR=0x3, t=107.
Jan 13 01:48:04 thehostname kernel: NETDEV WATCHDOG: eth0: transmit
timed out
Jan 13 01:48:04 thehostname kernel: eth0: Tx timed out, lost interrupt?
TSR=0x3, ISR=0x3, t=106.
Jan 13 01:48:08 thehostname kernel: NETDEV WATCHDOG: eth0: transmit
timed out
Jan 13 01:48:08 thehostname kernel: eth0: Tx timed out, lost interrupt?
TSR=0x3, ISR=0x3, t=306.
Jan 13 01:48:10 thehostname kernel: NETDEV WATCHDOG: eth0: transmit
timed out
Jan 13 01:48:10 thehostname kernel: eth0: Tx timed out, lost interrupt?
TSR=0x3, ISR=0x3, t=105.
Jan 13 01:48:24 thehostname kernel: NETDEV WATCHDOG: eth0: transmit
timed out
Jan 13 01:48:24 thehostname kernel: eth0: Tx timed out, lost interrupt?
TSR=0x3, ISR=0x2, t=72.

$ uname -r
2.4.0


lsmod bits:

ne2k-pci                4448   1  (autoclean)
8390                    6544   0  (autoclean) [ne2k-pci]


/proc/pci:
  Bus  0, device  11, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
(rev 0).
      IRQ 19.
      I/O at 0xe800 [0xe81f].

-- 
Darryl Miles
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
