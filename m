Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264496AbTLMMAP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 07:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264563AbTLMMAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 07:00:15 -0500
Received: from mail.epost.de ([193.28.100.165]:18597 "EHLO mail.epost.de")
	by vger.kernel.org with ESMTP id S264496AbTLMMAJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 07:00:09 -0500
From: Marcus Blomenkamp <Marcus.Blomenkamp@epost.de>
To: linux-kernel@vger.kernel.org
Subject: r8169 GigE driver problem, locks up 2.4.23 NFS subsystem
Date: Sat, 13 Dec 2003 13:00:05 +0100
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200312131300.05847.Marcus.Blomenkamp@epost.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

Since ugrading from a realtek-8139 based nic to a realtek-6139 gigabit one i 
am experiencing strange network problems. Particularly it locks up the NFS 
subsystem on writing to remote files.

I tried to narrow it down using several TCP/UDP traffic tools such as 
'netpipe' and 'netcat' and different kernel r8169 driver versions. 

I restricted the network to a single 100mbit crossover cable between a machine 
with said gig-nic and a file server which has not been modified yet.

File server:	'kartoffel', RTL-8139, linux-2.4.20
Client machine:	'zwiebel', RTL-8169S, linux-2.4.23-pre9, linux-2.6.0-test11

I tried 2.4.23-pre9 and 2.6.0-test11 vanilla drivers and a special realtek 
supplied version for linux-2.4. With respect to basic TCP and UDP transfer 
their behaviour was identical. However 2.6 NFS subsystem was able to recover 
from the network stalls, while 2.4 NFS did not release processes from 'D' 
state.

My suspicion is that something related to UDP datagram to IP-over-ethernet 
frame fragmentation is broken. TCP transfers in both directions work fine 
while UDP transmissions over a specific datagram size stall after sending a 
few k. 

These objections manifest into NFS running fine over TCP and running fine over 
UDP with wsize<=4096, while standard NFS mount option wsize=8192 fails.

If anyone is interested, i have dmesg output and ethereal log files handy.

Best regards, Marcus

