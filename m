Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265999AbUF2TuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265999AbUF2TuJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 15:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265997AbUF2TuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 15:50:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:57558 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265992AbUF2TuB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 15:50:01 -0400
Date: Tue, 29 Jun 2004 12:49:51 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Stephen Hemminger <shemminger@osdl.org>,
       "David S. Miller" <davem@redhat.com>
Cc: Debi Janos <debi.janos@freemail.hu>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: 2.6.7-mm1 - 2.6.7-mm4 weird http behavior
Message-Id: <20040629124951.56de307d@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040629112256.58828632@dell_ss3.pdx.osdl.net>
References: <freemail.20040529152006.85505@fm4.freemail.hu>
	<20040629112256.58828632@dell_ss3.pdx.osdl.net>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the trace output for both cases run against 2.6.7 latest (not -mm)

failing case: packages.gentoo.org

12:37:04.654043 IP 172.20.1.73.32774 > 198.63.211.232.80: S 4165256157:4165256157(0) win 5840 <mss 1460,sackOK,timestamp 2448351 0,nop,wscale 7>
12:37:05.078029 IP 198.63.211.232.80 > 172.20.1.73.32774: S 3946717705:3946717705(0) ack 4165256158 win 5792 <mss 1460,sackOK,timestamp 678388344 2448351,nop,wscale 0>
12:37:05.078069 IP 172.20.1.73.32774 > 198.63.211.232.80: . ack 1 win 45 <nop,nop,timestamp 2448775 678388344>
12:37:05.079000 IP 172.20.1.73.32774 > 198.63.211.232.80: P 1:1340(1339) ack 1 win 45 <nop,nop,timestamp 2448776 678388344>
12:37:05.283359 IP 198.63.211.232.80 > 172.20.1.73.32774: . ack 1340 win 8034 <nop,nop,timestamp 678388392 2448776>

<hung>

12:37:07.960251 IP 172.20.1.73.32773 > 198.63.211.232.80: F 4127965887:4127965887(0) ack 3063226309 win 45 <nop,nop,timestamp 2451658 678381231>
12:37:12.921440 IP 172.20.1.73.32774 > 198.63.211.232.80: F 1340:1340(0) ack 1 win 45 <nop,nop,timestamp 2456620 678388392>
12:37:14.166886 IP 172.20.1.73.32774 > 198.63.211.232.80: F 1340:1340(0) ack 1 win 45 <nop,nop,timestamp 2457865 678388392>


And normal case: osdl.org

12:42:58.249167 IP 172.20.1.73.32777 > 65.172.181.4.80: S 231703769:231703769(0) win 5840 <mss 1460,sackOK,timestamp 2802000 0,nop,wscale 7>
12:42:58.249486 IP 65.172.181.4.80 > 172.20.1.73.32777: S 2426432811:2426432811(0) ack 231703770 win 5792 <mss 1460,sackOK,timestamp 2635537765 2802000,nop,wscale 0>
12:42:58.249511 IP 172.20.1.73.32777 > 65.172.181.4.80: . ack 1 win 45 <nop,nop,timestamp 2802000 2635537765>
12:42:58.251102 IP 172.20.1.73.32777 > 65.172.181.4.80: P 1:1329(1328) ack 1 win 45 <nop,nop,timestamp 2802002 2635537765>
12:42:58.252069 IP 65.172.181.4.80 > 172.20.1.73.32777: . ack 1329 win 7968 <nop,nop,timestamp 2635537768 2802002>
12:42:58.253020 IP 65.172.181.4.80 > 172.20.1.73.32777: P 1:273(272) ack 1329 win 7968 <nop,nop,timestamp 2635537768 2802002>
12:42:58.253037 IP 172.20.1.73.32777 > 65.172.181.4.80: . ack 273 win 45 <nop,nop,timestamp 2802004 2635537768>
12:42:58.253670 IP 65.172.181.4.80 > 172.20.1.73.32777: . 273:1721(1448) ack 1329 win 7968 <nop,nop,timestamp 2635537769 2802002>
12:42:58.253697 IP 172.20.1.73.32777 > 65.172.181.4.80: . ack 1721 win 45 <nop,nop,timestamp 2802004 2635537769>
12:42:58.253790 IP 65.172.181.4.80 > 172.20.1.73.32777: P 1721:3169(1448) ack 1329 win 7968 <nop,nop,timestamp 2635537769 2802002>
12:42:58.253799 IP 172.20.1.73.32777 > 65.172.181.4.80: . ack 3169 win 45 <nop,nop,timestamp 2802005 2635537769>
12:42:58.254041 IP 65.172.181.4.80 > 172.20.1.73.32777: . 3169:4617(1448) ack 1329 win 7968 <nop,nop,timestamp 2635537769 2802004>
<...>
12:42:58.258191 IP 65.172.181.4.80 > 172.20.1.73.32777: P 17649:19097(1448) ack 1329 win 7968 <nop,nop,timestamp 2635537773 2802008>
12:42:58.259106 IP 65.172.181.4.80 > 172.20.1.73.32777: . 19097:20545(1448) ack 1329 win 7968 <nop,nop,timestamp 2635537774 2802009>
12:42:58.259155 IP 172.20.1.73.32777 > 65.172.181.4.80: . ack 20545 win 45 <nop,nop,timestamp 2802010 2635537773>
12:42:58.259166 IP 65.172.181.4.80 > 172.20.1.73.32777: FP 20545:20689(144) ack 1329 win 7968 <nop,nop,timestamp 2635537774 2802009>
12:42:58.262096 IP 172.20.1.73.32777 > 65.172.181.4.80: F 1329:1329(0) ack 20690 win 45 <nop,nop,timestamp 2802013 2635537774>
12:42:58.262357 IP 65.172.181.4.80 > 172.20.1.73.32777: . ack 1330 win 7968 <nop,nop,timestamp 2635537778 2802013>
