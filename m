Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263536AbRFRGJJ>; Mon, 18 Jun 2001 02:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263557AbRFRGI7>; Mon, 18 Jun 2001 02:08:59 -0400
Received: from AGrenoble-101-1-1-226.abo.wanadoo.fr ([193.251.23.226]:34995
	"EHLO lyon.ram.loc") by vger.kernel.org with ESMTP
	id <S263536AbRFRGIl>; Mon, 18 Jun 2001 02:08:41 -0400
To: linux-kernel@vger.kernel.org
From: Raphael_Manfredi@pobox.com (Raphael Manfredi)
Subject: Re: Longstanding APIC/NE2K bug
Date: 18 Jun 2001 06:08:37 GMT
Organization: Home, Grenoble, France
Message-ID: <9gk5t5$pbl$1@lyon.ram.loc>
In-Reply-To: <20010617000645.A2022@zarq.dhs.org>
X-Newsreader: trn 4.0-test74 (May 26, 2000)
In-Reply-To: <20010617000645.A2022@zarq.dhs.org>
X-Mailer: newsgate 1.0 at lyon.ram.loc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting rc@zarq.dhs.org from ml.linux.kernel:
:There has been a bug in the 2.4.x series of kernels for a long time (at
:least -pre9) concerning SMP and ne2k-pci.
:
:Symptoms: Network driver locks up.  Repeated messages of "ETH0: Transmit
:timeout" occurs.  Unloading and reloading network drivers does not help,
:reboot is required.  Usually only triggered by heavy network traffic
:(300-400 megs at 700k or so usually does it).

I concur.  This happened to me tonight with:

	Linux nice 2.4.4-ac9 #1 SMP Wed May 16 16:17:59 MEST 2001 i686 unknown

Here's the syslogs, flushed to the remote loghost machine somehow,
before the network became dead (closed connections, at the end of the
logs).

NB: It all started with an APIC error (unexpected IRQ trap, meaning
an error that passed through checksum controls).

Raphael

The logs:

Jun 18 04:36:23 nice kernel: unexpected IRQ trap at vector 7d 
Jun 18 04:36:35 nice kernel: NETDEV WATCHDOG: eth0: transmit timed out 
Jun 18 04:36:35 nice kernel: eth0: Tx queue start entry 11638512  dirty entry 11638508. 
Jun 18 04:36:47 nice kernel: eth0:  Tx descriptor 0 is 00002000. (queue head) 
Jun 18 04:36:47 nice kernel: eth0:  Tx descriptor 1 is 00002000. 
Jun 18 04:36:47 nice kernel: eth0:  Tx descriptor 2 is 00002000. 
Jun 18 04:36:47 nice kernel: eth0:  Tx descriptor 3 is 00002000. 
Jun 18 04:36:59 nice kernel: eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 45e1. 
Jun 18 04:37:11 nice kernel: NETDEV WATCHDOG: eth0: transmit timed out 
Jun 18 04:37:23 nice kernel: eth0:  Tx descriptor 0 is 00002000. (queue head) 
Jun 18 04:37:23 nice kernel: eth0:  Tx descriptor 1 is 00002000. 
Jun 18 04:37:23 nice kernel: eth0:  Tx descriptor 2 is 00002000. 
Jun 18 04:37:23 nice kernel: eth0: Tx queue start entry 4  dirty entry 0. 
Jun 18 04:37:35 nice kernel: eth0:  Tx descriptor 3 is 00002000. 
Jun 18 04:37:35 nice kernel: eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 45e1. 
Jun 18 04:38:11 nice kernel: NETDEV WATCHDOG: eth0: transmit timed out 
Jun 18 04:38:25 nice kernel: eth0:  Tx descriptor 0 is 00002000. (queue head) 
Jun 18 04:38:25 nice kernel: eth0:  Tx descriptor 1 is 00002000. 
Jun 18 04:38:25 nice kernel: eth0:  Tx descriptor 2 is 00002000. 
Jun 18 04:38:25 nice kernel: eth0: Tx queue start entry 4  dirty entry 0. 
Jun 18 04:38:35 nice kernel: eth0:  Tx descriptor 3 is 00002000. 
Jun 18 04:38:35 nice kernel: eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 45e1. 
Jun 18 04:38:47 nice kernel: nfs: server lyon not responding, still trying 
Jun 18 04:38:59 nice kernel: NETDEV WATCHDOG: eth0: transmit timed out 
Jun 18 04:38:59 nice kernel: eth0: Tx queue start entry 4  dirty entry 0. 
Jun 18 04:39:11 nice kernel: eth0:  Tx descriptor 0 is 00002000. (queue head) 
Jun 18 04:39:11 nice kernel: eth0:  Tx descriptor 1 is 00002000. 
Jun 18 04:39:11 nice kernel: eth0:  Tx descriptor 2 is 00002000. 
Jun 18 04:39:11 nice kernel: eth0:  Tx descriptor 3 is 00002000. 
Jun 18 04:39:23 nice kernel: eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 45e1. 
Jun 18 04:39:35 nice kernel: NETDEV WATCHDOG: eth0: transmit timed out 
Jun 18 04:39:35 nice kernel: eth0:  Tx descriptor 0 is 00002000. (queue head) 
Jun 18 04:39:35 nice kernel: eth0: Tx queue start entry 4  dirty entry 0. 
Jun 18 04:39:47 nice kernel: eth0:  Tx descriptor 1 is 00002000. 
Jun 18 04:39:47 nice kernel: eth0:  Tx descriptor 2 is 00002000. 
Jun 18 04:39:47 nice kernel: eth0:  Tx descriptor 3 is 00002000. 
Jun 18 04:39:59 nice kernel: eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 45e1. 
Jun 18 04:52:08 paris sshd[12120]: fatal: Read error from remote host: Connection timed out 
Jun 18 04:52:10 lyon sshd[800]: fatal: Read error from remote host: Connection timed out
Jun 18 04:54:03 lyon smbd[10932]: [2001/06/18 04:54:03, 0] lib/util_sock.c:read_socket_data(477) 
Jun 18 04:56:31 lyon sshd[997]: fatal: Read error from remote host: Connection timed out
