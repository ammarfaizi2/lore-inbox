Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136469AbRD3H0S>; Mon, 30 Apr 2001 03:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136470AbRD3H0I>; Mon, 30 Apr 2001 03:26:08 -0400
Received: from adsl-63-206-198-42.dsl.snfc21.pacbell.net ([63.206.198.42]:59845
	"EHLO adsl-63-206-198-42.dsl.snfc21.pacbell.net") by vger.kernel.org
	with ESMTP id <S136469AbRD3H0A>; Mon, 30 Apr 2001 03:26:00 -0400
Date: Mon, 30 Apr 2001 00:25:18 -0700 (PDT)
From: Francois Gouget <fgouget@free.fr>
To: linux-kernel@vger.kernel.org
cc: elmer@ylenurme.ee
Subject: Aironet doesn't work
Message-ID: <Pine.LNX.4.21.0104300011070.10183-100000@amboise.dolphin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   Hi,


   I'm having trouble getting a Cisco 340 wireless card to work with the
aironet driver from 2.4.3-ac6. The driver loads fine but then cardmgr
says:

Apr 29 22:37:35 oleron cardmgr[613]: initializing socket 0
Apr 29 22:37:35 oleron cardmgr[613]: socket 0: Aironet PC4800
Apr 29 22:37:35 oleron cardmgr[613]: executing: 'modprobe aironet4500_core'
Apr 29 22:37:35 oleron cardmgr[613]: executing: 'modprobe aironet4500_cs'
Apr 29 22:37:36 oleron cardmgr[613]: get dev info on socket 0 failed: Resource temporarily unavailable

   I'm using the debian pcmcia-cs package version 3.1.22-0.2potato. I
would be happy to help debug this but I won't have the card for long.
Where should I go from there?
   My laptop is a Sony Vaio F560. I also have a 3com pcmcia network card
which works just fine so I know that pcmcia is working. I tried the
cisco card in each socket, with and without the 3com card at the same
time. My /etc/pcmcia/config file says:

--- cut here ---
device "airo_cs"
  class "network" module "aironet4500_core", "aironet4500_cs"
#  class "network" module "airo", "airo_cs"

card "Aironet PC4500"
  manfid 0x015f, 0x0005
  bind "airo_cs"

card "Aironet PC4800"
  manfid 0x015f, 0x0007
  bind "airo_cs"
--- cut here ---

   Actually I also had to apply the following patch to get rid of
missing symbol errors when loading the driver. 

--- cut here ---
--- linux-2.4.3-ac6.orig/drivers/net/aironet4500_core.c Sun Apr 22 17:05:52 2001
+++ linux-2.4.3-ac6/drivers/net/aironet4500_core.c      Sun Apr 15 12:50:25 2001
@@ -2546,10 +2546,10 @@
 static int p802_11_send; // 1
 
 static int awc_process_tx_results;
-int tx_queue_len = 10;
+int rx_queue_len = 10;
 int tx_rate;
 int channel = 5;
-//static int tx_full_rate;
+static int tx_full_rate;
 int max_mtu = 2312;
 int adhoc;
 int large_buff_mem = 1700 * 10;
--- cut here ---


--
Francois Gouget         fgouget@free.fr        http://fgouget.free.fr/
     The software said it requires Win95 or better, so I installed Linux.

